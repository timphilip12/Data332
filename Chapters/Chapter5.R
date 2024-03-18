vec <- c(0, 0, 0, 0, 0, 0)
vec
## 0 0 0 0 0 0

vec[1]
## 0

vec[1] <- 1000
vec
## 1000 0 0 0 0 0

vec[c(1, 3, 5)] <- c(1, 1, 1)
vec
## 1 0 1 0 1 0

vec[4:6] <- vec[4:6] + 1
vec
## 1 0 1 1 2 1

vec[7] <- 0
vec
## 1 0 1 1 2 1 0


deck2$new <- 1:52
head(deck2)
## face suit value new
## king spades 13 1
## queen spades 12 2
## jack spades 11 3
## ten spades 10 4
## nine spades 9 5
## eight spades 8 6

deck2$new <- NULL
head(deck2)
## face suit value
## king spades 13
## queen spades 12
## jack spades 11
## ten spades 10
## nine spades 9
## eight spades 8

deck2[c(13, 26, 39, 52), ]
## face suit value
## ace spades 1
## ace clubs 1
## ace diamonds 1
## ace hearts 1

deck2[c(13, 26, 39, 52), 3]
## 1 1 1 1

deck2$value[c(13, 26, 39, 52)]
## 1 1 1 1

deck2$value[c(13, 26, 39, 52)] <- c(14, 14, 14, 14)
# or
deck2$value[c(13, 26, 39, 52)] <- 14

head(deck2, 13)
## face suit value
## king spades 13
## queen spades 12
## jack spades 11
## ten spades 10
## nine spades 9
## eight spades 8
## seven spades 7
## six spades 6
## five spades 5
## four spades 4
## three spades 3
## two spades 2
## ace spades 14

deck3 <- shuffle(deck)

head(deck3)
## face suit value
## queen clubs 12
## king clubs 13
## ace spades 1 # an ace
## nine clubs 9
## seven spades 7
## queen diamonds 12

vec
## 1 0 1 1 2 1 0

vec[c(FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE)]
## 2

1 > 2
## FALSE

1 > c(0, 1, 2)
## TRUE FALSE FALSE

c(1, 2, 3) == c(3, 2, 1)
## FALSE TRUE FALSE

1 %in% c(3, 4, 5)
## FALSE

c(1, 2) %in% c(3, 4, 5)
## FALSE FALSE

c(1, 2, 3) %in% c(3, 4, 5)
## FALSE FALSE TRUE

c(1, 2, 3, 4) %in% c(3, 4, 5)
## FALSE FALSE TRUE TRUE

deck2$face
## "king" "queen" "jack" "ten" "nine"
## "eight" "seven" "six" "five" "four"
## "three" "two" "ace" "king" "queen"
## "jack" "ten" "nine" "eight" "seven"
## "six" "five" "four" "three" "two"
## "ace" "king" "queen" "jack" "ten"
## "nine" "eight" "seven" "six" "five"
## "four" "three" "two" "ace" "king"
## "queen" "jack" "ten" "nine" "eight"
## "seven" "six" "five" "four" "three"
## "two" "ace"

deck2$face == "ace"
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## FALSE FALSE FALSE FALSE FALSE TRUE FALSE
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## FALSE FALSE FALSE FALSE TRUE FALSE FALSE
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## FALSE FALSE FALSE TRUE FALSE FALSE FALSE
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## FALSE FALSE TRUE

sum(deck2$face == "ace")
## 4

deck3$face == "ace"

deck3$value[deck3$face == "ace"]
## 1 1 1 1

deck3$value[deck3$face == "ace"] <- 14

head(deck3)
## face suit value
## queen clubs 12
## king clubs 13
## ace spades 14 # an ace
## nine clubs 9
## seven spades 7
## queen diamonds 12

deck4 <- deck
deck4$value <- 0
head(deck4, 13)
## face suit value
## king spades 0
## queen spades 0
## jack spades 0
## ten spades 0
## nine spades 0
## eight spades 0
## seven spades 0
## six spades 0
## five spades 0
## four spades 0
## three spades 0
## two spades 0
## ace spades 0

