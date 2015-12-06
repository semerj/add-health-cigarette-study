library(ggplot2)
library(tidyr)
library(dplyr)

load('../data/add_cig.RData')
load('../data/add_waves.RData')

################################################################################
###################################  Plots  ####################################
################################################################################

# Proportion of smokers by wave & sex
add_waves %>%
  group_by(wave, sex, cigarettes) %>%
  tally() %>%
  group_by(wave, sex) %>%
  mutate(pct=n/sum(n)) %>%
  filter(cigarettes == 1) %>%
  ggplot(aes(x = wave, y = pct, col = sex, group=sex)) +
  geom_line()

# Each sex should have it's own intercept
add_waves %>%
  head(200) %>%
  ggplot(aes(x = wave, y = CESD, group = AID, col = as.factor(AID))) +
  geom_line(position=position_jitter(w = 0, h = 0.2)) +
  theme_bw() +
  theme(legend.position="none") +
  facet_wrap(~sex) +
  ggtitle('Random sample of 50 subjects')

# Depression went up during the second wave of the study for individuals that
# smoked during the baseline period
add_cig$cigarettes = as.factor(add_cig$cigarettes)
ggplot(add_cig, aes(x = wave, y = CESD_diff, fill=cigarettes)) +
  geom_boxplot() +
  theme_bw()

# Save as above
mu = add_cig %>% group_by(wave, cigarettes) %>% summarize(mean = median(CESD_diff))
ggplot(add_cig, aes(x = CESD_diff, fill = cigarettes, group = cigarettes)) +
  # geom_density(alpha=.5) +
  geom_histogram(position="identity", binwidth=1, alpha=0.6) +
  geom_vline(data=mu, aes(xintercept=mean, color=cigarettes),
             linetype='dashed', size=1) +
  facet_grid(.~wave) +
  theme_bw()

# add_waves %>%
#   select(AID, wave, cigarettes) %>%
#   spread(wave, cigarettes) %>%
#   rename(w1 = `1`, w2 = `2`, w3 = `3`, w4 = `4`) %>%
#   mutate(cig = paste0(w1, w2, w3, w4)) %>%
#   group_by(cig) %>%
#   summarize(n = n()) %>%
#   ggplot(aes(y = n, x = reorder(cig, n))) +
#   geom_bar(stat='identity') +
#   coord_flip()

# add_waves %>%
#   head(200) %>%
#   ggplot(aes(x = wave, y = cigarettes, group = AID, col= as.factor(AID))) +
#   geom_line(position=position_jitter(w = 0, h = 0.05)) +
#   theme_bw() +
#   theme(legend.position="none") +
#   facet_wrap(~sex)