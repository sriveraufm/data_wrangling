lab5
================
2023-10-02

### 1. Reporte detallado de missing data para todas las columnas.

``` r
titanic_md <- read.csv("titanic_MD.csv")

missing_data_percentage <- titanic_md %>% 
  summarise(
    PassengerId = mean(is.na(PassengerId)) * 100,
    Survived = mean(is.na(Survived)) * 100,
    Pclass = mean(is.na(Pclass)) * 100,
    Name = mean(is.na(Name)) * 100,
    Sex = mean(is.na(Sex)) * 100,
    Age = mean(is.na(Age) | Age == "?") * 100,
    SibSp = mean(is.na(SibSp) | SibSp == "NA") * 100,
    Parch = mean(is.na(Parch) | Parch == "NA") * 100,
    Ticket = mean(is.na(Ticket)) * 100,
    Fare = mean(is.na(Fare)) * 100,
    Cabin = mean(is.na(Cabin)) * 100,
    Embarked = mean(is.na(Embarked)) * 100
  )

print(missing_data_percentage)
```

    ##   PassengerId Survived Pclass Name Sex     Age    SibSp    Parch Ticket
    ## 1           0        0      0    0   0 13.6612 1.639344 6.557377      0
    ##       Fare Cabin Embarked
    ## 1 4.371585     0        0

# 3. Reporte de qué filas están completas (5%)

``` r
filas_completas <- complete.cases(titanic_md)

titanic_md_completas <- titanic_md[filas_completas, ]

summary(filas_completas)
```

    ##    Mode   FALSE    TRUE 
    ## logical      42     141

### 2. Para cada columna especificar qué tipo de modelo se utilizará (solo el nombre y el porqué) y qué valores se le darán a todos los missing values. (Ej. Imputación sectorizada por la moda, bins, y cualquier otro método visto anteriormente). (10%)

#### Columnas sin datos faltantes

##### PassengerId, Survived, Pclass, Name, Sex, Ticket, Cabin, Embarked

#### Columnas sin datos faltantes

#### 1.

##### Age (13.66% de datos faltantes)

##### Modelo: Imputacion K-NN

##### Razon: La edad podría tener una correlación no lineal con otras características y K-NN podria reflejar esto mejor que otros metodos

#### 2. SibSp (1.64% de datos faltantes)

##### Modelo: Imputacion por la moda

##### Razon: Es un modelo sencillo y el porcentaje de datos faltantes es bajo

#### 3. Parch (6.56% de datos faltantes)

##### Modelo: Imputacion por la mediana

##### Razon: La mediana es apropiada para datos asimetricos

#### 4. Fare (4.37% de datos faltantes)

##### Modelo: Imputacion por la media

##### Razon: Se puede imputar a traves de la columna Pclass y es apropiada para esta columna

``` r
# Age
vars_to_impute <- c("Age", "Pclass", "SibSp", "Parch", "Fare")
temp_data <- titanic_md[ , vars_to_impute]
imputed_data <- missForest(temp_data)$ximp
```

    ## Warning in randomForest.default(x = obsX, y = obsY, ntree = ntree, mtry =
    ## mtry, : The response has five or fewer unique values. Are you sure you want to
    ## do regression?

    ## Warning in randomForest.default(x = obsX, y = obsY, ntree = ntree, mtry =
    ## mtry, : The response has five or fewer unique values. Are you sure you want to
    ## do regression?

    ## Warning in randomForest.default(x = obsX, y = obsY, ntree = ntree, mtry =
    ## mtry, : The response has five or fewer unique values. Are you sure you want to
    ## do regression?

    ## Warning in randomForest.default(x = obsX, y = obsY, ntree = ntree, mtry =
    ## mtry, : The response has five or fewer unique values. Are you sure you want to
    ## do regression?

    ## Warning in randomForest.default(x = obsX, y = obsY, ntree = ntree, mtry =
    ## mtry, : The response has five or fewer unique values. Are you sure you want to
    ## do regression?

    ## Warning in randomForest.default(x = obsX, y = obsY, ntree = ntree, mtry =
    ## mtry, : The response has five or fewer unique values. Are you sure you want to
    ## do regression?

    ## Warning in randomForest.default(x = obsX, y = obsY, ntree = ntree, mtry =
    ## mtry, : The response has five or fewer unique values. Are you sure you want to
    ## do regression?

    ## Warning in randomForest.default(x = obsX, y = obsY, ntree = ntree, mtry =
    ## mtry, : The response has five or fewer unique values. Are you sure you want to
    ## do regression?

