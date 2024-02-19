install.packages("ggplot2")

qplot
## Error: object 'qplot' not found

library("ggplot2")

qplot
## A lot of code

x <- c(-1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1)
x
## -1.0 -0.8 -0.6 -0.4 -0.2 0.0 0.2 0.4 0.6 0.8 1.0

y <- x^3
y
## -1.000 -0.512 -0.216 -0.064 -0.008 0.000 0.008
## 0.064 0.216 0.512 1.000

qplot(x, y)

x <- c(1, 2, 2, 2, 3, 3)

qplot(x, binwidth = 1)

x2 <- c(1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 4)

qplot(x2, binwidth = 1)


## Exercice

x3 <- c(0, 1, 1, 2, 2, 2, 3, 3, 4)

## 5 bars will appear in the plots section of R. Their height will go from 
## 1 to 3

qplot(x3, binwidth = 1)



replicate(3, 1 + 1)
## 2 2 2

roll <- function(bones = 1:6) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}

replicate(10, roll())
## 3 7 5 3 6 2 3 8 11 7

rolls <- replicate(10000, roll())

qplot(rolls, binwidth = 1)


?sqrt
?log10
?sample

??log

?sample


## Exercice
roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE,
                 prob = c(1/8, 1/8, 1/8, 1/8, 1/8, 3/8))
  sum(dice)
}

rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)



