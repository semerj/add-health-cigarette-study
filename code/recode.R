add = read.csv('../data/add_merge.csv')

################################################################################
##############################  Response variable  #############################
################################################################################
# CESD: numeric
add = add[add$disliked   %in% 0:3 &
          add$sad        %in% 0:3 &
          add$enjoy_life %in% 0:3 &
          add$tired      %in% 0:3 &
          add$bothered   %in% 0:3 &
          add$blues      %in% 0:3 &
          add$not_good   %in% 0:3 &
          add$depressed  %in% 0:3, ]

# Reverse code enjoy_life
add$enjoy_life = ifelse(add$enjoy_life == 3, 0,
                        ifelse(add$enjoy_life == 2, 1,
                               ifelse(add$enjoy_life == 1, 2, 3)))

add$CESD = with(add, disliked + sad + enjoy_life + tired +
                     bothered + blues + not_good + depressed)

################################################################################
############################  Baseline covariates  #############################
################################################################################
# Sex: categorical
add$sex = ifelse(add$sex == 1, 0, 1)
add$sex = as.factor(add$sex)

# Race: categorical
add$race = ifelse(add$H1GI4  == 1, 1, NA)        # Hispanic, All Races
add$race = ifelse(add$H1GI6B == 1, 2, add$race)  # Black or African American, Non-Hispanic
add$race = ifelse(add$H1GI6D == 1, 3, add$race)  # Asian, Non-Hispanic
add$race = ifelse(add$H1GI6C == 1, 4, add$race)  # Native American, Non-Hispanic
add$race = ifelse(add$H1GI6E == 1, 5, add$race)  # Other, Non-Hispanic
add$race = ifelse(add$H1GI6A == 1, 0, add$race)  # White, Non-Hispanic

# Parent_ed: categorical
add$parent1_ed = add$PA12 # How far did you go in school?
add$parent2_ed = add$PB8  # How far did your current (spouse/partner) go in school?

################################################################################
################################ Time covariate  ###############################
################################################################################
# Wave: categorical
add$wave = as.factor(add$wave)

################################################################################
##########################  Longitudinal covariates  ###########################
################################################################################
# Age: numeric
add$year = as.numeric(ifelse(add$wave %in% c(1,2), paste0(19, add$year), add$year))
add$date = with(add, as.Date(paste0(month, "-", day, "-", year), format="%m-%d-%Y"))
add$bday = as.Date(paste0(add$bday_m, "-15-19", add$bday_y), format="%m-%d-%Y")
add$age = with(add, round(as.numeric(difftime(date, bday)/365.25), 1))

# Cigarettes: binary
# 0 == skip or 0 cigarettes
# Dichotomized to indicate whether individuals smoked on all the past 30 days
add$cigarettes = ifelse(add$cigarettes %in% c(97, 997), 0, add$cigarettes)
add$cigarettes = ifelse(add$cigarettes == 30, 1, add$cigarettes)
add = add[add$cigarettes %in% c(0,1),]
add$cigarettes = as.factor(add$cigarettes)

# Drunk: binary
drunk_table = data.frame(code_12 = c(7:1), code_34 = c(0:6))
drunk_vlookup = function(val, df, col) {
  df[df[1] == val, col][1]
}
drunk_codes_34 = sapply(add[add$drunk %in% c(1:7) & add$wave %in% c(1,2), "drunk"],
                        function(x) drunk_vlookup(x, drunk_table, "code_34"))
add[add$drunk %in% c(1:7) & add$wave %in% c(1,2), "drunk"] = drunk_codes_34
add = add[add$drunk %in% c(0:6, 97),]
add$drunk = ifelse(add$drunk == 97, 0, add$drunk)  # legitmate skip == no drunk?
add$drunk = ifelse(add$drunk %in%  0, 0, 1)        # dichotomize
add$drunk = as.factor(add$drunk)

# Drink: binary
drink_codes_34 = sapply(add[add$drink %in% c(1:7) & add$wave %in% c(1,2), "drink"],
                        function(x) drunk_vlookup(x, drunk_table, "code_34"))
add[add$drink %in% c(1:7) & add$wave %in% c(1,2), "drink"] = drink_codes_34
add = add[add$drink %in% c(0:6, 97),]
add$drink = ifelse(add$drink == 97, 0, add$drink)  # legitmate skip == no drink?
add$drink = ifelse(add$drink %in%  0, 0, 1)        # dichotomize
add$drink = as.factor(add$drink)

# Marijuana: binary
add[add$wave %in% c(1,2) & add$marijuana > 0 & add$marijuana < 900, "marijuana"] = 1
add[add$wave == 3 & add$marijuana > 0 & add$marijuana < 900, 'marijuana'] = 1
add[add$wave == 4 & add$marijuana > 0 & add$marijuana < 7, 'marijuana'] = 1
add = add[(add$wave %in% c(1,2) & add$marijuana %in% c(0,1,997)) |
            (add$wave == 3 & add$marijuana %in% c(0,1,9997)) |
            (add$wave == 4 & add$marijuana %in% c(0,1,97)), ]
add$marijuana = ifelse(!(add$marijuana %in% c(0,1)), 97, add$marijuana)
add$marijuana = ifelse(add$marijuana == 97, 0, add$marijuana) # legimate skip == 0
add$marijuana = as.factor(add$marijuana)

################################################################################
###############################  Missing data  #################################
################################################################################
add = add[complete.cases(add),]  # apply(add, 2, function(x) sum(is.na(x)))


# Write to csv
cols = c("AID", "CESD", "wave", "sex", "race", "cigarettes", "marijuana",
         "drunk", "drink", "age")
write.csv(add[,cols], '../data/add_recode.csv', row.names = FALSE)