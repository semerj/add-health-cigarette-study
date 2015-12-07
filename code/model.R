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
add_cig$age_scaled = scale(add_cig$age)
add_cig$age_min = add_cig$age - min(add_cig$age)
add_cig$age_13 = add_cig$age - 13
fm0 = cigarettes ~ sex + age_13 + CESD_0 + CESD_diff

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
# add_cig$age_scaled = scale(add_cig$age)
# age mean: 22.2
# age sd:   5.15
mix_m0 = glmer(cigarettes ~ sex + age_13 + CESD_0 + CESD_diff + (1|AID),
               family='binomial', data=add_cig,
               control=glmerControl(optimizer="bobyqa", optCtrl=list(maxfun=2e5)))

summary(glm_m0)
summary(gee_ind)
summary(gee_ind2)
summary(gee_exc)
summary(gee_exc2)
summary(mix_m0)
# library(sjPlot)
# sjt.glmer(mix_m0)

AID_mean = coefficients(summary(mix_m0))[1,1]
AID_ranef = ranef(mix_m0)$AID
AID_ranef_sd = sqrt(VarCorr(mix_m0)$AID[[1]])
plot(density((AID_ranef + AID_mean)[,1]))
plot(density(rnorm(1000, AID_mean, AID_ranef_sd)))
AID_ranef_df = data.frame(range=seq(-40,20,0.1),
                          value=dnorm(range, mean=AID_mean, sd=AID_ranef_sd))
ggplot(AID_ranef_df, aes(x=range, y=value)) +
  geom_line() + theme_bw() + xlab("Log-Odds") +
  geom_vline(x=0, col='red') +
  annotate("text", x=-30, y=0.04,
           label=paste0('Mean: ', round(AID_mean, 2), '\n',
                        'SD: ', round(AID_ranef_sd, 2))) +
  ggtitle('Distribution of Log-Odds for Subject-Specific Random Intercept')


# summary(mix_m1)

OR(glm_m0,   'glm',    se='naive')  # Logistic Regression with naive SE
OR(glm_m0,   'glm',    se='robust', id=add_cig$AID)  # Logistic Regression with robust SE (cluster SE)
OR(gee_ind,  'geeglm', se='robust') # GEE w/ independent correlation and robust SE
# OR(gee_ind2, 'gee',    se='robust') # GEE w/ independent correlation and robust SE
OR(gee_ind2, 'gee',    se='naive')  # GEE w/ independent correlation and naive SE
OR(gee_exc,  'geeglm', se='robust') # GEE w/ exchangeable correlation and robust SE
# OR(gee_exc2, 'gee',    se='robust') # GEE w/ exchangeable correlation and robust SE
OR(gee_exc2, 'gee',    se='naive')  # GEE w/ exchangeable correlation and naive SE
OR(mix_m0,   'glmer',  se='naive')  # Simple Random Effects
# OR(mix_m1,   'glmer',  se='naive')  # Mixed Effects w/ random intercept and longitudinal effect
