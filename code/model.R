library(dplyr)
library(tidyr)
library(gee)
library(geepack)
library(lme4)
library(arm)

source('./utils.R')
load('../data/add_cig.RData')

################################################################################
##############################  Cigarette models  ##############################
################################################################################
# time-dependent predictors
#   - wave
#   - age
# time-independent predictors
#   - sex
#   - CESD_0
# Time-varying covariates
#   - CESD_diff

# formulas
# fm1 = cigarettes ~ sex + age * wave + CESD_0 + CESD_diff
fm0 = cigarettes ~ sex + CESD_0 + CESD_diff + age

# cross-sectional model
glm_m0 = glm(fm0, family='binomial', data=add_cig)

# marginal model
gee_ind =  geeglm(fm0, family='binomial', data=add_cig, id=AID, corstr='independence')
gee_ind2 = gee(fm0,    family='binomial', data=add_cig, id=AID, corstr='independence')
gee_exc =  geeglm(fm0, family='binomial', data=add_cig, id=AID, corstr='exchangeable')
gee_exc2 = gee(fm0,    family='binomial', data=add_cig, id=AID, corstr='exchangeable')
# gee_ar =   geeglm(fm0, family='binomial', data=add_cig, id=AID, corstr='ar1')
# gee_ar2 =  gee(fm0,    family='binomial', data=add_cig, id=AID, corstr='AR-M')

# mixed effects model
# help w/ convergence: https://rstudio-pubs-static.s3.amazonaws.com/33653_57fc7b8e5d484c909b615d8633c01d51.html
fm_mix = cigarettes ~ sex + CESD_0 + CESD_diff
mix_m0 = glmer(update(fm_mix, ~ . + (1|AID)),
               family='binomial', data=add_cig,
               control=glmerControl(optimizer="bobyqa", optCtrl=list(maxfun=2e5)))

mix_m1 = glmer(update(fm_mix, ~ . + (1 + CESD_diff|AID)),
               family='binomial', data=add_cig,
               control=glmerControl(optimizer="bobyqa", optCtrl=list(maxfun=2e5)))
#
# mix_m2 = glmer(update(fm_mix, ~ . + (1|wave)),
#                family='binomial', data=add_cig)
#
# mix_m3 = glmer(update(fm_mix, ~ . + (1|CESD_0)),
#                family='binomial', data=add_cig)
#
# mix_m4 = glmer(update(fm_mix, ~ . + (1|sex)),
#                family='binomial', data=add_cig)

summary(glm_m0)
summary(gee_ind)
summary(gee_ind2)
summary(gee_exc)
summary(gee_exc2)
summary(mix_m0)
summary(mix_m1)

OR(glm_m0,   'glm',    se='naive')  # Logistic Regression with naive SE
OR(glm_m0,   'glm',    se='robust', id=add_cig$AID)  # Logistic Regression with robust SE (cluster SE)
OR(gee_ind,  'geeglm', se='robust') # GEE w/ independent correlation and robust SE
OR(gee_ind2, 'gee',    se='robust') # GEE w/ independent correlation and robust SE
OR(gee_ind2, 'gee',    se='naive')  # GEE w/ independent correlation and naive SE
OR(gee_exc,  'geeglm', se='robust') # GEE w/ exchangeable correlation and robust SE
OR(gee_exc2, 'gee',    se='robust') # GEE w/ exchangeable correlation and robust SE
OR(gee_exc2, 'gee',    se='naive')  # GEE w/ exchangeable correlation and naive SE
OR(mix_m0,   'glmer',  se='naive')  # Simple Random Effects
OR(mix_m1,   'glmer',  se='naive')  # Mixed Effects w/ random intercept and longitudinal effect
