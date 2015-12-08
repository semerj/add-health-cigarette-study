library(ggplot2)
library(tidyr)
library(dplyr)
library(scales)

load('../data/add_cig.RData')
load('../data/add_waves.RData')

################################################################################
###################################  Plots  ####################################
################################################################################

# each sex should have it's own intercept
add_waves %>%
  filter(cigarettes == 1 & wave == 1) %>%
  dplyr::select(AID, cigarettes) %>%
  inner_join(add_waves, by=c('AID'='AID')) %>%
  head(200) %>%
  bind_rows(
    add_waves %>%
      filter(cigarettes == 0 & wave == 1) %>%
      select(AID, cigarettes) %>%
      inner_join(add_waves, by=c('AID'='AID')) %>%
      head(200)
  ) %>%
  ggplot(aes(x = age, y = CESD, col = as.factor(AID))) +
  geom_line() + geom_point() +
  theme_bw() +
  theme(legend.position='none') +
  coord_cartesian(ylim=c(0,20)) +
  facet_wrap(~cigarettes.x) +
  ylab('Depression Score (CES-D)') + xlab('Age') +
  ggtitle('Daily Cigarette Smoking at Wave 1 (0/1) by Depression Score and Age\nSample of 50 non-daily (0) and 50 daily smokers (1)\n') +
  ggsave('figure1.png')

ggplot(add_waves, aes(x=age, y=CESD, col=sex)) +
  geom_smooth(method='loess') +
  coord_cartesian(ylim=c(0,10)) +
  facet_wrap(~cigarettes) +
  theme_bw() +
  ylab('Depression Score (CES-D)') + xlab('Age') +
  ggtitle('LOESS Smoothing of Depression Score\nby Sex, Daily Cigarette Smoking Status (0/1), and Age\n') +
  ggsave('figure2.png')

add_waves %>%
  mutate(cigarettes = as.factor(cigarettes)) %>%
  ggplot(aes(x = CESD, col = cigarettes)) +
  geom_density(adjust=1.5) +
  facet_wrap(~wave) +
  theme_bw() +
  xlab('Depression Score (CES-D)') + ylab('') +
  ggtitle('Distribution of Baseline Depression by Daily Cigarette Smoking Status and Study Wave\n') +
  ggsave('figure3.png')

# proportion of smokers by wave & sex
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
  ggtitle('Proportion of Cigarette Smokers by Study Wave\n') +
  ggsave('figure4.png')

# depression went up during the second wave of the study for individuals that
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