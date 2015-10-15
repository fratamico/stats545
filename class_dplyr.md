# class_dplyr
Lauren Fratamico  
September 29, 2015  



## Setup

Install and load dplyr and load gapminder:


```r
suppressPackageStartupMessages(library(dplyr)) #suppresses the output
library(gapminder)
```

Let's look at some gapminder data


```r
str(gapminder)
```

```
## 'data.frame':	1704 obs. of  6 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ year     : num  1952 1957 1962 1967 1972 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
```

```r
head(gapminder)
```

```
##       country continent year lifeExp      pop gdpPercap
## 1 Afghanistan      Asia 1952  28.801  8425333  779.4453
## 2 Afghanistan      Asia 1957  30.332  9240934  820.8530
## 3 Afghanistan      Asia 1962  31.997 10267083  853.1007
## 4 Afghanistan      Asia 1967  34.020 11537966  836.1971
## 5 Afghanistan      Asia 1972  36.088 13079460  739.9811
## 6 Afghanistan      Asia 1977  38.438 14880372  786.1134
```


Turn the data frame into a tbl_df. This is not necessary for dplyr, but it allows it some nice functions.

```r
gtbl <- tbl_df(gapminder)
gtbl
```

```
## Source: local data frame [1,704 x 6]
## 
##        country continent  year lifeExp      pop gdpPercap
##         (fctr)    (fctr) (dbl)   (dbl)    (dbl)     (dbl)
## 1  Afghanistan      Asia  1952  28.801  8425333  779.4453
## 2  Afghanistan      Asia  1957  30.332  9240934  820.8530
## 3  Afghanistan      Asia  1962  31.997 10267083  853.1007
## 4  Afghanistan      Asia  1967  34.020 11537966  836.1971
## 5  Afghanistan      Asia  1972  36.088 13079460  739.9811
## 6  Afghanistan      Asia  1977  38.438 14880372  786.1134
## 7  Afghanistan      Asia  1982  39.854 12881816  978.0114
## 8  Afghanistan      Asia  1987  40.822 13867957  852.3959
## 9  Afghanistan      Asia  1992  41.674 16317921  649.3414
## 10 Afghanistan      Asia  1997  41.763 22227415  635.3414
## ..         ...       ...   ...     ...      ...       ...
```

```r
glimpse(gtbl)
```

```
## Observations: 1,704
## Variables: 6
## $ country   (fctr) Afghanistan, Afghanistan, Afghanistan, Afghanistan,...
## $ continent (fctr) Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asi...
## $ year      (dbl) 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992...
## $ lifeExp   (dbl) 28.801, 30.332, 31.997, 34.020, 36.088, 38.438, 39.8...
## $ pop       (dbl) 8425333, 9240934, 10267083, 11537966, 13079460, 1488...
## $ gdpPercap (dbl) 779.4453, 820.8530, 853.1007, 836.1971, 739.9811, 78...
```


Can store subsets of data

```r
(snippet <- subset(gapminder, country == "Canada"))
```

```
##     country continent year lifeExp      pop gdpPercap
## 241  Canada  Americas 1952  68.750 14785584  11367.16
## 242  Canada  Americas 1957  69.960 17010154  12489.95
## 243  Canada  Americas 1962  71.300 18985849  13462.49
## 244  Canada  Americas 1967  72.130 20819767  16076.59
## 245  Canada  Americas 1972  72.880 22284500  18970.57
## 246  Canada  Americas 1977  74.210 23796400  22090.88
## 247  Canada  Americas 1982  75.760 25201900  22898.79
## 248  Canada  Americas 1987  76.860 26549700  26626.52
## 249  Canada  Americas 1992  77.950 28523502  26342.88
## 250  Canada  Americas 1997  78.610 30305843  28954.93
## 251  Canada  Americas 2002  79.770 31902268  33328.97
## 252  Canada  Americas 2007  80.653 33390141  36319.24
```

## Filtering

filter is useful for subsetting data row-wise

```r
filter(gtbl, lifeExp < 29)
```

```
## Source: local data frame [2 x 6]
## 
##       country continent  year lifeExp     pop gdpPercap
##        (fctr)    (fctr) (dbl)   (dbl)   (dbl)     (dbl)
## 1 Afghanistan      Asia  1952  28.801 8425333  779.4453
## 2      Rwanda    Africa  1992  23.599 7290203  737.0686
```

```r
filter(gtbl, country == "Rwanda")
```

```
## Source: local data frame [12 x 6]
## 
##    country continent  year lifeExp     pop gdpPercap
##     (fctr)    (fctr) (dbl)   (dbl)   (dbl)     (dbl)
## 1   Rwanda    Africa  1952  40.000 2534927  493.3239
## 2   Rwanda    Africa  1957  41.500 2822082  540.2894
## 3   Rwanda    Africa  1962  43.000 3051242  597.4731
## 4   Rwanda    Africa  1967  44.100 3451079  510.9637
## 5   Rwanda    Africa  1972  44.600 3992121  590.5807
## 6   Rwanda    Africa  1977  45.000 4657072  670.0806
## 7   Rwanda    Africa  1982  46.218 5507565  881.5706
## 8   Rwanda    Africa  1987  44.020 6349365  847.9912
## 9   Rwanda    Africa  1992  23.599 7290203  737.0686
## 10  Rwanda    Africa  1997  36.087 7212583  589.9445
## 11  Rwanda    Africa  2002  43.413 7852401  785.6538
## 12  Rwanda    Africa  2007  46.242 8860588  863.0885
```

```r
filter(gtbl, country %in% c("Rwanda", "Afghanistan"))
```

