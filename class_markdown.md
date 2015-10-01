# class_markdown
Lauren Fratamico  
September 24, 2015  




Grab the data

```r
library(RCurl)
```

```
## Loading required package: bitops
```

```r
x <- getURL("https://gist.githubusercontent.com/jennybc/924fe242a31e0239762f/raw/ea615f4a811a6e9e8a1fe95020a4407785181a21/2015_STAT545_enrollment.csv")
y <- read.csv(text = x)
```