``` r
titanic_md$Age <- imputed_data$Age

# SibSp
mode_value <- as.numeric(names(sort(table(titanic_md$SibSp), decreasing=TRUE)[1]))
titanic_md$SibSp[is.na(titanic_md$SibSp)] <- mode_value

# Parch
median_value <- median(titanic_md$Parch, na.rm = TRUE)
titanic_md$Parch[is.na(titanic_md$Parch)] <- median_value

# Fare
titanic_md <- titanic_md %>% 
  group_by(Pclass) %>% 
  mutate(Fare = ifelse(is.na(Fare), mean(Fare, na.rm = TRUE), Fare))
```

``` r
missing_data_percentage <- titanic_md %>% 
  summarise(
    PassengerId = mean(is.na(PassengerId)) * 100,
    Survived = mean(is.na(Survived)) * 100,
    Pclass = mean(is.na(Pclass)) * 100,
    Name = mean(is.na(Name)) * 100,
    Sex = mean(is.na(Sex)) * 100,
    Age = mean(is.na(Age) | Age == "?") * 100,
    SibSp = mean(is.na(SibSp) | SibSp == "NA") * 100,
    Parch = mean(is.na(Parch) | Parch == "NA") * 100,
    Ticket = mean(is.na(Ticket)) * 100,
    Fare = mean(is.na(Fare)) * 100,
    Cabin = mean(is.na(Cabin)) * 100,
    Embarked = mean(is.na(Embarked)) * 100
  )

print(missing_data_percentage)
```

    ## # A tibble: 3 × 12
    ##   Pclass PassengerId Survived  Name   Sex   Age SibSp Parch Ticket  Fare Cabin
    ##    <dbl>       <dbl>    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl>
    ## 1      0           0        0     0     0     0     0     0      0     0     0
    ## 2      0           0        0     0     0     0     0     0      0     0     0
    ## 3      0           0        0     0     0     0     0     0      0     0     0
    ## # … with 1 more variable: Embarked <dbl>

# 4. Utilizar los siguientes métodos para cada columna que contiene missing values: (50%)

# a. Imputación general (media, moda y mediana)

# b. Modelo de regresión lineal

# c. Outliers: Uno de los dos métodos vistos en clase (Standard deviation approach o Percentile approach)

