# ggplot practice
library(tidyverse)
summary(mpg)
mpg$cyl <- as.factor(mpg$cyl)
ggplot(mpg, aes(x=cty,y=hwy,color=cyl))+geom_point()
mpg$manufacturer <- as.factor(mpg$manufacturer)
ggplot(mpg,aes(x=manufacturer)) +geom_bar()+coord_flip()+
  theme(text = element_text(size=16))+ylab("Count")+xlab("Manufacturer")

ggplot(mpg,aes(x=cty,y=hwy))+geom_point()+
  facet_grid(~year)+geom_smooth(method="lm")

ggplot(mpg, aes(x=hwy)) + facet_grid(~class) +geom_density(color="slategray")
