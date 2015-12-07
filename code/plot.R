library(ggplot2)
library(tidyr)
library(dplyr)
library(scales)

load('../data/add_cig.RData')
load('../data/add_waves.RData')

################################################################################
###################################  Plots  ####################################
################################################################################

ggplot(add_waves, aes(x=age, y=CESD, col=sex)) +
  geom_smooth(method='loess') +
  coord_cartesian(ylim=c(0,10)) +
  facet_wrap(~cigarettes) +
  theme_bw() +
  ylab('Depression Score (CES-D)') + xlab('Age') +
  ggtitle('Depression Score by Sex, Cigarette Smoking Status, and Age')

add_cig %>%
  ggplot(aes(x = CESD_0, col = cigarettes)) +
  geom_density() +
  facet_wrap(~wave) +
  xlab('Baseline Depression (at Wave 1)') +
  ggtitle('Distribution of Baseline Depression by Cigarette Smoking Status and Study Wave')

# Proportion of smokers by wave & sex
add_waves %>%
  group_by(wave, sex, cigarettes) %>%
  tally() %>%
  group_by(wave, sex) %>%
  mutate(Percent = n/sum(n)) %>%
  filter(cigarettes == 1) %>%
  ggplot(aes(x = wave, y = Percent, col = sex, group=sex)) +
  geom_line() +
  scale_y_continuous(labels=percent) + xlab('Wave') +
  theme_bw() +
  ggtitle('Proportion of Cigarette Smokers by Study Wave')

add_waves %>%
  mutate(age = round(age,0)) %>%
  group_by(age, sex, cigarettes) %>%
  tally() %>%
  group_by(age, sex) %>%
  mutate(Percent = n/sum(n)) %>%
  filter(cigarettes == 1) %>%
  ggplot(aes(x = age, y = Percent, col = sex, group = sex)) +
  geom_smooth(method='loess', span=1) +
  theme_bw() +
  scale_y_continuous(labels=percent) + xlab('Age') +
  coord_cartesian(ylim=c(0,0.4)) +
  ggtitle('Proportion of Cigarette Smokers by Age')


# Each sex should have it's own intercept
add_waves %>%
  head(200) %>%
  ggplot(aes(x = age, y = CESD, group = AID, col = as.factor(AID))) +
  geom_line(position=position_jitter(w = 0, h = 0.2)) +
  theme_bw() +
  theme(legend.position='none') +
  ylab('Depression Score') + xlab('Age') +
  facet_wrap(~sex) +
  ggtitle('Depression Score (CES-D) by Age\nRandom Sample of 50 subjects')

# Depression went up during the second wave of the study for individuals that
# smoked during the baseline period
add_waves %>%
  group_by(wave, cigarettes, sex) %>%
  summarize(
    n = n(),
    mean = mean(CESD),
    sd = sd(CESD),
    se = sd/sqrt(n),
    ci = se * qt(0.95/2 + 0.5, df=n-1)
    ) %>%
  ungroup() %>%
  mutate(cigarettes = as.factor(cigarettes)) %>%
  ggplot(aes(x = wave, y = mean, col = cigarettes, group = cigarettes)) +
  geom_errorbar(aes(ymin=mean-ci, ymax=mean+ci), width=.1) +
  geom_line() +
  theme_bw() +
  facet_grid(.~sex) +
  ylab('Mean Depression Score (CES-D)') +
  ggtitle('Mean Depression and 95% CI by Sex and Cigarette Smoking Status')


# Save as above
mu = add_cig %>%
  group_by(wave, cigarettes) %>%
  summarize(mean = median(CESD_diff)) %>%
  mutate(cigarettes = as.factor(cigarettes))
ggplot(add_cig, aes(x = CESD_diff, fill = as.factor(cigarettes), group = cigarettes)) +
  # geom_density(alpha=.5) +
  geom_histogram(position='identity', binwidth=1, alpha=0.6) +
  geom_vline(data=mu, aes(xintercept=mean, color=cigarettes),
             linetype='dashed', size=1) +
  facet_grid(.~wave) +
  theme_bw()