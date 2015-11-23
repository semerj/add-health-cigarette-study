source('merge_data.R')
library(lme4)
library(geepack)


# Remove observations with missing data
add$weight = with(add, ifelse(weight %in% c(996, 998, 999), NA, weight))

# Change column types
add$drunk = as.factor(add$drunk)
add$intercourse = as.factor(add$intercourse)
add$depressed = as.factor(add$depressed)
add$H1GI8 = as.factor(add$H1GI8)

# Convert type to date and find age at each wave in study
add$year = ifelse(add$wave %in% c(1,2), paste0(19, add$year), add$year)
add$date = with(add, as.Date(paste0(month, "-", day, "-", year), format="%m-%d-%Y"))
add$bday = as.Date(paste0(add$H1GI1M, "-15-19", add$H1GI1Y), format="%m-%d-%Y")
add$age = with(add, round(as.numeric(difftime(date, bday)/365.25), 1))

# Recode variables
add$mostly_depressed = with(add, ifelse(depressed %in% c(2, 3), 1, 0))

# Remove rows with NA values
# apply(add, 2, function(x) sum(is.na(x)))
add = add[complete.cases(add),]

# Create models
glm_model = glm(mostly_depressed ~ weight + age + drunk + intercourse,
                data = add, family="binomial")

gee_model = geeglm(mostly_depressed ~ weight + age + drunk + intercourse,
                   id = AID, corstr = 'exchangeable', waves = wave,
                   data = add, family="binomial")

me_model  = glmer(mostly_depressed ~ weight + age + drunk + intercourse + (1|AID),
                  data = add, family="binomial")