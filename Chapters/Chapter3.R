die <- c(1, 2, 3, 4, 5, 6)
die
## 1 2 3 4 5 6

is.vector(die)
## TRUE

five <- 5
five
## 5

is.vector(five)
## TRUE

length(five)
## 1

length(die)
## 6

int <- 1L
text <- "ace"

int <- c(1L, 5L)
text <- c("ace", "hearts")

sum(int)
## 6

sum(text)
## Error in sum(text) : invalid 'type' (character) of argument

die <- c(1, 2, 3, 4, 5, 6)
die
## 1 2 3 4 5 6

typeof(die)
## "double"

int <- c(-1L, 2L, 4L)
int
## -1 2 4

typeof(int)
## "integer"

sqrt(2)^2 - 2
## 4.440892e-16

text <- c("Hello", "World")
text
## "Hello" "World"

typeof(text)
## "character"

typeof("Hello")
## "character"

## 1 is an integer and "1" and "one" are strings

3 > 4
## FALSE

logic <- c(TRUE, FALSE, TRUE)
logic
## TRUE FALSE TRUE

typeof(logic)
## "logical"

typeof(F)
## "logical"

comp <- c(1 + 1i, 1 + 2i, 1 + 3i)
comp
## 1+1i 1+2i 1+3i

typeof(comp)
## "complex"

raw(3)
## 00 00 00

typeof(raw(3))
## "raw"

hand <- c("ace", "king", "queen", "jack", "ten")
hand
## "ace" "king" "queen" "jack" "ten"

typeof(hand)
## "character"

attributes(die)
## NULL

names(die)
## NULL

names(die) <- c("one", "two", "three", "four", "five", "six")

names(die)
## "one" "two" "three" "four" "five" "six"

attributes(die)
## $names
## [1] "one" "two" "three" "four" "five" "six"

die
## one two three four five six
## 1 2 3 4 5 6

die + 1
## one two three four five six
## 2 3 4 5 6 7

names(die) <- c("uno", "dos", "tres", "quatro", "cinco", "seis")
die
## uno dos tres quatro cinco seis
## 1 2 3 4 5 6

names(die) <- NULL
die
## 1 2 3 4 5 6

dim(die) <- c(2, 3)
die
## [,1] [,2] [,3]
## [1,] 1 3 5
## [2,] 2 4 6

dim(die) <- c(3, 2)
die
## [,1] [,2]
## [1,] 1 4
## [2,] 2 5
## [3,] 3 6

dim(die) <- c(1, 2, 3)
die
## , , 1
##
## [,1] [,2]
## [1,] 1 2
##
## , , 2
##
## [,1] [,2]
## [1,] 3 4
##
## , , 3
##
## [,1] [,2]
## [1,] 5 6

m <- matrix(die, nrow = 2)
m
## [,1] [,2] [,3]
## [1,] 1 3 5
## [2,] 2 4 6

m <- matrix(die, nrow = 2, byrow = TRUE)
m
## [,1] [,2] [,3]
## [1,] 1 2 3
## [2,] 4 5 6

ar <- array(c(11:14, 21:24, 31:34), dim = c(2, 2, 3))
ar
## , , 1
##
## [,1] [,2]
## [1,] 11 13
## [2,] 12 14
##
## , , 2
##
## [,1] [,2]
## [1,] 21 23
## [2,] 22 24
##
## , , 3
##
## [,1] [,2]
## [1,] 31 33
## [2,] 32 34

hand1 <- c("ace", "king", "queen", "jack", "ten", "spades", "spades", "spades", "spades", "spades")
matrix(hand1, nrow = 5)
matrix(hand1, ncol = 2)
dim(hand1) <- c(5, 2)
## [,1] [,2]
## [1,] "ace" "spades"
## [2,] "king" "spades"
## [3,] "queen" "spades"
## [4,] "jack" "spades"
## [5,] "ten" "spades"

dim(die) <- c(2, 3)
typeof(die)
## "double"

class(die)
## "matrix"

