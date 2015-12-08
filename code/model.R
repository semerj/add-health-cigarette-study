library(gee)
library(geepack)
library(lme4)

source('./utils.R')
load('../data/add_cig.RData')

################################################################################
##############################  Cigarette models  ##############################
################################################################################
# Baseline covariates
#   - sex
#   - CESD_0
# Time-varying covariates
#   - age
#   - CESD_diff

# formulas
add_cig$age_13     = add_cig$age - 13
fm0 = cigarettes ~ CESD_0 + CESD_diff + sex + age_13

# logistic regression
glm_m0 = glm(fm0, family='binomial', data=add_cig)

# GEE/marginal model
gee_ind =  geeglm(fm0, family='binomial', data=add_cig, id=AID, corstr='independence')
gee_ind2 = gee(fm0,    family='binomial', data=add_cig, id=AID, corstr='independence')
gee_exc =  geeglm(fm0, family='binomial', data=add_cig, id=AID, corstr='exchangeable')
gee_exc2 = gee(fm0,    family='binomial', data=add_cig, id=AID, corstr='exchangeable')

# simple random effects
mix_m0 = glmer(update(fm0, ~ . + (1|AID)),
               family='binomial', data=add_cig,
               control=glmerControl(optimizer="bobyqa", optCtrl=list(maxfun=2e5)))

# logistic regression - should be the same as GEE w/ independence
summary(glm_m0)
OR(glm_m0,   'glm',    se='naive')  # Logistic Regression with naive SE
OR(glm_m0,   'glm',    se='robust', id=add_cig$AID)  # Logistic Regression with robust SE (cluster SE)

# GEE
summary(gee_ind)
summary(gee_ind2)
summary(gee_exc)
summary(gee_exc2)
OR(gee_ind2, 'gee',    se='naive')  # independent correlation w/ naive SE
OR(gee_ind,  'geeglm', se='robust') # independent correlation w/ robust SE
OR(gee_exc2, 'gee',    se='naive')  # exchangeable correlation w/ naive SE
OR(gee_exc,  'geeglm', se='robust') # exchangeable correlation w/ robust SE

# simple random effects
summary(mix_m0)
OR(mix_m0,   'glmer',  se='naive')

# pretty-print results for simple random effects and get intra-class correlation (ICC)
# library(sjPlot)
# sjt.glmer(mix_m0)