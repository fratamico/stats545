# class_regex



## Setup


```r
#install.packages("stringr")
library("stringr")
library("dplyr")
```

```
## 
## Attaching package: 'dplyr'
## 
## The following objects are masked from 'package:stats':
## 
##     filter, lag
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library("ggplot2")
```


## Basic string manipulaiton

```r
test_str <- c("STAT545 is great!", "Wooooo!")
nchar(test_str)
```

```
## [1] 17  7
```

```r
#Extract the 1st through 7th elements
substr(test_str, 1, 7)
```

```
## [1] "STAT545" "Wooooo!"
```

```r
#Replace the 1st through 7th elemebt with SCIENCE
substr(test_str, 1, 7) <- "SCIENCE"
test_str
```

```
## [1] "SCIENCE is great!" "SCIENCE"
```

## paste - concatenate or combine strings

```r
#default is a single space
paste("abc", "efg")
```

```
## [1] "abc efg"
```

```r
#can define a separator
paste("abc", "efg", sep = "")
```

```
## [1] "abcefg"
```

```r
#or eqivalently
paste0("abc", "efg")
```

```
## [1] "abcefg"
```

```r
#to combine multi value vectors, also need collapse
paste(c("abc", "efg"), c("hij", "klm"), sep = "", collapse = "")
```

```
## [1] "abchijefgklm"
```

## strsplit - split a string into a list of substrings


```r
x <- c("abc,cbe", "cb,gb,aaa")
#split based on commas
strsplit(x, split = ",")
```

```
## [[1]]
## [1] "abc" "cbe"
## 
## [[2]]
## [1] "cb"  "gb"  "aaa"
```

```r
#that returns a list, so perhaps we only want every second element of each
strsplit(x, split = ",") %>% lapply(function(x) x[2])
```

```
## [[1]]
## [1] "cbe"
## 
## [[2]]
## [1] "gb"
```

## Regex in R

R has some regex that makes it more readable. Can also use the \\w etc equivalents. Examples:

* \w = [[:alnum:]]
* \d = [[:digit:]]
* \s = [[:space:]]

You often need to double escape, eg \\\\w

## Load some tweets to experiment with


```r
news_tweets <- read.delim("https://www.dropbox.com/s/cbgcpkizun51wbk/news_tweets.txt?dl=1", header = TRUE, stringsAsFactors = FALSE, sep = "\t", quote = "", allowEscapes = TRUE)
glimpse(news_tweets)
```

```
## Observations: 858
## Variables: 4
## $ user_name (chr) "CBC", "CBC", "CBC", "CBC", "CBC", "CBC", "CBC", "CB...
## $ created   (chr) "2015-10-28 14:54:49", "2015-10-28 14:54:48", "2015-...
## $ retweets  (int) 30, 8, 10, 51, 10, 15, 17, 10, 24, 6, 16, 23, 13, 17...
## $ text      (chr) "Officer who flipped student in desk to be let go, r...
```

* user_name = twitter user name (shortened)
* created = date tweeted
* retweets = number of retweets to date
* text = the raw text of the tweet

## grep - find a pattern in a character vector

```r
#find tweets that contain hashtags
# two identical ways of writing this regex:
hastag_pattern <- "#\\w+"
hastag_pattern <- "#[[:alnum:]]+"

#gives the row number of the tweet that contains a hashtag
grep(hastag_pattern, news_tweets$text)
```

```
##   [1]   5   7   9  11 175 206 260 269 274 276 277 279 282 287 292 305 308
##  [18] 309 310 311 321 327 333 338 340 343 348 349 351 358 360 362 364 366
##  [35] 367 369 371 386 387 388 397 404 405 407 408 411 422 425 434 435 437
##  [52] 439 440 441 442 453 455 457 459 460 464 467 469 471 487 500 502 503
##  [69] 505 507 508 510 512 513 514 515 516 517 518 520 521 522 523 530 531
##  [86] 532 535 536 537 540 541 542 543 544 545 546 548 549 550 551 552 553
## [103] 554 555 556 558 559 560 561 562 563 564 567 568 569 574 575 577 578
## [120] 579 580 581 582 583 584 585 586 588 589 591 592 593 594 596 597 598
## [137] 599 600 601 602 603 604 605 606 607 608 611 612 613 615 619 620 621
## [154] 622 623 625 634 639 640 641 642 644 646 647 648 649 650 656 657 658
## [171] 659 660 662 663 664 679 680 691 692 693 724 725 738 770 784 795 817
## [188] 818 819 826 829 830 831 832
```

```r
#Setting value = TRUE returns the actual value of the vector at those indexes:
grep(hastag_pattern, news_tweets$text, value = TRUE) %>% head(n = 5)
```

```
## [1] "Alberta will try to spend its way out of a slump, but it also needs oil to recover https://t.co/x2h24rKI39 #abbudget https://t.co/ANkckdlb7m"
## [2] "Volkswagen posted 1st quarterly loss in 15 years, as costs from emissions scandal mount https://t.co/Z9WEkQ96km #VW https://t.co/VaDVd5Mw2D" 
## [3] "#Tesla's new Autopilot software means self-driving cars are already on Canadian roads https://t.co/3ksvzhVvEX https://t.co/WsM8s3T73R"       
## [4] "Canada Post's door-to-door delivery debate reignites as Liberals set to take office https://t.co/3pXZ1BHtCe #cdnpoli https://t.co/aM4UvkVzRe"
## [5] "On @CBCMorningShow: Teal Pumpkin Project helps B.C. kids with food allergies feel 'safe' on #Halloween https://t.co/vzVtMSinIh"
```

```r
#cal also return the ones that do not contain has tag with invert=TRUE
grep(hastag_pattern, news_tweets$text, value = TRUE, invert = TRUE) %>% head(n = 5)
```

```
## [1] "Officer who flipped student in desk to be let go, report says https://t.co/yRcQG35zXn https://t.co/LgXCbaDtjk"                         
## [2] "Apple Pay coming to Canada this year with American Express partnership https://t.co/Whc2g3lLzP https://t.co/xru2gnWdrg"                
## [3] "Renovation nation: Canadians may spend record $53 billion fixing their homes this year https://t.co/lNGZtIuuih https://t.co/KrCQ1rh8go"
## [4] "Cosmetic ear cropping banned by B.C. veterinarians https://t.co/wlsXmOmBFC https://t.co/E9hFezNJZe"                                    
## [5] "'I wouldn't mind to go back to school': No teacher, no students and a vicious cycle https://t.co/I62zrvwTlZ https://t.co/BlKtD9uGQx"
```