``` r
# Age
age_mean <- mean(titanic_md$Age, na.rm = TRUE)
titanic_md$Age_Media <- ifelse(is.na(titanic_md$Age), age_mean, titanic_md$Age)

age_mode <- as.numeric(names(sort(table(titanic_md$Age), decreasing=TRUE)[1]))
titanic_md$Age_Moda <- ifelse(is.na(titanic_md$Age), age_mode, titanic_md$Age)

age_median <- median(titanic_md$Age, na.rm = TRUE)
titanic_md$Age_Mediana <- ifelse(is.na(titanic_md$Age), age_median, titanic_md$Age)

fit <- lm(Age ~ Pclass + SibSp + Parch, data=titanic_md, na.action=na.exclude)
predicted_age <- predict(fit, newdata = titanic_md)
titanic_md$Age_Regresion <- ifelse(is.na(titanic_md$Age), predicted_age, titanic_md$Age)

age_sd <- sd(titanic_md$Age, na.rm = TRUE)
age_mean <- mean(titanic_md$Age, na.rm = TRUE)
outliers <- which(titanic_md$Age < age_mean - 3*age_sd | titanic_md$Age > age_mean + 3*age_sd)
titanic_md$Age_SD_Outliers <- titanic_md$Age
titanic_md$Age_SD_Outliers[outliers] <- NA


#SibSp

sibsp_mean <- mean(titanic_md$SibSp, na.rm = TRUE)
titanic_md$SibSp_Media <- ifelse(is.na(titanic_md$SibSp), sibsp_mean, titanic_md$SibSp)

sibsp_mode <- as.numeric(names(sort(table(titanic_md$SibSp), decreasing=TRUE)[1]))
titanic_md$SibSp_Moda <- ifelse(is.na(titanic_md$SibSp), sibsp_mode, titanic_md$SibSp)

sibsp_median <- median(titanic_md$SibSp, na.rm = TRUE)
titanic_md$SibSp_Mediana <- ifelse(is.na(titanic_md$SibSp), sibsp_median, titanic_md$SibSp)

fit_sibsp <- lm(SibSp ~ Pclass + Age + Parch, data=titanic_md, na.action=na.exclude)
predicted_sibsp <- predict(fit_sibsp, newdata = titanic_md)
titanic_md$SibSp_Regresion <- ifelse(is.na(titanic_md$SibSp), predicted_sibsp, titanic_md$SibSp)

sibsp_sd <- sd(titanic_md$SibSp, na.rm = TRUE)
sibsp_mean <- mean(titanic_md$SibSp, na.rm = TRUE)
outliers_sibsp <- which(titanic_md$SibSp < sibsp_mean - 3*sibsp_sd | titanic_md$SibSp > sibsp_mean + 3*sibsp_sd)
titanic_md$SibSp_SD_Outliers <- titanic_md$SibSp
titanic_md$SibSp_SD_Outliers[outliers_sibsp] <- NA

# Para SibSp
sibsp_mean <- mean(titanic_md$SibSp, na.rm = TRUE)
titanic_md$SibSp_Media <- ifelse(is.na(titanic_md$SibSp), sibsp_mean, titanic_md$SibSp)

sibsp_mode <- as.numeric(names(sort(table(titanic_md$SibSp), decreasing=TRUE)[1]))
titanic_md$SibSp_Moda <- ifelse(is.na(titanic_md$SibSp), sibsp_mode, titanic_md$SibSp)

sibsp_median <- median(titanic_md$SibSp, na.rm = TRUE)
titanic_md$SibSp_Mediana <- ifelse(is.na(titanic_md$SibSp), sibsp_median, titanic_md$SibSp)

fit_sibsp <- lm(SibSp ~ Pclass + Age + Parch, data=titanic_md, na.action=na.exclude)
predicted_sibsp <- predict(fit_sibsp, newdata = titanic_md)
titanic_md$SibSp_Regresion <- ifelse(is.na(titanic_md$SibSp), predicted_sibsp, titanic_md$SibSp)

sibsp_sd <- sd(titanic_md$SibSp, na.rm = TRUE)
sibsp_mean <- mean(titanic_md$SibSp, na.rm = TRUE)
outliers_sibsp <- which(titanic_md$SibSp < sibsp_mean - 3*sibsp_sd | titanic_md$SibSp > sibsp_mean + 3*sibsp_sd)
titanic_md$SibSp_SD_Outliers <- titanic_md$SibSp
titanic_md$SibSp_SD_Outliers[outliers_sibsp] <- NA

# Parch
parch_mean <- mean(titanic_md$Parch, na.rm = TRUE)
titanic_md$Parch_Media <- ifelse(is.na(titanic_md$Parch), parch_mean, titanic_md$Parch)

parch_mode <- as.numeric(names(sort(table(titanic_md$Parch), decreasing=TRUE)[1]))
titanic_md$Parch_Moda <- ifelse(is.na(titanic_md$Parch), parch_mode, titanic_md$Parch)

parch_median <- median(titanic_md$Parch, na.rm = TRUE)
titanic_md$Parch_Mediana <- ifelse(is.na(titanic_md$Parch), parch_median, titanic_md$Parch)

fit_parch <- lm(Parch ~ Pclass + Age + SibSp, data=titanic_md, na.action=na.exclude)
predicted_parch <- predict(fit_parch, newdata = titanic_md)
titanic_md$Parch_Regresion <- ifelse(is.na(titanic_md$Parch), predicted_parch, titanic_md$Parch)

parch_sd <- sd(titanic_md$Parch, na.rm = TRUE)
parch_mean <- mean(titanic_md$Parch, na.rm = TRUE)
outliers_parch <- which(titanic_md$Parch < parch_mean - 3*parch_sd | titanic_md$Parch > parch_mean + 3*parch_sd)
titanic_md$Parch_SD_Outliers <- titanic_md$Parch
titanic_md$Parch_SD_Outliers[outliers_parch] <- NA

# Fare
fare_mean <- mean(titanic_md$Fare, na.rm = TRUE)
titanic_md$Fare_Media <- ifelse(is.na(titanic_md$Fare), fare_mean, titanic_md$Fare)

fare_mode <- as.numeric(names(sort(table(titanic_md$Fare), decreasing=TRUE)[1]))
titanic_md$Fare_Moda <- ifelse(is.na(titanic_md$Fare), fare_mode, titanic_md$Fare)

fare_median <- median(titanic_md$Fare, na.rm = TRUE)
titanic_md$Fare_Mediana <- ifelse(is.na(titanic_md$Fare), fare_median, titanic_md$Fare)

fit_fare <- lm(Fare ~ Pclass + Age + SibSp, data=titanic_md, na.action=na.exclude)
predicted_fare <- predict(fit_fare, newdata = titanic_md)
titanic_md$Fare_Regresion <- ifelse(is.na(titanic_md$Fare), predicted_fare, titanic_md$Fare)

fare_sd <- sd(titanic_md$Fare, na.rm = TRUE)
fare_mean <- mean(titanic_md$Fare, na.rm = TRUE)
outliers_fare <- which(titanic_md$Fare < fare_mean - 3*fare_sd | titanic_md$Fare > fare_mean + 3*fare_sd)
titanic_md$Fare_SD_Outliers <- titanic_md$Fare
titanic_md$Fare_SD_Outliers[outliers_fare] <- NA
```

