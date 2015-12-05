library(ggplot2)

add = read.csv('../data/add_recode.csv',
               colClasses = c('factor', 'integer', 'factor', 'factor', 'factor',
                              'factor', 'factor', 'factor', 'factor', 'numeric'))

# add %>%
#   group_by(cigarettes, wave) %>%
#   summarize(mu = mean(CESD))


################################################################################
###################################  Plots  ####################################
################################################################################

ggplot(add, aes(y=CESD, x=age, col=sex)) +
  geom_smooth(method='loess')

# cigarettes
ggplot(add, aes(x = wave, y = CESD, color = cigarettes)) +
  geom_boxplot(position="dodge") +
  facet_wrap(~sex)

# marijuana
ggplot(add, aes(x = wave, y = CESD, color = marijuana)) +
  geom_boxplot(position="dodge") +
  facet_wrap(~sex)

# drink
ggplot(add, aes(x = wave, y = CESD, color = drink)) +
  geom_boxplot(position="dodge") +
  facet_wrap(~sex)