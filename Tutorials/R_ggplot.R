# install.packages("tidyverse")
 install.packages("gapminder")

library(tidyverse)
library(gapminder)

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp) ) + 
  geom_point()+theme_grey(base_size = 15)

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp) ) + 
  geom_point(color="blueviolet")

 colors() %>% sample(10)

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, color=continent) ) + 
  geom_point()

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, color=continent, size=pop) ) + 
  geom_point()

# Single Variable

ggplot(gapminder, aes(x=lifeExp) ) + 
  geom_histogram()

ggplot(gapminder, aes(x=lifeExp) ) + 
  geom_density()

ggplot(gapminder, aes(x=lifeExp) ) + 
  geom_density(fill="rosybrown1")

ggplot(gapminder, aes(x=lifeExp, fill=continent) ) + 
  geom_density(alpha=.6)

ggplot(gapminder, aes(x=continent, y=lifeExp) ) + 
  geom_boxplot()

ggplot(gapminder, aes(x=continent, y=lifeExp) ) + 
  geom_violin()

ggplot(gapminder, aes(x=continent, y=lifeExp) ) + geom_jitter(alpha=.2)+
  geom_violin()
  

# Change Across time

ggplot(gapminder, aes(x=year, y=lifeExp) ) + 
  geom_point()

ggplot(gapminder, aes(x=year, y=lifeExp)) + 
  geom_line()

ggplot(gapminder, aes(x=year, y=lifeExp)) + 
  geom_line(aes(group=country))

# Smoothing

ggplot(gapminder, aes(x=year, y=lifeExp)) + 
  geom_point() + 
  geom_smooth()

ggplot(gapminder, aes(x=year, y=lifeExp)) + 
  geom_point() + 
  geom_smooth(method="lm")

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + 
  geom_point() + 
  geom_smooth(method="lm")

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp) ) + 
  geom_point() + 
  geom_smooth()

# Bar charts
gapminder %>% 
  filter(year==2007) %>% 
  ggplot(aes(x=continent)) + 
  geom_bar()

gapminder %>% 
  filter(year==2007) %>% 
  group_by(continent) %>% 
  summarize(avgle = mean(lifeExp)) %>% 
  ggplot(aes(x=continent, y=avgle)) + 
  geom_col()# used to specify the meaning of the vertical axis by yourself instead of default

gapminder %>% 
  filter(year==2007 | year==1952) %>% 
  group_by(continent, year) %>% 
  summarize(avgle = mean(lifeExp)) %>% 
  ggplot(aes(x=continent, y=avgle)) + 
  geom_col( aes(fill=year) )

gapminder %>% 
  filter(year==2007 | year==1952) %>% 
  group_by(continent, year) %>% 
  summarize(avgle = mean(lifeExp)) %>% 
  ggplot(aes(x=continent, y=avgle)) + 
  geom_col( aes(fill=factor(year)) )

gapminder %>% 
  filter(year==2007 | year==1952) %>% 
  group_by(continent, year) %>% 
  summarize(avgle = mean(lifeExp)) %>% 
  ggplot(aes(x=continent, y=avgle)) + 
  geom_col( aes(fill=factor(year)), 
            position="dodge")#year is a discrete variable

# Many ways to get the same plot

ggplot(gapminder) + 
  geom_point(aes(x=gdpPercap, y=lifeExp))

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + 
  geom_point()

ggplot(gapminder, aes(x=gdpPercap))  +
  geom_point(aes(y=lifeExp))

m <- aes(x=gdpPercap, y=lifeExp)
ggplot() + 
  geom_point(mapping=m, data=gapminder)

# Different data for different layers

to_label <- gapminder %>% 
  filter(year==2007 & pop > 200000000)

gapminder %>%
  filter(year==2007) %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp)) +
  geom_point(aes(size=pop, color=continent)) + 
  geom_text(aes(label=country), data=to_label) 

# Faceting

ggplot(gapminder, aes(x=lifeExp)) +
  geom_density(fill="grey40") + 
  facet_wrap(~continent)

p <- ggplot(mpg, aes(cty, hwy)) +   
  geom_point()

p + facet_grid(~cyl)
p + facet_grid(cyl~.)
p + facet_grid(cyl~drv)
p + facet_grid(cyl~drv, scales="free")

# Continuous vs Discrete Scales

p <- gapminder %>% 
  filter(country=="United States") %>% 
  ggplot(aes(gdpPercap, lifeExp))

p + geom_point(aes(color=year))
p + geom_point(aes(color=factor(year)))

# Discrete Scale colors
#colorbrewer
p <- ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color = drv))

p + scale_color_manual(values=c(
  "4"="#F2CED8", "f"="#88B8B8", "r"="#DE7E68") )

p + scale_color_brewer(palette="Paired")

# Continuous scale colors

p <- ggplot(mpg, aes(cty, hwy)) + 
  geom_point(aes(color = scale(displ)))

p + scale_color_gradient(low="white", high="orchid")
p + scale_color_gradient2(low="white", high="orchid", mid="tomato")
p + scale_color_gradientn(colors=c("blue","wheat","green"))

# Setting vs mapping

ggplot(mpg, aes(cty, hwy)) +
  geom_point(aes(color = "darkblue"))

ggplot(mpg, aes(cty, hwy)) +
  geom_point(color = "darkblue")

# Literal String mapping

ggplot(mpg, aes(displ, hwy)) +
  geom_point() + 
  geom_smooth(aes(color = "loess"), 
      method = "loess", se = FALSE) + 
  geom_smooth(aes(color = "lm"), 
      method = "lm", se = FALSE) +  
  labs(color = "Method")

# Discrete axes order
p <- ggplot(mpg, aes(y=hwy))

p + geom_boxplot(aes(drv))

p + geom_boxplot(aes(drv)) + 
  scale_x_discrete(limits=c("f","r","4"))

p + geom_boxplot(aes(reorder(drv, hwy)))

# Label Your Axes

ggplot(mpg, aes(cyl)) + 
  geom_bar() + 
  labs(
    title=expression(y==alpha+beta*x),
    x="Cylinder", 
    y="Count")

# Coordinates
p <- ggplot(mpg, aes(drv)) + 
  geom_bar()
p
P + coord_flip()

ggplot(mpg) + 
  geom_bar(aes(factor(1),    
               fill=drv),width=1) + 
  coord_polar(theta="y")

# Themes

p <- ggplot(mpg, aes(cty, hwy, color = factor(cyl))) + 
  geom_jitter() + 
  geom_abline(color="grey50", size=2) + 
  ggtitle("My Plot!")

#default
p + theme_grey()
# try these 
p + theme_bw()
p + theme_linedraw()
p + theme_light()
p + theme_dark()
p + theme_minimal()

# Map Making
 install.packages(c("maps","mapproj", "ggthemes"))
library(maps)
mapdata <- map_data("world") %>% 
  mutate(region = recode(region, USA="United States",
                         UK="United Kingdom"))

gapminder %>% filter(year==2007) %>% 
  ggplot() + 
  geom_map(aes(map_id=country, fill=lifeExp), map=mapdata) + 
  expand_limits(x = mapdata$long, y = mapdata$lat) +
  coord_map(projection = "mollweide", xlim = c(-180, 180)) + 
  ggthemes::theme_map()