# 5. Al comparar los métodos del inciso 4 contra “titanic.csv”, ¿Qué método (para cada columna) se acerca más a la realidad y por qué? (20%)

``` r
calc_mse <- function(true_values, imputed_values) {
  return(mean((true_values - imputed_values)^2, na.rm = TRUE))
}

titanic_original <- read.csv("titanic.csv")

mse_results <- data.frame(
  Method = character(),
  Column = character(),
  MSE = numeric()
)

columns_to_evaluate <- c("Age", "SibSp", "Parch", "Fare")

methods_to_evaluate <- c("Media", "Moda", "Mediana", "Regresion", "SD_Outliers")

for (col in columns_to_evaluate) {
  for (method in methods_to_evaluate) {
    mse_value <- calc_mse(titanic_original[[col]], titanic_md[[paste(col, method, sep = "_")]])
    mse_results <- rbind(mse_results, data.frame(Method = method, Column = col, MSE = mse_value))
  }
}

mse_results <- mse_results[order(mse_results$Column, mse_results$MSE),]

print(mse_results)
```

    ##         Method Column         MSE
    ## 1        Media    Age 23.73986935
    ## 2         Moda    Age 23.73986935
    ## 3      Mediana    Age 23.73986935
    ## 4    Regresion    Age 23.73986935
    ## 5  SD_Outliers    Age 23.73986935
    ## 16       Media   Fare 96.72515434
    ## 17        Moda   Fare 96.72515434
    ## 18     Mediana   Fare 96.72515434
    ## 19   Regresion   Fare 96.72515434
    ## 20 SD_Outliers   Fare 97.79394058
    ## 11       Media  Parch  0.06557377
    ## 12        Moda  Parch  0.06557377
    ## 13     Mediana  Parch  0.06557377
    ## 14   Regresion  Parch  0.06557377
    ## 15 SD_Outliers  Parch  0.06593407
    ## 6        Media  SibSp  0.01092896
    ## 7         Moda  SibSp  0.01092896
    ## 8      Mediana  SibSp  0.01092896
    ## 9    Regresion  SibSp  0.01092896
    ## 10 SD_Outliers  SibSp  0.01111111

``` r
print("Mejor método para cada columna:")
```

    ## [1] "Mejor método para cada columna:"

``` r
for (col in columns_to_evaluate) {
  best_method <- mse_results[mse_results$Column == col,][1,]
  print(paste("El mejor metodo para la columna", col, "es", best_method$Method, "con un MSE de", best_method$MSE))
}
```

    ## [1] "El mejor metodo para la columna Age es Media con un MSE de 23.7398693504678"
    ## [1] "El mejor metodo para la columna SibSp es Media con un MSE de 0.0109289617486339"
    ## [1] "El mejor metodo para la columna Parch es Media con un MSE de 0.0655737704918033"
    ## [1] "El mejor metodo para la columna Fare es Media con un MSE de 96.7251543437453"

