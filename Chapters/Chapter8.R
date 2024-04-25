

play()
## "0" "0" "DD"
## 0

num <- 1000000000
print(num)
## 1e+09

class(num) <- c("POSIXct", "POSIXt")
print(num)
## "2001-09-08 20:46:40 CDT"

attributes(DECK)
## $names
## [1] "face" "suit" "value"
##
## $class
## [1] "data.frame"
##
## $row.names
## [1] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
## [20] 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
## [37] 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52

row.names(DECK)
## [1] "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13"
## [14] "14" "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26"
## [27] "27" "28" "29" "30" "31" "32" "33" "34" "35" "36" "37" "38" "39"
## [40] "40" "41" "42" "43" "44" "45" "46" "47" "48" "49" "50" "51" "52"

row.names(DECK) <- 101:152

levels(DECK) <- c("level 1", "level 2", "level 3")
attributes(DECK)
## $names
## [1] "face" "suit" "value"
##
## $class
## [1] "data.frame"
##
## $row.names
## [1] 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117
## [18] 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134
## [35] 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151
## [52] 152
##
## $levels
## [1] "level 1" "level 2" "level 3"

one_play <- play()
one_play
## 0
attributes(one_play)
## NULL

attr(one_play, "symbols") <- c("B", "0", "B")
attributes(one_play)
## $symbols
## [1] "B" "0" "B"

attr(one_play, "symbols")
## "B" "0" "B"

one_play
## [1] 0
## attr(,"symbols")
## [1] "B" "0" "B"

one_play + 1
## 1
## attr(,"symbols")
## "B" "0" "B"

play <- function() {
  symbols <- get_symbols()
  prize <- score(symbols)
  attr(prize, "symbols") <- symbols
  prize
}

play()
## [1] 0
## attr(,"symbols")
## [1] "B" "BB" "0"
two_play <- play()
two_play
## [1] 0
## attr(,"symbols")
## [1] "0" "B" "0"

play <- function() {
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols)
}

three_play <- play()
three_play
## 0
## attr(,"symbols")
## "0" "BB" "B"

slot_display <- function(prize){
  # extract symbols
  symbols <- attr(prize, "symbols")
  # collapse symbols into single string
  symbols <- paste(symbols, collapse = " ")
  # combine symbol with prize as a regular expression
  # \n is regular expression for new line (i.e. return or enter)
  string <- paste(symbols, prize, sep = "\n$")
  # display regular expression in console without quotes
  cat(string)
}

slot_display(one_play)
## B 0 B
## $0

symbols <- attr(one_play, "symbols")
symbols
## "B" "0" "B"

symbols <- paste(symbols, collapse = " ")
symbols
## "B 0 B"

prize <- one_play
string <- paste(symbols, prize, sep = "\n$")
string
## "B 0 B\n$0"

cat(string)
## B 0 B
## $0

slot_display(play())
## 7 0 0
## $0

slot_display(play())
## BB 0 0
## $0

print(pi)
## 3.141593

pi
## 3.141593

print(head(deck))
## face suit value
## king spades 13
## queen spades 12
## jack spades 11
## ten spades 10
## nine spades 9
## eight spades 8

head(deck)
## face suit value
## king spades 13
## queen spades 12
## jack spades 11
## ten spades 10
## nine spades 9
## eight spades 8

print(play())
## 0
## attr(,"symbols")
## "0" "0" "B"

play()
## 0
## attr(,"symbols")
## "0" "BB" "BB"

num <- 1000000000
print(num)
## 1e+09

class(num) <- c("POSIXct", "POSIXt")
print(num)
## "2001-09-08 20:46:40 CDT"

print
## function (x, ...)
## UseMethod("print")
## <bytecode: 0x0000019197094810>
## <environment: namespace:base>

print.POSIXct
## function (x, ...)
## {
## max.print <- getOption("max.print", 9999L)
## if (max.print < length(x)) {
## print(format(x[seq_len(max.print)], usetz = TRUE), ...)
## cat(" [ reached getOption(\"max.print\") -- omitted",
## length(x) - max.print, "entries ]\n")
## }
## else print(format(x, usetz = TRUE), ...)
## invisible(x)
## }
## <bytecode: 0x000001919832aeb8>
## <environment: namespace:base>

print.factor
## function (x, quote = FALSE, max.levels = NULL, width = getOption("width"),
## ...)
## {
## ord <- is.ordered(x)
## if (length(x) == 0L)
## cat(if (ord)
## "ordered"
## ...
## drop <- n > maxl
## cat(if (drop)
## paste(format(n), ""), T0, paste(if (drop)
## c(lev[1L:max(1, maxl - 1)], "...", if (maxl > 1) lev[n])
## else lev, collapse = colsep), "\n", sep = "")
## }
## invisible(x)
## }
## <bytecode: 0x00000191980ca8a8>
## <environment: namespace:base>

methods(print)
## [1] print.acf*
## [2] print.anova
## [3] print.aov*
## ...
## [176] print.xgettext*
## [177] print.xngettext*
## [178] print.xtabs*
##
## Nonvisible functions are asterisked

class(one_play) <- "slots"

args(print)
## function (x, ...)
## NULL
print.slots <- function(x, ...) {
  cat("I'm using the print.slots method")
}

print(one_play)
## I'm using the print.slots method
one_play
## I'm using the print.slots method
rm(print.slots)

now <- Sys.time()
attributes(now)
## $class
## [1] "POSIXct" "POSIXt"


print.slots <- function(x, ...) {
  slot_display(x)
}

one_play
## B 0 B
## $0

play <- function() {
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols, class = "slots")
}


class(play())
## "slots"

play()
## 0 0 B
## $0
play()
## 0 0 B
## $0

methods(class = "factor")
## [1] [.factor [[.factor
## [3] [[<-.factor [<-.factor
## [5] all.equal.factor as.character.factor
## [7] as.data.frame.factor as.Date.factor
## [9] as.list.factor as.logical.factor
## [11] as.POSIXlt.factor as.vector.factor
## [13] droplevels.factor format.factor
## [15] is.na<-.factor length<-.factor
## [17] levels<-.factor Math.factor
## [19] Ops.factor plot.factor*
## [21] print.factor relevel.factor*
## [23] relist.factor* rep.factor
## [25] summary.factor Summary.factor
## [27] xtfrm.factor
##
## Nonvisible functions are asterisked


play1 <- play()
play1
## BBB 0 0
## $0
play2 <- play()
play2
## 0 B 0
## $0
c(play1, play2)
## [1] 0 0

play1[1]
## [1] 0


