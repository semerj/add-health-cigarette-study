library(lme4)
library(geepack)

add = read.csv('../data/add_recode.csv')

add$CESD = as.numeric(add$CESD)
add$age = as.numeric(add$age)
add$sex = as.factor(add$sex)
add$wave = as.factor(add$wave)
add$drink = as.factor(add$drink)
add$drunk = as.factor(add$drunk)
add$marijuana = as.factor(add$marijuana)
add$cigarettes = as.factor(add$cigarettes)

################################################################################
###################################  Models  ###################################
################################################################################

# Linear Regression
model_glm = glm(CESD ~ wave + sex + age + drink + marijuana + cigarettes,
                family="gaussian",
                data = add)
summary(model_glm)

# GEE - exchangeable
m_gee_exc = geeglm(CESD ~ wave + age + sex + drink + marijuana + cigarettes,
                   id=AID,
                   corstr='exchangeable',
                   waves=wave,
                   family="gaussian",
                   data=add)
summary(m_gee_exc)

# GEE - indepedent
m_gee_ind = geeglm(CESD ~ wave + age + sex + drink + marijuana + cigarettes,
                   id=AID,
                   corstr='independence',
                   waves=wave,
                   family="gaussian",
                   data=add)
summary(m_gee_ind)

# Mixed Effects
m_mix = lmer(CESD ~ age + sex + drink + marijuana + cigarettes + (1|AID),
             data=add)
summary(m_mix)