# Conclusiones

Edad (Age): La imputación de la media resulta ser la mejor técnica con
un MSE de aproximadamente 22.78. Esto sugiere que la media es una
estimación relativamente buena para los valores faltantes en esta
columna, aunque el MSE es relativamente alto en comparación con otras
columnas. Número de hermanos/cónyuges a bordo (SibSp): La imputación de
la media también es la mejor técnica, con un MSE extremadamente bajo de
aproximadamente 0.011. Esto sugiere que la media es una excelente
estimación para los valores faltantes en esta columna. Número de
padres/hijos a bordo (Parch): De nuevo, la imputación de la media es la
mejor técnica con un MSE de aproximadamente 0.066. Similar a SibSp, la
media parece ser una excelente estimación para los valores faltantes en
esta columna. Tarifa (Fare): La imputación de la media es la mejor
técnica con un MSE de aproximadamente 96.73. Este MSE es bastante alto,
lo que indica que aunque la media es la “mejor” opción entre los métodos
evaluados, aún hay un grado significativo de error. Esto podría deberse
a la variabilidad de las tarifas, lo que hace que la media no sea una
estimación particularmente buena.

La imputación de la media resultó ser el mejor método en todos los
casos, lo que podría sugerir que los datos faltantes son aleatorios y no
están sesgados de manera significativa.

# Parte 2

### Normalizacion

``` r
titanic_imputed <- titanic_original
titanic_imputed$Age <- titanic_md$Age_Media
titanic_imputed$SibSp <- titanic_md$SibSp_Media
titanic_imputed$Parch <- titanic_md$Parch_Media
titanic_imputed$Fare <- titanic_md$Fare_Media
```

``` r
df_md <-  titanic_imputed
df_original <- titanic_original

df_md_imputed <- df_md
numeric_cols <- sapply(df_md, is.numeric)
df_md_imputed[, numeric_cols] <- lapply(df_md[, numeric_cols], function(x) ifelse(is.na(x), mean(x, na.rm = TRUE), x))


df_md_standardized <- as.data.frame(scale(df_md_imputed[, numeric_cols]))


df_md_minmax <- as.data.frame(apply(df_md_imputed[, numeric_cols], 2, function(x) (x - min(x)) / (max(x) - min(x))))


df_md_maxabs <- as.data.frame(apply(df_md_imputed[, numeric_cols], 2, function(x) x / max(abs(x))))


df_original_numeric <- df_original[, numeric_cols]
df_original_standardized <- as.data.frame(scale(df_original_numeric))


print("Estadísticas de la data imputada y normalizada (Standarization):")
```

    ## [1] "Estadísticas de la data imputada y normalizada (Standarization):"

``` r
summary(df_md_standardized)
```

    ##   PassengerId           Survived           Pclass             Age          
    ##  Min.   :-1.835101   Min.   :-1.4279   Min.   :-0.3712   Min.   :-2.24793  
    ##  1st Qu.:-0.776621   1st Qu.:-1.4279   1st Qu.:-0.3712   1st Qu.:-0.73311  
    ##  Median : 0.006613   Median : 0.6965   Median :-0.3712   Median : 0.05449  
    ##  Mean   : 0.000000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.00000  
    ##  3rd Qu.: 0.893065   3rd Qu.: 0.6965   3rd Qu.:-0.3712   3rd Qu.: 0.77645  
    ##  Max.   : 1.759278   Max.   : 0.6965   Max.   : 3.5108   Max.   : 2.94235  
    ##      SibSp             Parch              Fare        
    ##  Min.   :-0.7049   Min.   :-0.5856   Min.   :-1.0389  
    ##  1st Qu.:-0.7049   1st Qu.:-0.5856   1st Qu.:-0.6462  
    ##  Median :-0.7049   Median :-0.5856   Median :-0.2723  
    ##  Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 0.8492   3rd Qu.: 0.7710   3rd Qu.: 0.1511  
    ##  Max.   : 3.9574   Max.   : 4.8407   Max.   : 5.7352

``` r
print("Estadísticas de la data imputada y normalizada (MinMaxScaling):")
```

    ## [1] "Estadísticas de la data imputada y normalizada (MinMaxScaling):"

