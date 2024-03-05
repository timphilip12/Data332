deal(deck)
## Error in deal(deck) : could not find function "deal"

head(deck)
## face suit value
## king spades 13
## queen spades 12
## jack spades 11
## ten spades 10
## nine spades 9
## eight spades 8

deck[1, 1]
## "king"

deck[1, c(1, 2, 3)]
## face suit value
## king spades 13

new <- deck[1, c(1, 2, 3)]
new
## face suit value
## king spades 13

vec <- c(6, 1, 3, 6, 10, 5)
vec[1:3]
## 6 1 3

deck[1:2, 1:2]
## face suit
## king spades
## queen spades

deck[1:2, 1]
## "king" "queen"

deck[1:2, 1, drop = FALSE]
## face
## king
## queen

deck[-(2:52), 1:3]
## face suit value
## king spades 13

deck[c(-1, 1), 1]
## Error in xj[i] : only 0's may be mixed with negative subscripts

deck[0, 0]
## data frame with 0 columns and 0 rows

deck[1, ]
## face suit value
## king spades 13

deck[1, c(TRUE, TRUE, FALSE)]
## face suit
## king spades

rows <- c(TRUE, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F,
          F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F,
          F, F, F, F, F, F, F, F, F, F, F, F, F, F)

deck[rows, ]
## face suit value
## king spades 13

deck[1, c("face", "suit", "value")]
## face suit value
## king spades 13
# the entire value column

deck[ , "value"]
## 13 12 11 10 9 8 7 6 5 4 3 2 1 13 12 11 10 9 8
## 7 6 5 4 3 2 1 13 12 11 10 9 8 7 6 5 4 3 2
## 1 13 12 11 10 9 8 7 6 5 4 3 2 1

deal <- function(cards) {
  cards[1, ]
  }

deal(deck)
## face suit value
## king spades 13

deal(deck)
## face suit value
## king spades 13

deal(deck)
## face suit value
## king spades 13

deck2 <- deck[1:52, ]

head(deck2)
## face suit value
## king spades 13
## queen spades 12
## jack spades 11
## ten spades 10
## nine spades 9
## eight spades 8

deck3 <- deck[c(2, 1, 3:52), ]

head(deck3)
## face suit value
## queen spades 12
## king spades 13
## jack spades 11
## ten spades 10
## nine spades 9
## eight spades 8

random <- sample(1:52, size = 52)

random
## 35 28 39 9 18 29 26 45 47 48 23 22 21 16 32 38 1 15 20
## 11 2 4 14 49 34 25 8 6 10 41 46 17 33 5 7 44 3 27
## 50 12 51 40 52 24 19 13 42 37 43 36 31 30

deck4 <- deck[random, ]

head(deck4)
## face suit value
## five diamonds 5
## queen diamonds 12
## ace diamonds 1
## five spades 5
## nine clubs 9
## jack diamonds 11

shuffle <- function(cards) {
  random <- sample(1:52, size = 52)
  cards[random, ]
}


deal(deck)
## face suit value
## king spades 13

deck2 <- shuffle(deck)

deal(deck2)
## face suit value
## five hearts 5

deck$value
## 13 12 11 10 9 8 7 6 5 4 3 2 1 13 12 11 10 9 8 7
## 6 5 4 3 2 1 13 12 11 10 9 8 7 6 5 4 3 2 1 13
## 12 11 10 9 8 7 6 5 4 3 2 1

mean(deck$value)
## 7

median(deck$value)
## 7


lst <- list(numbers = c(1, 2), logical = TRUE, strings = c("a", "b", "c"))
lst
## $numbers
## [1] 1 2

## $logical
## [1] TRUE

## $strings
## [1] "a" "b" "c"

lst[1]
## $numbers
## [1] 1 2

sum(lst[1])
## Error in sum(lst[1]) : invalid 'type' (list) of argument

lst$numbers
## 1 2

sum(lst$numbers)
## 3

lst[[1]]
## 1 2

lst["numbers"]
## $numbers
## [1] 1 2

lst[["numbers"]]
## 1 2


