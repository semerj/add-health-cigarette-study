library(ggplot2)


add = read.csv('../data/add_recode.csv')
add$wave = as.factor(add$wave)
add$race = as.factor(add$race)

ggplot(add, aes(y=CESD, x=age, col=as.factor(sex))) +
  geom_smooth(method='loess')