```
## Source: local data frame [24 x 6]
## 
##        country continent  year lifeExp      pop gdpPercap
##         (fctr)    (fctr) (dbl)   (dbl)    (dbl)     (dbl)
## 1  Afghanistan      Asia  1952  28.801  8425333  779.4453
## 2  Afghanistan      Asia  1957  30.332  9240934  820.8530
## 3  Afghanistan      Asia  1962  31.997 10267083  853.1007
## 4  Afghanistan      Asia  1967  34.020 11537966  836.1971
## 5  Afghanistan      Asia  1972  36.088 13079460  739.9811
## 6  Afghanistan      Asia  1977  38.438 14880372  786.1134
## 7  Afghanistan      Asia  1982  39.854 12881816  978.0114
## 8  Afghanistan      Asia  1987  40.822 13867957  852.3959
## 9  Afghanistan      Asia  1992  41.674 16317921  649.3414
## 10 Afghanistan      Asia  1997  41.763 22227415  635.3414
## ..         ...       ...   ...     ...      ...       ...
```

In base R, we could filter/subset like so:

```r
gapminder[gapminder$lifeExp < 29, ]
```

```
##          country continent year lifeExp     pop gdpPercap
## 1    Afghanistan      Asia 1952  28.801 8425333  779.4453
## 1293      Rwanda    Africa 1992  23.599 7290203  737.0686
```

```r
subset(gapminder, country == "Rwanda")
```

```
##      country continent year lifeExp     pop gdpPercap
## 1285  Rwanda    Africa 1952  40.000 2534927  493.3239
## 1286  Rwanda    Africa 1957  41.500 2822082  540.2894
## 1287  Rwanda    Africa 1962  43.000 3051242  597.4731
## 1288  Rwanda    Africa 1967  44.100 3451079  510.9637
## 1289  Rwanda    Africa 1972  44.600 3992121  590.5807
## 1290  Rwanda    Africa 1977  45.000 4657072  670.0806
## 1291  Rwanda    Africa 1982  46.218 5507565  881.5706
## 1292  Rwanda    Africa 1987  44.020 6349365  847.9912
## 1293  Rwanda    Africa 1992  23.599 7290203  737.0686
## 1294  Rwanda    Africa 1997  36.087 7212583  589.9445
## 1295  Rwanda    Africa 2002  43.413 7852401  785.6538
## 1296  Rwanda    Africa 2007  46.242 8860588  863.0885
```


## Pipe object

The pipe object pipes the left as the first argument to the right. More useful when chaining function calls - more readable.

```r
gapminder %>% head #same as head(gapminder)
```

```
##       country continent year lifeExp      pop gdpPercap
## 1 Afghanistan      Asia 1952  28.801  8425333  779.4453
## 2 Afghanistan      Asia 1957  30.332  9240934  820.8530
## 3 Afghanistan      Asia 1962  31.997 10267083  853.1007
## 4 Afghanistan      Asia 1967  34.020 11537966  836.1971
## 5 Afghanistan      Asia 1972  36.088 13079460  739.9811
## 6 Afghanistan      Asia 1977  38.438 14880372  786.1134
```

```r
gapminder %>% head(3)
```

```
##       country continent year lifeExp      pop gdpPercap
## 1 Afghanistan      Asia 1952  28.801  8425333  779.4453
## 2 Afghanistan      Asia 1957  30.332  9240934  820.8530
## 3 Afghanistan      Asia 1962  31.997 10267083  853.1007
```


Select with the pipe to get just the head

```r
select(gtbl, year, lifeExp)
```

```
## Source: local data frame [1,704 x 2]
## 
##     year lifeExp
##    (dbl)   (dbl)
## 1   1952  28.801
## 2   1957  30.332
## 3   1962  31.997
## 4   1967  34.020
## 5   1972  36.088
## 6   1977  38.438
## 7   1982  39.854
## 8   1987  40.822
## 9   1992  41.674
## 10  1997  41.763
## ..   ...     ...
```

```r
gtbl %>%
  select(year, lifeExp) %>%
  head(4)
```

```
## Source: local data frame [4 x 2]
## 
##    year lifeExp
##   (dbl)   (dbl)
## 1  1952  28.801
## 2  1957  30.332
## 3  1962  31.997
## 4  1967  34.020
```

More practive with pipe

```r
gtbl %>%
  filter(country == "Cambodia") %>%
  select(year, lifeExp)
```

```
## Source: local data frame [12 x 2]
## 
##     year lifeExp
##    (dbl)   (dbl)
## 1   1952  39.417
## 2   1957  41.366
## 3   1962  43.415
## 4   1967  45.415
## 5   1972  40.317
## 6   1977  31.220
## 7   1982  50.957
## 8   1987  53.914
## 9   1992  55.803
## 10  1997  56.534
## 11  2002  56.752
## 12  2007  59.723
```

```r
# typical R command would look like:
gapminder[gapminder$country == "Cambodia", c("year", "lifeExp")]
```

```
##     year lifeExp
## 217 1952  39.417
## 218 1957  41.366
## 219 1962  43.415
## 220 1967  45.415
## 221 1972  40.317
## 222 1977  31.220
## 223 1982  50.957
## 224 1987  53.914
## 225 1992  55.803
## 226 1997  56.534
## 227 2002  56.752
## 228 2007  59.723
```

```r
# or like:
subset(gapminder, country == "Cambodia", select = c(year, lifeExp))
```

```
##     year lifeExp
## 217 1952  39.417
## 218 1957  41.366
## 219 1962  43.415
## 220 1967  45.415
## 221 1972  40.317
## 222 1977  31.220
## 223 1982  50.957
## 224 1987  53.914
## 225 1992  55.803
## 226 1997  56.534
## 227 2002  56.752
## 228 2007  59.723
```




