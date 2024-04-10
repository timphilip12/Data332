get_symbols <- function() {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE,
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}

get_symbols()
## "B" "7" "0"

get_symbols()
## "B"  "DD" "B"

score(c("DD", "DD", "DD"))
## Error in score(c("DD", "DD", "DD")) : could not find function "score"

play <- function() {
  symbols <- get_symbols()
  print(symbols)
  score(symbols)
}

play <- function() {
  # step 1: generate symbols
  symbols <- get_symbols()
  # step 2: display the symbols
  print(symbols)
  # step 3: score the symbols
  score(symbols)
}

num <- -2
if (num < 0) {
  num <- num * -1
}
num
## 2

num <- 4

if (num < 0) {
  num <- num * -1
}
num
## 4

num <- -1

if (num < 0) {
  print("num is negative.")
  print("Don't worry, I'll fix it.")
  num <- num * -1
  print("Now num is positive.")
}
## "num is negative."
## "Don't worry, I'll fix it."
## "Now num is positive."

num
## 1

x <- 1
if (3 == 3) {
  x <- 2
}
x
## 2

x <- 1
if (TRUE) {
  x <- 2
}
x
## 2

x <- 1
if (x == 1) {
  x <- 2
  if (x == 1) {
    x <- 3
  }
}
x
## 2

a <- 3.14

dec <- a - trunc(a)
dec
## 0.14

if (dec >= 0.5) {
  a <- trunc(a) + 1
} else {
  a <- trunc(a)
}
a
## 3

a <- 1
b <- 1
if (a > b) {
  print("A wins!")
} else if (a < b) {
  print("B wins!")
} else {
  print("Tie.")
}
## "Tie."

score <- function(symbols) {
  # calculate a prize
  prize
}

symbols <- c("7", "7", "7")

symbols <- c("B", "BB", "BBB")
symbols <- c("C", "DD", "0")

symbols <- c("7", "7", "7")
symbols
## "7" "7" "7"
symbols[1] == symbols[2] & symbols[2] == symbols[3]
## TRUE
symbols[1] == symbols[2] & symbols[1] == symbols[3]
## TRUE
all(symbols == symbols[1])
## TRUE

length(unique(symbols) == 1)

same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]

symbols[1] == "B" | symbols[1] == "BB" | symbols[1] == "BBB" &
  symbols[2] == "B" | symbols[2] == "BB" | symbols[2] == "BBB" &
  symbols[3] == "B" | symbols[3] == "BB" | symbols[3] == "BBB"
## TRUE

all(symbols %in% c("B", "BB", "BBB"))
## TRUE

symbols <- c("B", "B", "B")
all(symbols %in% c("B", "BB", "BBB"))
## TRUE

if (same) {
  symbol <- symbols[1]
  if (symbol == "DD") {
    prize <- 800
  } else if (symbol == "7") {
    prize <- 80
  } else if (symbol == "BBB") {
    prize <- 40
  } else if (symbol == "BB") {
    prize <- 5
  } else if (symbol == "B") {
    prize <- 10
  } else if (symbol == "C") {
    prize <- 10
  } else if (symbol == "0") {
    prize <- 0
  }
}

payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25,
             "B" = 10, "C" = 10, "0" = 0)
payouts
## DD 7 BBB BB B C 0
## 100 80 40 25 10 10 0

payouts["DD"]
## DD
## 100

payouts["B"]
## B
## 10

unname(payouts["DD"])
## 100

symbols <- c("7", "7", "7")
symbols[1]
## "7"
payouts[symbols[1]]
## 7
## 80
symbols <- c("C", "C", "C")
payouts[symbols[1]]
## C
## 10

symbols <- c("C", "DD", "C")

symbols == "C"
## TRUE FALSE TRUE

sum(symbols == "C")
## 2

sum(symbols == "DD")
## 1


c(0, 2, 5)

cherries <- 0
cherries + 1
## 1

c(0, 2, 5)[cherries + 1]
## 0

cherries <- 1
cherries + 1
## 2

c(0, 2, 5)[cherries + 1]
## 2

cherries <- 3
cherries + 1
## 4
c(0, 2, 5)[cherries + 1]
## NA

prize * 2 ^ diamonds

score <- function (symbols) {
  # identify case
  same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
  bars <- symbols %in% c("B", "BB", "BBB")
  # get prize
  if (same) {
    payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25,
                 "B" = 10, "C" = 10, "0" = 0)
    prize <- unname(payouts[symbols[1]])
  } else if (all(bars)) {
    prize <- 5
  } else {
    cherries <- sum(symbols == "C")
    prize <- c(0, 2, 5)[cherries + 1]
  }
  # adjust for diamonds
  diamonds <- sum(symbols == "DD")
  prize * 2 ^ diamonds
}

play <- function() {
  symbols <- get_symbols()
  print(symbols)
  score(symbols)
}

play()
## "0" "B" "BB"
## 0

play()
## "0" "0" "0"
## 0

play()
## "0" "B" "B"
## 0



