library(dplyr)

load('../data/add_merge.RData')

################################################################################
##############################  Response variable  #############################
################################################################################
# Cigarettes: binary
# 0 == skip or 0 cigarettes
# Dichotomized to indicate whether individuals smoked on all the past 30 days
add$cigarettes = ifelse(add$cigarettes %in% c(97, 997), 0, add$cigarettes)
add$cigarettes = ifelse(add$cigarettes == 30, 1, add$cigarettes)
add = add[add$cigarettes %in% c(0,1),]
add$cigarettes = as.factor(add$cigarettes)

################################################################################
############################  Baseline covariates  #############################
################################################################################
# Sex: categorical
add$sex = ifelse(add$sex == 1, "male", "female")
add$sex = as.factor(add$sex)

# Race: categorical
add$race = ifelse(add$H1GI4  == 1, "hispanic all races", NA)
add$race = ifelse(add$H1GI6B == 1, "african american", add$race)
add$race = ifelse(add$H1GI6D == 1, "asian non-hispanic", add$race)
add$race = ifelse(add$H1GI6C == 1, "native american", add$race)
add$race = ifelse(add$H1GI6E == 1, "other non-hispanic", add$race)
add$race = ifelse(add$H1GI6A == 1, "white non-hispanic", add$race)

################################################################################
##########################  Longitudinal covariates  ###########################
################################################################################
# CESD: numeric
add = add[add$disliked   %in% 0:3 & add$sad        %in% 0:3 &
          add$enjoy_life %in% 0:3 & add$tired      %in% 0:3 &
          add$bothered   %in% 0:3 & add$blues      %in% 0:3 &
          add$not_good   %in% 0:3 & add$depressed  %in% 0:3, ]

# Reverse code enjoy_life
add$enjoy_life = ifelse(add$enjoy_life == 3, 0,
                        ifelse(add$enjoy_life == 2, 1,
                               ifelse(add$enjoy_life == 1, 2, 3)))

add$CESD = with(add, disliked + sad + enjoy_life + tired +
                  bothered + blues + not_good + depressed)

# Age: numeric
add$year = as.numeric(ifelse(add$wave %in% c(1,2), paste0(19, add$year), add$year))
add$date = with(add, as.Date(paste0(month, "-", day, "-", year), format="%m-%d-%Y"))
add$bday = as.Date(paste0(add$bday_m, "-15-19", add$bday_y), format="%m-%d-%Y")
add$age = with(add, round(as.numeric(difftime(date, bday)/365.25), 1))

# Drink: binary
drink_table = data.frame(code_12 = c(7:1), code_34 = c(0:6))
drink_vlookup = function(val, df, col) {
  df[df[1] == val, col][1]
}

drink_codes_34 = sapply(add[add$drink %in% c(1:7) & add$wave %in% c(1,2), "drink"],
                        function(x) drink_vlookup(x, drink_table, "code_34"))
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
##############################  Cigarette Data  ################################
################################################################################

complete_cases = add %>%
  group_by(AID) %>%
  tally() %>%
  ungroup() %>%
  filter(n == 4) %>%
  select(AID) %>%
  inner_join(
    add %>% filter(age > 13 & age <= 15)
  )


add_cig = add %>%
  select(AID, CESD, wave, sex, race, cigarettes, age) %>%
  filter(wave %in% 2:4) %>%
  inner_join(
    # create baseline depression variable
    add %>%
      filter(wave == 1) %>%
      group_by(AID) %>%
      mutate(
        CESD_0 = CESD
      ) %>%
      select(AID, CESD_0),
    by = c('AID' = 'AID')
  ) %>%
  mutate(wave = as.factor(wave),
         cigarettes = as.numeric(as.character(cigarettes)),
         race = factor(race,
                       levels = c('white non-hispanic', 'african american',
                                  'asian non-hispanic', 'hispanic all races',
                                  'native american', 'other non-hispanic')),
         CESD_diff = CESD - CESD_0,
         CESD_ntile = ntile(CESD_0, 5)
  ) %>%
  select(AID, cigarettes, wave, age, sex, CESD, race, CESD_diff, CESD_0, CESD_ntile) %>%
  arrange(AID, wave) %>%
  filter(AID %in% complete_cases$AID)

add_waves = add %>%
  select(AID, CESD, wave, sex, race, cigarettes, age) %>%
  mutate(wave = as.factor(wave),
         cigarettes = as.numeric(as.character(cigarettes)),
         race = factor(race,
                       levels = c('white non-hispanic', 'african american',
                                  'asian non-hispanic', 'hispanic all races',
                                  'native american', 'other non-hispanic'))
         ) %>%
  select(AID, cigarettes, wave, age, sex, CESD, race) %>%
  arrange(AID, wave) %>%
  filter(AID %in% complete_cases$AID)


save(add_cig, file='../data/add_cig.RData')
save(add_waves, file='../data/add_waves.RData')