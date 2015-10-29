# class_reading_writing



## Load gapminder data

```r
#this tells us where the file is. It's in the package gapminder, so we don't need to download it separatly.
(gap_tsv <- system.file("gapminder.tsv", package = "gapminder"))
```

```
## [1] "/usr/local/lib/R/3.2/site-library/gapminder/gapminder.tsv"
```

## Bring the data in

```r
#tab separated, no quoting characters
gapminder <- read.table(gap_tsv, header = TRUE, sep = "\t", quote = "")
str(gapminder)
```

```
## 'data.frame':	1704 obs. of  6 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
```

```r
#could instead use read.delim()
#what default values does read.delim have??? no quote chars?
#read.csv() is the equivalent for csv files
gapminder <- read.delim(gap_tsv)
str(gapminder)
```

```
## 'data.frame':	1704 obs. of  6 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
```

```r
#one other way is to use readr
#this will NOT convert the strings to factors
library(readr)
gapminder <- read_tsv(gap_tsv)
str(gapminder)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	1704 obs. of  6 variables:
##  $ country  : chr  "Afghanistan" "Afghanistan" "Afghanistan" "Afghanistan" ...
##  $ continent: chr  "Asia" "Asia" "Asia" "Asia" ...
##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
```

```r
#to convert to factors:
gapminder$country <- factor(gapminder$country)
gapminder$continent <- factor(gapminder$continent)
str(gapminder)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	1704 obs. of  6 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
```

## Function for linear modeling
To produce something worthy of export

```r
suppressPackageStartupMessages(library(dplyr))
le_lin_fit <- function(dat, offset = 1952) {
  the_fit <- lm(lifeExp ~ I(year - offset), dat)
  setNames(data.frame(t(coef(the_fit))), c("intercept", "slope"))
}
gfits <- gapminder %>%
  group_by(country, continent) %>% 
  do(le_lin_fit(.)) %>% 
  ungroup()
gfits
```

```
## Source: local data frame [142 x 4]
## 
##        country continent intercept     slope
##         (fctr)    (fctr)     (dbl)     (dbl)
## 1  Afghanistan      Asia  29.90729 0.2753287
## 2      Albania    Europe  59.22913 0.3346832
## 3      Algeria    Africa  43.37497 0.5692797
## 4       Angola    Africa  32.12665 0.2093399
## 5    Argentina  Americas  62.68844 0.2317084
## 6    Australia   Oceania  68.40051 0.2277238
## 7      Austria    Europe  66.44846 0.2419923
## 8      Bahrain      Asia  52.74921 0.4675077
## 9   Bangladesh      Asia  36.13549 0.4981308
## 10     Belgium    Europe  67.89192 0.2090846
## ..         ...       ...       ...       ...
```

## Write to file

```r
#This unfortunately writes the row numbers and has quotes areound everything
write.table(gfits, "gfits.tsv")
#"gifts.tsv" %>%
#  readlines(n=6) %>%
#  cat(sep="\n")

#Instead can do this
write.table(gfits, "gfits.tsv", quote = FALSE, sep = "\t", row.names = FALSE)

#readr works too! with less arguments
write_tsv(gfits, "gfits.tsv")
```

## Reorder

```r
head(levels(gfits$country)) # alphabetical order
```

```
## [1] "Afghanistan" "Albania"     "Algeria"     "Angola"      "Argentina"  
## [6] "Australia"
```

```r
gfits <- gfits %>% 
  mutate(country = reorder(country, intercept))
head(levels(gfits$country)) # in increasing order of 1952 life expectancy
```

```
## [1] "Gambia"        "Afghanistan"   "Yemen, Rep."   "Sierra Leone" 
## [5] "Guinea"        "Guinea-Bissau"
```

```r
head(gfits)
```

```
## Source: local data frame [6 x 4]
## 
##       country continent intercept     slope
##        (fctr)    (fctr)     (dbl)     (dbl)
## 1 Afghanistan      Asia  29.90729 0.2753287
## 2     Albania    Europe  59.22913 0.3346832
## 3     Algeria    Africa  43.37497 0.5692797
## 4      Angola    Africa  32.12665 0.2093399
## 5   Argentina  Americas  62.68844 0.2317084
## 6   Australia   Oceania  68.40051 0.2277238
```

## saveRDS() and readRDS()


```r
#writes an R object to file
#for example,m this would save the manipulation of factor levels
saveRDS(gfits, "gfits.rds")

#to read it back
rm(gfits)
gfits
```

```
## Error in eval(expr, envir, enclos): object 'gfits' not found
```

```r
gfits <- readRDS("gfits.rds")
gfits
```

```
## Source: local data frame [142 x 4]
## 
##        country continent intercept     slope
##         (fctr)    (fctr)     (dbl)     (dbl)
## 1  Afghanistan      Asia  29.90729 0.2753287
## 2      Albania    Europe  59.22913 0.3346832
## 3      Algeria    Africa  43.37497 0.5692797
## 4       Angola    Africa  32.12665 0.2093399
## 5    Argentina  Americas  62.68844 0.2317084
## 6    Australia   Oceania  68.40051 0.2277238
## 7      Austria    Europe  66.44846 0.2419923
## 8      Bahrain      Asia  52.74921 0.4675077
## 9   Bangladesh      Asia  36.13549 0.4981308
## 10     Belgium    Europe  67.89192 0.2090846
## ..         ...       ...       ...       ...
```


## Play around with some data

```r
# install.packages("googlesheets")
# or
# devtools::install_github("jennybc/googlesheets")
library(googlesheets)
library(dplyr)
library(readr)

#need to go to website
gs_auth(new_user = TRUE)
```

```
## httpuv not installed, defaulting to out-of-band authentication
```

```
## Error: interactive() is not TRUE
```

```r
candy_key <- "1REZvjqv0lj3dEYb0CsGyDXkXrjhJ4izlAEImgaufjCc"
candy_ss <- candy_key %>% 
  gs_key(lookup = FALSE)  
```

```
## Authentication will not be used.
## Worksheets feed constructed with public visibility
```

```r
candy_ss
```

```
##                   Spreadsheet title: CANDY HIERARCHY 2015 SURVEY (Responses)
##                  Spreadsheet author: davehwng
##   Date of googlesheets registration: 2015-10-27 17:50:02 GMT
##     Date of last spreadsheet update: 2015-10-27 17:49:11 GMT
##                          visibility: public
##                         permissions: rw
##                             version: new
## 
## Contains 1 worksheets:
## (Title): (Nominal worksheet extent as rows x columns)
## Form Responses 1: 2817 x 148
## 
## Key: 1REZvjqv0lj3dEYb0CsGyDXkXrjhJ4izlAEImgaufjCc
## Browser URL: https://docs.google.com/spreadsheets/d/1REZvjqv0lj3dEYb0CsGyDXkXrjhJ4izlAEImgaufjCc/
```

```r
## for the moment, read to local csv then import
candy_ss %>%
  gs_download(to = "candy.csv")
```

```
## httpuv not installed, defaulting to out-of-band authentication
```

```
## Error: interactive() is not TRUE
```

```r
candy <- read_csv("candy.csv")
```

```
## Error: 'candy.csv' does not exist in current working directory ('/Users/laurenfratamico/Documents/school/stats545/class_notes').
```

```r
candy
```

```
## Error in eval(expr, envir, enclos): object 'candy' not found
```