attributes(die)
## $dim
## [1] 2 3

class("Hello")
## "character"

class(5)
## "numeric"

now <- Sys.time()
now
## "2024-02-25 22:24:19 CST"

typeof(now)
## "double"

class(now)
## "POSIXct" "POSIXt"

unclass(now)
## 1708921460

mil <- 1000000
mil
## 1e+06

class(mil) <- c("POSIXct", "POSIXt")
mil
## "1970-01-12 13:46:40 UTC"

gender <- factor(c("male", "female", "female", "male"))
typeof(gender)
## "integer"

attributes(gender)
## $levels
## [1] "female" "male"
##
## $class
## [1] "factor"

unclass(gender)
## [1] 2 1 1 2
## attr(,"levels")
## [1] "female" "male"

gender
## male female female male
## Levels: female male

as.character(gender)
## "male" "female" "female" "male"

card <- c("ace", "hearts", 1)
card
## "ace" "hearts" "1"

sum(c(TRUE, TRUE, FALSE, FALSE))

sum(c(1, 1, 0, 0))
## 2

as.character(1)
## "1"

as.logical(1)
## TRUE

as.numeric(FALSE)
## 0

list1 <- list(100:130, "R", list(TRUE, FALSE))
list1
## [[1]]
## [1] 100 101 102 103 104 105 106 107 108 109 110 111 112
## [14] 113 114 115 116 117 118 119 120 121 122 123 124 125
## [27] 126 127 128 129 130
##
## [[2]]
## [1] "R"
##
## [[3]]
## [[3]][[1]]
## [1] TRUE
##
## [[3]][[2]]
## [1] FALSE

card <- list("ace", "hearts", 1)
card
## [[1]]
## [1] "ace"
##
## [[2]]
## [1] "hearts"
##
## [[3]]
## [1] 1

df <- data.frame(face = c("ace", "two", "six"), suit = c("clubs", "clubs", "clubs"), value = c(1, 2, 3))
df
## face suit value
## ace clubs 1
## two clubs 2
## six clubs 3

typeof(df)
## "list"

class(df)
## "data.frame"

str(df)
## 'data.frame': 3 obs. of 3 variables:
## $ face : Factor w/ 3 levels "ace","six","two": 1 3 2
## $ suit : Factor w/ 1 level "clubs": 1 1 1
## $ value: num 1 2 3

df <- data.frame(face = c("ace", "two", "six"), suit = c("clubs", "clubs", "clubs"), value = c(1, 2, 3), stringsAsFactors = FALSE)

deck <- data.frame(
  face = c("king", "queen", "jack", "ten", "nine", "eight", "seven", "six",
           "five", "four", "three", "two", "ace", "king", "queen", "jack", "ten",
           "nine", "eight", "seven", "six", "five", "four", "three", "two", "ace",
           "king", "queen", "jack", "ten", "nine", "eight", "seven", "six", "five",
           "four", "three", "two", "ace", "king", "queen", "jack", "ten", "nine",
           "eight", "seven", "six", "five", "four", "three", "two", "ace"),
  suit = c("spades", "spades", "spades", "spades", "spades", "spades",
           "spades", "spades", "spades", "spades", "spades", "spades", "spades",
           "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", "clubs",
           "clubs", "clubs", "clubs", "clubs", "clubs", "diamonds", "diamonds",
           "diamonds", "diamonds", "diamonds", "diamonds", "diamonds", "diamonds",
           "diamonds", "diamonds", "diamonds", "diamonds", "diamonds", "hearts",
           "hearts", "hearts", "hearts", "hearts", "hearts", "hearts", "hearts",
           "hearts", "hearts", "hearts", "hearts", "hearts"),
  value = c(13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8,
            7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 12, 11,
            10, 9, 8, 7, 6, 5, 4, 3, 2, 1)
)

deck


head(deck)
## face suit value
## king spades 13
## queen spades 12
## jack spades 11
## ten spades 10
## nine spades 9
## eight spades 8

write.csv(deck, file = "cards.csv", row.names = FALSE)


