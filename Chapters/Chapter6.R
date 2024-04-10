deal(deck)
## face suit value
## king spades 13
deal(deck)
## face suit value
## king spades 13
deal(deck)
## face suit value
## king spades 13

library(devtools)

parenvs(all = TRUE)
## Error in parenvs(all = TRUE) : could not find function "parenvs" 
## I looked up on internet and it was saying that this function has been
## removed from the devtools library


as.environment("package:stats")
##<environment: package:stats>
##  attr(,"name")
##[1] "package:stats"
##attr(,"path")
##[1] "C:/Program Files/R/R-4.3.2/library/stats"

globalenv()
## <environment: R_GlobalEnv>
baseenv()
## <environment: base>
emptyenv()
##<environment: R_EmptyEnv>

parent.env(globalenv())
## <environment: package:devtools>
## attr(,"name")
## [1] "package:devtools"
## attr(,"path")
## [1] "C:/Users/timot/AppData/Local/R/win-library/4.3/devtools"

parent.env(emptyenv())
## Error in parent.env(emptyenv()) : the empty environment has no parent

ls(emptyenv())

## character(0)
ls(globalenv())
##[1] "a"             "b"             "c"             "deal"         
##[5] "deck"          "deck2"         "deck3"         "deck4"        
##[9] "deck5"         "facecard"      "lst"           "new"          
##[13] "queenOfSpades" "random"        "rows"          "shuffle"      
##[17] "vec"           "w"             "x"             "y"            
##[21] "z"

head(globalenv()$deck, 3)
## face suit value
## king spades 13
## queen spades 12
## jack spades 11

assign("new", "Hello Global", envir = globalenv())
globalenv()$new
## "Hello Global"

  
new
## "Hello Global"

new <- "Hello Active"
new
## "Hello Active"

roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}

show_env <- function(){
  list(ran.in = environment(),
       parent = parent.env(environment()),
       objects = ls.str(environment()))
}

show_env()
## $ran.in
## <environment: 0x7ff711d12e28>
##
## $parent
## <environment: R_GlobalEnv>
##
## $objects

show_env()
## $ran.in
## <environment: 0x7ff715f49808>
##
## $parent
## <environment: R_GlobalEnv>
##
## $objects

environment(show_env)
## <environment: R_GlobalEnv>

environment(parenvs)
## Error: object 'parenvs' not found

show_env <- function(){
  a <- 1
  b <- 2
  c <- 3
  list(ran.in = environment(),
       parent = parent.env(environment()),
       objects = ls.str(environment()))
}

show_env()
## $ran.in
## <environment: 0x000001bd2b0fe7c0>
##
## $parent
## <environment: R_GlobalEnv>
##
## $objects
## a : num 1
## b : num 2
## c : num 3


foo <- "take me to your runtime"
show_env <- function(x = foo){
  list(ran.in = environment(),
       parent = parent.env(environment()),
       objects = ls.str(environment()))
}
show_env()
## $ran.in
## <environment: 0x000001bd2b3ed790>
##
## $parent
## <environment: R_GlobalEnv>
##
## $objects
## x : chr "take me to your runtime"

deal <- function() {
  deck[1, ]
}

environment(deal)
## <environment: R_GlobalEnv>

deal()
## face suit value
## king spades 13

deal()
## face suit value
## king spades 13

deal()
## face suit value
## king spades 13

DECK <- deck
deck <- deck[-1, ]

head(deck, 3)
## face suit value
## queen spades 12
## jack spades 11
## ten spades 10

deal <- function() {
  card <- deck[1, ]
  deck <- deck[-1, ]
  card
}

deal <- function() {
  card <- deck[1, ]
  assign("deck", deck[-1, ], envir = globalenv())
  card
}

deal()
## face suit value
## queen spades 12

deal()
## face suit value
## jack spades 11

deal()
## face suit value
## ten spades 10

shuffle <- function(cards) {
  random <- sample(1:52, size = 52)
  cards[random, ]
}

head(deck, 3)
## face suit value
## nine spades 9
## eight spades 8
## seven spades 7

a <- shuffle(deck)

head(deck, 3)
## face suit value
## nine spades 9
## eight spades 8
## seven spades 7

head(a, 3)
## queen diamonds    12
##  jack   hearts    11
##  five   spades     5


shuffle <- function(){
  random <- sample(1:52, size = 52)
  assign("deck", DECK[random, ], envir = globalenv())
}

shuffle()

deal()
## face     suit value
##  six diamonds     6

deal()
## face     suit value
##  six diamonds     6

setup <- function(deck) {
  DECK <- deck
  DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = globalenv())
    card
  }
  SHUFFLE <- function(){
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = globalenv())
  }
}

setup <- function(deck) {
  DECK <- deck
  DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = globalenv())
    card
  }
  SHUFFLE <- function(){
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = globalenv())
  }
  list(deal = DEAL, shuffle = SHUFFLE)
}

cards <- setup(deck)

deal <- cards$deal

shuffle <- cards$shuffle

deal
## function() {
## card <- deck[1, ]
## assign("deck", deck[-1, ], envir = globalenv())
## card
## }
## <environment: 0x000001bd2a6354f8>

shuffle
##function(){
##  random <- sample(1:52, size = 52)
##  assign("deck", DECK[random, ], envir = globalenv())
##}
##<environment: 0x000001bd2a6354f8>

environment(deal)
## <environment: 0x000001bd2a6354f8>
environment(shuffle)
## <environment: 0x000001bd2a6354f8>

setup <- function(deck) {
  DECK <- deck
  DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = parent.env(environment()))
    card
  }
  SHUFFLE <- function(){
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = parent.env(environment()))
  }
  list(deal = DEAL, shuffle = SHUFFLE)
}
cards <- setup(deck)
deal <- cards$deal
shuffle <- cards$shuffle

rm(deck)
shuffle()
deal()
## face   suit value
## 4  ten spades    10

deal()
## face suit value
## jack clubs 11