``` r
summary(df_md_minmax)
```

    ##   PassengerId        Survived          Pclass             Age        
    ##  Min.   :0.0000   Min.   :0.0000   Min.   :0.00000   Min.   :0.0000  
    ##  1st Qu.:0.2945   1st Qu.:0.0000   1st Qu.:0.00000   1st Qu.:0.2919  
    ##  Median :0.5124   Median :1.0000   Median :0.00000   Median :0.4436  
    ##  Mean   :0.5105   Mean   :0.6721   Mean   :0.09563   Mean   :0.4331  
    ##  3rd Qu.:0.7590   3rd Qu.:1.0000   3rd Qu.:0.00000   3rd Qu.:0.5827  
    ##  Max.   :1.0000   Max.   :1.0000   Max.   :1.00000   Max.   :1.0000  
    ##      SibSp            Parch             Fare        
    ##  Min.   :0.0000   Min.   :0.0000   Min.   :0.00000  
    ##  1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.05797  
    ##  Median :0.0000   Median :0.0000   Median :0.11317  
    ##  Mean   :0.1512   Mean   :0.1079   Mean   :0.15337  
    ##  3rd Qu.:0.3333   3rd Qu.:0.2500   3rd Qu.:0.17567  
    ##  Max.   :1.0000   Max.   :1.0000   Max.   :1.00000

``` r
print("Estadísticas de la data imputada y normalizada (MaxAbsScaler):")
```

    ## [1] "Estadísticas de la data imputada y normalizada (MaxAbsScaler):"

``` r
summary(df_md_maxabs)
```

    ##   PassengerId          Survived          Pclass            Age        
    ##  Min.   :0.002247   Min.   :0.0000   Min.   :0.3333   Min.   :0.0115  
    ##  1st Qu.:0.296067   1st Qu.:0.0000   1st Qu.:0.3333   1st Qu.:0.3000  
    ##  Median :0.513483   Median :1.0000   Median :0.3333   Median :0.4500  
    ##  Mean   :0.511647   Mean   :0.6721   Mean   :0.3971   Mean   :0.4396  
    ##  3rd Qu.:0.759551   3rd Qu.:1.0000   3rd Qu.:0.3333   3rd Qu.:0.5875  
    ##  Max.   :1.000000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
    ##      SibSp            Parch             Fare        
    ##  Min.   :0.0000   Min.   :0.0000   Min.   :0.00000  
    ##  1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.05797  
    ##  Median :0.0000   Median :0.0000   Median :0.11317  
    ##  Mean   :0.1512   Mean   :0.1079   Mean   :0.15337  
    ##  3rd Qu.:0.3333   3rd Qu.:0.2500   3rd Qu.:0.17567  
    ##  Max.   :1.0000   Max.   :1.0000   Max.   :1.00000

``` r
print("Estadísticas de la data original (Standarization):")
```

    ## [1] "Estadísticas de la data original (Standarization):"

``` r
summary(df_original_standardized)
```

    ##   PassengerId           Survived           Pclass             Age          
    ##  Min.   :-1.835101   Min.   :-1.4279   Min.   :-0.3712   Min.   :-2.22160  
    ##  1st Qu.:-0.776621   1st Qu.:-1.4279   1st Qu.:-0.3712   1st Qu.:-0.74626  
    ##  Median : 0.006613   Median : 0.6965   Median :-0.3712   Median : 0.02081  
    ##  Mean   : 0.000000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.00000  
    ##  3rd Qu.: 0.893065   3rd Qu.: 0.6965   3rd Qu.:-0.3712   3rd Qu.: 0.75592  
    ##  Max.   : 1.759278   Max.   : 0.6965   Max.   : 3.5108   Max.   : 2.83342  
    ##      SibSp             Parch              Fare        
    ##  Min.   :-0.7211   Min.   :-0.6300   Min.   :-1.0306  
    ##  1st Qu.:-0.7211   1st Qu.:-0.6300   1st Qu.:-0.6416  
    ##  Median :-0.7211   Median :-0.6300   Median :-0.2840  
    ##  Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 0.8313   3rd Qu.: 0.6952   3rd Qu.: 0.1482  
    ##  Max.   : 3.9362   Max.   : 4.6707   Max.   : 5.6799
