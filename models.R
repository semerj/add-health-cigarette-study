library(lme4)
library(geepack)

# Read csv
add = read.csv('add_data.csv')

# Age
add$year = as.numeric(ifelse(add$wave %in% c(1,2), paste0(19, add$year), add$year))
add$date = with(add, as.Date(paste0(month, "-", day, "-", year), format="%m-%d-%Y"))
add$bday = as.Date(paste0(add$H1GI1M, "-15-19", add$H1GI1Y), format="%m-%d-%Y")
add$age = with(add, round(as.numeric(difftime(date, bday)/365.25), 1))

# Intercourse
# How old were you the first time you had vaginal intercourse?
colnames(add)[colnames(add) == "H3SE2"] = 'vaginal'
add = add[(add$vaginal >= 10 & add$vaginal <= 25) | add$vaginal == 97,]

# Drunk (ordinal)
drunk_table = data.frame(code_12 = c(7:1), code_34 = c(0:6))
drunk_vlookup = function(val, df, col) {
  df[df[1] == val, col][1]
}

drunk_codes_34 = sapply(add[add$drunk %in% c(1:7) & add$wave %in% c(1,2), "drunk"],
                        function(x) drunk_vlookup(x, drunk_table, "code_34"))
add[add$drunk %in% c(1:7) & add$wave %in% c(1,2), "drunk"] = drunk_codes_34
add = add[add$drunk %in% c(0:6, 97),]
add$drunk = as.factor(add$drunk)

# Depressed
add$depressed = as.factor(add$depressed)

# Race
colnames(add)[colnames(add) == "H3SE2"] = 'race'
add$race = as.factor(add$race)

# Weight
add$weight = with(add, ifelse(weight %in% c(996, 998, 999), NA, weight))

# Mostly depressed
add$mostly_depressed = with(add, ifelse(depressed %in% c(2, 3), 1, 0))

# Marijuana
add[add$wave %in% c(1,2) & add$marijuana > 0 & add$marijuana < 900, "marijuana"] = 1
add[add$wave == 3 & add$marijuana > 0 & add$marijuana < 900, 'marijuana'] = 1
add[add$wave == 4 & add$marijuana > 0 & add$marijuana < 7, 'marijuana'] = 1

add = add[(add$wave %in% c(1,2) & add$marijuana %in% c(0,1,997)) |
          (add$wave == 3 & add$marijuana %in% c(0,1,9997)) |
          (add$wave == 4 & add$marijuana %in% c(0,1,97)), ]

add$marijuana = ifelse(!(add$marijuana %in% c(0,1)), 97, add$marijuana)

# Remove observations with missing data
# apply(add, 2, function(x) sum(is.na(x)))
add = add[complete.cases(add),]

# Create models
model_glm = glm(mostly_depressed ~ year + age + drunk + vaginal,
                data = add, family="binomial")

model_gee_exc = geeglm(mostly_depressed ~ age + drunk + marijauna + vaginal,
                       id = AID, corstr = 'exchangeable', waves = wave,
                       data = add, family="binomial")

model_gee_ind = geeglm(mostly_depressed ~ age + drunk + marijauna + vaginal,
                       id = AID, corstr = 'independence', waves = wave,
                       data = add, family="binomial")

model_mix = glmer(mostly_depressed ~ age + drunk + marijauna + vaginal + (1|AID),
                  data = add, family="binomial")