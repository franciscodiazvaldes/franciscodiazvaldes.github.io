
rm(list = ls()) #will clear all objects includes hidden objects.

# (1) Basic operations
5+7
abs(-17) # Absolute value
exp(-1)
log(1) 

#  Creating variables: scalars
x <- -12 # Create variable x and assign it the value -12

# Creating variables: vectors
y <- c(-12,6,0,-1)

# (2) Getting help
?mean
help(mean) # equivalent
help(package="devtools") # help on packages

# (3) Installing packages 
#---------------------------------------------------------------------------------
# Only in this part, remove # when running the code for the first time to install
# the packages)
# You only need to install packages once, then just call it using library()

# --------         HERE     -------------------------
# install.packages("devtools")  
# install.packages("tidyverse")
# devtools::install_git("https://github.com/ccolonescu/PoE5Rdata",force=TRUE) 
#----------------------------------------------------------------------------------------
library(POE5Rdata) # Use package POE5Rdata
data("food") # load database used in class
library(tidyverse)
?brumm # help on databases (built-in database)


# (4) Exploring and working with databases
data() # See what databases we have
data(mpg)
glimpse(mpg)
help(mpg)

# Filter
help(filter)
filter(mpg,cty>=20)
mpg_efficient <- filter(mpg,cty>=20)
glimpse(mpg_efficient)

mpg_ford <- filter(mpg,manufacturer == "ford")
View(mpg_ford)

# Adding a new variable in our database (liters per kilometer instead of miles per galon)
mpg_metric <- mutate(mpg,cty_metric = 0.425144*cty)
glimpse(mpg_metric)

# Use of pipe, instead of using mpg all the time
mpg_metric <- mpg %>%
  mutate(cty_metric = 0.425144*cty)

# Taking statistics by group
mpg %>% 
  group_by(class) %>% 
  summarise(mean(cty),
            median(cty)) 

# Data visualization using ggplot2 
# aes: aesthetics 
ggplot(mpg,aes(x=cty)) +
  geom_histogram() +
  labs(x = "City mileage")

ggplot(mpg,aes(x=cty)) +
  geom_freqpoly() +
  labs(x = "City mileage")

ggplot(mpg,aes(x=cty)) +
  geom_histogram() +
  geom_freqpoly() +
  labs(x = "City mileage")

ggplot(mpg,aes(x=cty,
               y = hwy)) +
  geom_point() + 
  geom_smooth(method = "lm")
  

ggplot(mpg,aes(x=cty,
               y = hwy,
               color = class)) +
               geom_point() +
               scale_color_brewer(palette = "Dark2")
  
# (5) Let's use brumm database
data("brumm")
help(brumm)
glimpse(brumm)
View(brumm)
summary(brumm)

# Scatterplot
# Using basic R
plot(brumm$money,brumm$inflat,main="Scatterplot Money v/s Inflation",
xlab="Money", ylab="Inflation",
xlim=c(min(brumm$money), max(brumm$money*1.05)), ylim=c(min(brumm$inflat), max(brumm$inflat)*1.05))

# Using ggplot
# Scatterplot + regression and confidence intervals
ggplot(
  data = brumm,
  mapping = aes(x = money, y = inflat)) +
  geom_point() + 
  geom_smooth(method = "lm")+
  labs(title = "Money Growth and Inflation",
       x = "Money Growth", y = "Inflation")

# What if I don't want outliers?, say inflation < 100 %
moderate_inflation <- filter(brumm,inflat<100)

ggplot(
  data = moderate_inflation,
  mapping = aes(x = money, y = inflat)) +
  geom_point() + 
  geom_smooth(method = "lm")+
  labs(title = "Money Growth and Inflation",
       x = "Money Growth", y = "Inflation")


# Box plots
# Using basic R 
boxplot(moderate_inflation$inflat, 
        ylab = "Inflation Rate")

# Using ggplot
ggplot() + 
  geom_boxplot(aes(y = moderate_inflation$output)) + 
  scale_x_discrete( ) +
  labs(title = "Boxplot of Inflation",
       y = "Inflation Rate")

# Many boxplots in one graph
boxplot(moderate_inflation$inflat, moderate_inflation$output,
        main = "Two or more boxplots",
        names = c("Inflation", "Output Growth"),
        ylab = "Percentages")

# Histograms
# Using basic R 
hist(moderate_inflation$poprate, 
     main = "Histogram of population gowth rate", 
     xlab = "Population Growth")

hist(moderate_inflation$poprate, 
     main = "Histogram of population gowth rate", 
     xlab = "Population Growth",
    breaks = 20)


# Using ggplot
ggplot(data = brumm, aes(x = poprate)) + 
  geom_histogram(binwidth = 0.5, color = "black", fill = "white") + 
  labs(title = "Histogram Population Growth", x = "Population Growth", y = "Frequency")

