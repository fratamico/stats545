library(ggplot2)
library(gapminder)

str(gapminder) #do this first so that we know the makeup of the data

p <- ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) #aes is the aesthetic mapping

p + geom_point() #shows the points, geom_line() would fit a line

#notice that the x_axis needs to be log transformed
p <- ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) #aes is the aesthetic mapping
p + geom_point() + scale_x_log10() #add the scaling here, don't log the variable in the initial object (ie, don't do x=log10(gdpPercap))

p <- p + scale_x_log10() #makes logx scale permanent

p + geom_point(aes(color = continent)) #colors by continent

p + geom_point(alpha = (1/3), size = 3) #makes it slightly transparent, and makes the size 3

p + geom_point() + geom_smooth() #add a curve fit line

p + geom_point() + geom_smooth(lwd = 3, se = FALSE) #make the line bigger and without the standard error

p + geom_point() + geom_smooth(lwd = 3, se = FALSE, method = "lm") #makes the line straight
