# class_tidydata_reshaping
Lauren Fratamico  
October 15, 2015  



## Setup



```r
#install.packages("devtools")
library(devtools)
#install_github("rstudio/EDAWR")
library(EDAWR)

#install.packages("tidyr")
library(tidyr)
```


## tidyr functions

```r
?gather
?spread

gather(cases, "year", "n", 2:4)
```

```
##   country year     n
## 1      FR 2011  7000
## 2      DE 2011  5800
## 3      US 2011 15000
## 4      FR 2012  6900
## 5      DE 2012  6000
## 6      US 2012 14000
## 7      FR 2013  7000
## 8      DE 2013  6200
## 9      US 2013 13000
```

```r
#cases is the data frame to reshape
#year is the name of the new column (key)
#n is the name of the new column (value)
#2:4 is the names or numeric indexes of columns to collapse
```