deck4$suit == "hearts"
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## FALSE FALSE FALSE FALSE TRUE TRUE TRUE
## TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## TRUE TRUE TRUE

deck4$value[deck4$suit == "hearts"]
## 0 0 0 0 0 0 0 0 0 0 0 0 0

deck4$value[deck4$suit == "hearts"] <- 1

deck4$value[deck4$suit == "hearts"]
## 1 1 1 1 1 1 1 1 1 1 1 1 1

deck4[deck4$face == "queen", ]
## face suit value
## queen spades 0
## queen clubs 0
## queen diamonds 0
## queen hearts 1

deck4[deck4$suit == "spades", ]
## face suit value
## king spades 0
## queen spades 0
## jack spades 0
## ten spades 0
## nine spades 0
## eight spades 0
## seven spades 0
## six spades 0
## five spades 0
## four spades 0
## three spades 0
## two spades 0
## ace spades 0

a <- c(1, 2, 3)
b <- c(1, 2, 3)
c <- c(1, 2, 4)

a == b
## TRUE TRUE TRUE

b == c
## TRUE TRUE FALSE

a == b & b == c
## TRUE TRUE FALSE

deck4$face == "queen" & deck4$suit == "spades"
## FALSE TRUE FALSE FALSE FALSE FALSE FALSE
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## FALSE FALSE FALSE

queenOfSpades <- deck4$face == "queen" & deck4$suit == "spades"

deck4[queenOfSpades, ]
## face suit value
## queen spades 0

deck4$value[queenOfSpades]
## 0

deck4$value[queenOfSpades] <- 13

deck4[queenOfSpades, ]
## face suit value
## queen spades 13

w <- c(-1, 0, 1)
x <- c(5, 15)
y <- "February"
z <- c("Monday", "Tuesday", "Friday")

w > 0
## FALSE FALSE  TRUE

10 < x & x < 20
## FALSE  TRUE

y == "February"
## TRUE

all(z %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
             "Saturday", "Sunday"))
## TRUE

deck5 <- deck
head(deck5, 13)
## king spades 13
## queen spades 12
## jack spades 11
## ten spades 10
## nine spades 9
## eight spades 8
## seven spades 7
## six spades 6
## five spades 5
## four spades 4
## three spades 3
## two spades 2
## ace spades 1

facecard <- deck5$face %in% c("king", "queen", "jack")
deck5[facecard, ]
## face suit value
## king spades 13
## queen spades 12
## jack spades 11
## king clubs 13
## queen clubs 12
## jack clubs 11
## king diamonds 13
## queen diamonds 12
## jack diamonds 11
## king hearts 13
## queen hearts 12
## jack hearts 11

deck5$value[facecard] <- 10
head(deck5, 13)
## face suit value
## king spades 10
## queen spades 10
## jack spades 10
## ten spades 10
## nine spades 9
## eight spades 8
## seven spades 7
## six spades 6
## five spades 5
## four spades 4
## three spades 3
## two spades 2
## ace spades 1

1 + NA
## NA

NA == 1
## NA

c(NA, 1:50)
## NA 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
## 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33
## 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50

mean(c(NA, 1:50))
## NA

mean(c(NA, 1:50), na.rm = TRUE)
## 25.5

NA == NA
## NA

c(1, 2, 3, NA) == NA
## NA NA NA NA

is.na(NA)
## TRUE

vec <- c(1, 2, 3, NA)
is.na(vec)
## FALSE FALSE FALSE TRUE

deck5$value[deck5$face == "ace"] <- NA
head(deck5, 13)
## face suit value
## king spades 10
## queen spades 10
## jack spades 10
## ten spades 10
## nine spades 9
## eight spades 8
## seven spades 7
## six spades 6
## five spades 5
## four spades 4
## three spades 3
## two spades 2
## ace spades NA

