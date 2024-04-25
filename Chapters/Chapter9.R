die <- c(1, 2, 3, 4, 5, 6)

rolls <- expand.grid(die, die)

rolls
## Var1 Var2
## 1 1 1
## 2 2 1
## 3 3 1
## ...
## 34 4 6
## 35 5 6
## 36 6 6

rolls$value <- rolls$Var1 + rolls$Var2
head(rolls, 3)
## Var1 Var2 value
## 1 1 2
## 2 1 3
## 3 1 4

prob <- c("1" = 1/8, "2" = 1/8, "3" = 1/8, "4" = 1/8, "5" = 1/8, "6" = 3/8)
prob
## 1         2     3     4     5     6
## 0.125 0.125 0.125 0.125 0.125 0.375

rolls$Var1
## 1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6
prob[rolls$Var1]
## 1 2 3 4 5 6 1 2 3 4 5 6
## 0.125 0.125 0.125 0.125 0.125 0.375 0.125 0.125 0.125 0.125 0.125 0.375
## 1 2 3 4 5 6 1 2 3 4 5 6
## 0.125 0.125 0.125 0.125 0.125 0.375 0.125 0.125 0.125 0.125 0.125 0.375
## 1 2 3 4 5 6 1 2 3 4 5 6
## 0.125 0.125 0.125 0.125 0.125 0.375 0.125 0.125 0.125 0.125 0.125 0.375

rolls$prob1 <- prob[rolls$Var1]
head(rolls, 3)
## Var1 Var2 value prob1
## 1 1 2 0.125
## 2 1 3 0.125
## 3 1 4 0.125

rolls$prob2 <- prob[rolls$Var2]
head(rolls, 3)
## Var1 Var2 value prob1 prob2
## 1 1 2 0.125 0.125
## 2 1 3 0.125 0.125
## 3 1 4 0.125 0.125

rolls$prob <- rolls$prob1 * rolls$prob2
head(rolls, 3)
## Var1 Var2 value prob1 prob2 prob
## 1 1 2 0.125 0.125 0.015625
## 2 1 3 0.125 0.125 0.015625
## 3 1 4 0.125 0.125 0.015625

sum(rolls$value * rolls$prob)
## 8.25

wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")

combos <- expand.grid(wheel, wheel, wheel, stringsAsFactors = FALSE)

combos
## Var1 Var2 Var3
## 1 DD DD DD
## 2 7 DD DD
## 3 BBB DD DD
## 4 BB DD DD
## 5 B DD DD
## 6 C DD DD
## ...
## 341 B 0 0
## 342 C 0 0
## 343 0 0 0

get_symbols <- function() {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE,
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}

prob <- c("DD" = 0.03, "7" = 0.03, "BBB" = 0.06,
          "BB" = 0.1, "B" = 0.25, "C" = 0.01, "0" = 0.52)

combos$prob1 <- prob[combos$Var1]
combos$prob2 <- prob[combos$Var2]
combos$prob3 <- prob[combos$Var3]
head(combos, 3)
## Var1 Var2 Var3 prob1 prob2 prob3
## DD DD DD 0.03 0.03 0.03
## 7 DD DD 0.03 0.03 0.03
## BBB DD DD 0.06 0.03 0.03

combos$prob <- combos$prob1 * combos$prob2 * combos$prob3
head(combos, 3)
## Var1 Var2 Var3 prob1 prob2 prob3 prob
## DD DD DD 0.03 0.03 0.03 0.000027
## 7 DD DD 0.03 0.03 0.03 0.000027
## BBB DD DD 0.06 0.03 0.03 0.000054


sum(combos$prob)
## 1

symbols <- c(combos[1, 1], combos[1, 2], combos[1, 3])
## "DD" "DD" "DD"

score(symbols)
## 800

for (value in c("My", "first", "for", "loop")) {
  print("one run")
}
## "one run"
## "one run"
## "one run"
## "one run"

for (value in c("My", "second", "for", "loop")) {
  print(value)
}
## "My"
## "second"
## "for"
## "loop"

value
## "loop"

for (word in c("My", "second", "for", "loop")) {
  print(word)
}
for (string in c("My", "second", "for", "loop")) {
  print(string)
}
for (i in c("My", "second", "for", "loop")) {
  print(i)
}

for (value in c("My", "third", "for", "loop")) {
  value
}
##

chars <- vector(length = 4)

words <- c("My", "fourth", "for", "loop")
for (i in 1:4) {
  chars[i] <- words[i]
}
chars
## "My" "fourth" "for" "loop"

combos$prize <- NA
head(combos, 3)
## Var1 Var2 Var3 prob1 prob2 prob3 prob prize
## DD DD DD 0.03 0.03 0.03 0.000027 NA
## 7 DD DD 0.03 0.03 0.03 0.000027 NA
## BBB DD DD 0.06 0.03 0.03 0.000054 NA

for (i in 1:nrow(combos)) {
  symbols <- c(combos[i, 1], combos[i, 2], combos[i, 3])
  combos$prize[i] <- score(symbols)
}

head(combos, 3)
## Var1 Var2 Var3 prob1 prob2 prob3 prob prize
## DD DD DD 0.03 0.03 0.03 0.000027 800
## 7 DD DD 0.03 0.03 0.03 0.000027 0
## BBB DD DD 0.06 0.03 0.03 0.000054 0

sum(combos$prize * combos$prob)
## 0.538014

score <- function(symbols) {
  diamonds <- sum(symbols == "DD")
  cherries <- sum(symbols == "C")
  # identify case
  # since diamonds are wild, only nondiamonds
  # matter for three of a kind and all bars
  slots <- symbols[symbols != "DD"]
  same <- length(unique(slots)) == 1
  bars <- slots %in% c("B", "BB", "BBB")
  # assign prize
  if (diamonds == 3) {
    prize <- 100
  } else if (same) {
    payouts <- c("7" = 80, "BBB" = 40, "BB" = 25,
                 "B" = 10, "C" = 10, "0" = 0)
    prize <- unname(payouts[slots[1]])
  } else if (all(bars)) {
    prize <- 5
  } else if (cherries > 0) {
    # diamonds count as cherries
    # so long as there is one real cherry
    prize <- c(0, 2, 5)[cherries + diamonds + 1]
  } else {
    prize <- 0
  }
  # double for each diamond
  prize * 2^diamonds
}

for (i in 1:nrow(combos)) {
  symbols <- c(combos[i, 1], combos[i, 2], combos[i, 3])
  combos$prize[i] <- score(symbols)
}

sum(combos$prize * combos$prob)
## 0.934356

plays_till_broke <- function(start_with) {
  cash <- start_with
  n <- 0
  while (cash > 0) {
    cash <- cash - 1 + play()
    n <- n + 1
  }
  n
}
plays_till_broke(100)
## 269

plays_till_broke <- function(start_with) {
  cash <- start_with
  n <- 0
  repeat {
    cash <- cash - 1 + play()
    n <- n + 1
    if (cash <= 0) {
      break
    }
  }
  n
}
plays_till_broke(100)
## 370



