1 + 1

100:130

5-
  
3 % 5

2 * 3
## 6

4 - 1
## 3

6 / (4-1)
## 2

##Exercice
5 + 2
## 7

7 * 3
## 21

21 - 6
## 15

15 / 3
## 5


1:6
## 1 2 3 4 5 6



a <- 1

a
## 1

a + 2
## 3


die <- 1:6

die
## 1 2 3 4 5 6


Name <- 1

name <- 0

Name
## 1

name
## 0

my_number <- 1
my_number
## 1

my_number <- 999
my_number
## 999

ls()


die - 1
## 0 1 2 3 4 5

die / 2
## 0.5 1.0 1.5 2.0 2.5 3.0\

die * die
## 1 4 9 16 25 36

1:2
## 1 2

1:4
## 1 2 3 4

die
## 1 2 3 4 5 6

die + 1:2
## 2 4 4 6 6 8

die + 1:4
## 2 4 6 8 6 8


die %*% die
## 91

die %o% die
##     [,1] [,2] [,3] [,4] [,5] [,6]
##[1,]    1    2    3    4    5    6
##[2,]    2    4    6    8   10   12
##[3,]    3    6    9   12   15   18
##[4,]    4    8   12   16   20   24
##[5,]    5   10   15   20   25   30
##[6,]    6   12   18   24   30   36

round(3.1415)
## 3

factorial(3)
## 6

mean(1:6)
## 3.5

mean(die)
## 3.5

round(mean(die))
## 4

sample(x = 1:4, size = 2)
## 4 2

sample(x = die, size = 1)
## 6

sample(x = die, size = 1)
## 5

sample(x = die, size = 1)
## 3

sample(die, size = 1)
## 3

round(3.1415, corners = 2)
## Error in round(3.1415, corners = 2) : unused argument (corners = 2)

args(round)
## function (x, digits = 0)
## NULL

round(3.1415, digits = 2)
## 3.14

sample(die, 1)
## 5

sample(size = 1, x = die)
## 5

sample(die, size = 2)
## 3 6

sample(die, size = 2, replace = TRUE)
## 2 2

dice <- sample(die, size = 2, replace = TRUE)

dice
## 4 5

sum(dice)
## 9

dice
## 4 5

dice
## 4 5

dice
## 4 5

die <- 1:6
dice <- sample(die, size = 2, replace = TRUE)
sum(dice)

roll()
## Error in roll() : could not find function "roll"

my_function <- function() {}

roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}

roll()
## 6

roll
## function() {
## die <- 1:6
## dice <- sample(die, size = 2, replace = TRUE)
## sum(dice)
## }

## would display result
dice
1 + 1
sqrt(2)

## wouldn't display a result
dice <- sample(die, size = 2, replace = TRUE)
two <- 1 + 1
a <- sqrt(2)

roll2 <- function() {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}

roll2()
## Error in sample(bones, size = 2, replace = TRUE) :
## object 'bones' not found

roll2 <- function(bones) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}

roll2(bones = 1:4)
## 5

roll2(bones = 1:6)
## 7

roll2(1:20)
## 19

roll2()
## Error in sample(bones, size = 2, replace = TRUE) :
## argument "bones" is missing, with no default

roll2 <- function(bones = 1:6) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}

roll2()
## 6
