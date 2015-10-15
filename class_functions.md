# class_functions
Lauren Fratamico  
October 8, 2015  



## Setup

```r
library(gapminder)
```


## Compute max - min of gapminder$lifeExp


```r
max(gapminder$lifeExp) - min(gapminder$lifeExp)
```

```
## [1] 59.004
```

```r
diff(range(gapminder$lifeExp))
```

```
## [1] 59.004
```

```r
max_minus_min <- function(numeric_arary) max(numeric_arary) - min(numeric_arary)
max_minus_min(gapminder$lifeExp)
```

```
## [1] 59.004
```

```r
# let's test the function
max_minus_min(c(1, 2, 3, 4, 5))
```

```
## [1] 4
```

```r
max_minus_min(runif(100))
```

```
## [1] 0.9921712
```

```r
#the function can error if non-numeric displays
mmm <- function(x) {
  if (!is.numeric(x)) {
    stop("Sorry! This function only works for numeric input.\n", 
         "You have provided an object of class: ",  class(x))
  }
  #could also do:
  #stopifnot(is.numeric(x))
  max(x) - min(x)
}
```


