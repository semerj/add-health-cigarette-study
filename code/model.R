library(dplyr)
library(tidyr)
library(gee)
library(geepack)
library(lme4)

load('../data/add_recode.RData')

# Include cases present in all 4 waves
# add = add %>%
#   group_by(AID) %>%
#   summarize(count=n()) %>%
#   filter(count == 4) %>%
#   select(AID) %>%
#   inner_join(add, on=c('AID' = 'AID')) %>%
#   arrange(AID, wave)

################################################################################
##############################  Cigarette model  ###############################
################################################################################

add_cig = add %>%
  filter(wave %in% 2:4) %>%
  inner_join(
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
         CESD_diff = CESD - CESD_0
         ) %>%
  select(cigarettes, AID, wave, age, sex, CESD, race, CESD_diff, CESD_0)

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
fm = cigarettes ~ sex + age + wave + CESD_0 + CESD_diff
fm_mix = update(fm, ~ . + (1|AID))

# cross-sectional model
glm_m   = glm(fm,       family='binomial', data=add_cig)

# marginal model
gee_ind = geeglm(fm,    family='binomial', data=add_cig, id=AID, corstr='independence')
gee_exc = geeglm(fm,    family='binomial', data=add_cig, id=AID, corstr='exchangeable')
gee_ar  = geeglm(fm,    family='binomial', data=add_cig, id=AID, corstr='ar1')

# mixed effects model
# help w/ convergence: https://rstudio-pubs-static.s3.amazonaws.com/33653_57fc7b8e5d484c909b615d8633c01d51.html
mix_m   = glmer(fm_mix, family='binomial', data=add_cig,
                control=glmerControl(optimizer="bobyqa", optCtrl=list(maxfun=2e5)))

summary(glm_m)
summary(gee_ind)
summary(gee_exc)
summary(gee_ar)
summary(mix_m)