lab5
================
2023-10-02

### 1. Reporte detallado de missing data para todas las columnas.

``` r
titanic_md <- read.csv("titanic_MD.csv")
summary(titanic_md)
```

    ##   PassengerId       Survived          Pclass          Name          
    ##  Min.   :  2.0   Min.   :0.0000   Min.   :1.000   Length:183        
    ##  1st Qu.:263.5   1st Qu.:0.0000   1st Qu.:1.000   Class :character  
    ##  Median :457.0   Median :1.0000   Median :1.000   Mode  :character  
    ##  Mean   :455.4   Mean   :0.6721   Mean   :1.191                     
    ##  3rd Qu.:676.0   3rd Qu.:1.0000   3rd Qu.:1.000                     
    ##  Max.   :890.0   Max.   :1.0000   Max.   :3.000                     
    ##                                                                     
    ##      Sex                 Age            SibSp            Parch      
    ##  Length:183         Min.   : 0.92   Min.   :0.0000   Min.   :0.000  
    ##  Class :character   1st Qu.:24.00   1st Qu.:0.0000   1st Qu.:0.000  
    ##  Mode  :character   Median :35.50   Median :0.0000   Median :0.000  
    ##                     Mean   :35.69   Mean   :0.4611   Mean   :0.462  
    ##                     3rd Qu.:48.00   3rd Qu.:1.0000   3rd Qu.:1.000  
    ##                     Max.   :80.00   Max.   :3.0000   Max.   :4.000  
    ##                     NA's   :25      NA's   :3        NA's   :12     
    ##     Ticket               Fare           Cabin             Embarked        
    ##  Length:183         Min.   :  0.00   Length:183         Length:183        
    ##  Class :character   1st Qu.: 29.70   Class :character   Class :character  
    ##  Mode  :character   Median : 56.93   Mode  :character   Mode  :character  
    ##                     Mean   : 78.96                                        
    ##                     3rd Qu.: 90.54                                        
    ##                     Max.   :512.33                                        
    ##                     NA's   :8

### 2. Especificar qué tipo de modelo se utilizará.

Age: Imputacion (por ser numerica) Sex, Embarked: Imputacion por moda
(categorical)

``` r
complete_rows <- complete.cases(titanic_md)
which(complete_rows == TRUE)
```

    ##   [1]   1   2   3   6   8  10  11  12  16  17  18  19  20  22  23  25  26  27
    ##  [19]  28  29  30  32  33  34  35  36  37  39  41  44  46  47  49  50  51  53
    ##  [37]  54  55  56  57  58  59  60  61  62  64  65  67  68  69  70  73  74  75
    ##  [55]  76  77  78  79  80  81  82  84  85  86  87  88  90  91  92  93  94  95
    ##  [73]  96  97  98  99 100 101 102 105 106 107 109 110 112 113 114 115 116 117
    ##  [91] 118 119 120 121 123 124 125 126 128 129 131 132 133 134 135 136 137 138
    ## [109] 139 140 141 142 144 146 147 148 149 151 152 153 154 155 156 157 158 159
    ## [127] 160 161 162 166 168 169 170 171 172 173 174 175 177 178 182

``` r
titanic_md$Age[is.na(titanic_md$Age)] <- mean(titanic_md$Age, na.rm = TRUE)

model <- lm(Age ~ Pclass + Sex + SibSp, data = titanic_md)
predicted_values <- predict(model, newdata = titanic_md)
titanic_md$Age[is.na(titanic_md$Age)] <- predicted_values[is.na(titanic_md$Age)]

std_dev <- sd(titanic_md$Age, na.rm = TRUE)
mean_val <- mean(titanic_md$Age, na.rm = TRUE)
outliers <- which(titanic_md$Age < mean_val - 3*std_dev | titanic_md$Age > mean_val + 3*std_dev)
titanic_md$Age[outliers] <- NA
```

### 5. Comparar metodos de “titanic.csv”

``` r
titanic <- read.csv("titanic.csv")
# Now you could measure the accuracy of your imputations using various metrics, e.g., RMSE
```

# Parte 2

### Normalizacion

``` r
titanic_md$Age <- scale(titanic_md$Age)

min_max_scaler <- preProcess(titanic_md, method = "range")
titanic_md <- predict(min_max_scaler, newdata = titanic_md)

max_val = max(abs(titanic_md$Age), na.rm = TRUE)
titanic_md$Age <- titanic_md$Age / max_val
```
