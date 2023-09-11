dw-2023-parcial-1
================
Tepi
9/11/2023

# Examen parcial

Indicaciones generales:

-   Usted tiene el período de la clase para resolver el examen parcial.

-   La entrega del parcial, al igual que las tareas, es por medio de su
    cuenta de github, pegando el link en el portal de MiU.

-   Pueden hacer uso del material del curso e internet (stackoverflow,
    etc.). Sin embargo, si encontramos algún indicio de copia, se
    anulará el exámen para los estudiantes involucrados. Por lo tanto,
    aconsejamos no compartir las agregaciones que generen.

## Sección 0: Preguntas de temas vistos en clase (20pts)

-   Responda las siguientes preguntas de temas que fueron tocados en
    clase.

1.  ¿Qué es una ufunc y por qué debemos de utilizarlas cuando
    programamos trabajando datos? Son funciones que permiten realizar
    operaciones a cada elementod de un array, es bueno utilizaras porque
    son eficientes, rapidas y hacen el codigo mas legible.

2.  Es una técnica en programación numérica que amplía los objetos que
    son de menor dimensión para que sean compatibles con los de mayor
    dimensión. Describa cuál es la técnica y de un breve ejemplo en R.
    Broadcasting a \<- c(3, 5, 8) b \<- 3 c \<- a \* b

3.  ¿Qué es el axioma de elegibilidad y por qué es útil al momento de
    hacer análisis de datos? Cada cada observacion en un conjunto de
    datos debe tener la misma probabilidad de ser seleccionada. Es util
    para para evitar sesgos y tener resultados significativos.

4.  Cuál es la relación entre la granularidad y la agregación de datos?
    Mencione un breve ejemplo. Luego, exploque cuál es la granularidad o
    agregación requerida para poder generar un reporte como el
    siguiente:

| Pais | Usuarios |
|------|----------|
| US   | 1,934    |
| UK   | 2,133    |
| DE   | 1,234    |
| FR   | 4,332    |
| ROW  | 943      |

La granularidad es el nivel de detalle en los datos, mientras que la
agregacion es el proceso de resumir los datos

En este ejemplo se necesita una granularidad de data por usuario con
informacion demografica correspondiente para determinar su pais, para
agregar hay que sumar la cantidad de usuarios agrupado por pais.

## Sección I: Preguntas teóricas. (50pts)

-   Existen 10 preguntas directas en este Rmarkdown, de las cuales usted
    deberá responder 5. Las 5 a responder estarán determinadas por un
    muestreo aleatorio basado en su número de carné.

-   Ingrese su número de carné en `set.seed()` y corra el chunk de R
    para determinar cuáles preguntas debe responder.

``` r
set.seed(20210398)
v<- 1:10
preguntas <-sort(sample(v, size = 5, replace = FALSE ))

paste0("Mis preguntas a resolver son: ",paste0(preguntas,collapse = ", "))
```

    ## [1] "Mis preguntas a resolver son: 1, 2, 5, 8, 10"

### Listado de preguntas teóricas

1.  Para las siguientes sentencias de `base R`, liste su contraparte de
    `dplyr`:

    -   `str()`
    -   `df[,c("a","b")]`
    -   `names(df)[4] <- "new_name"` donde la posición 4 corresponde a
        la variable `old_name`
    -   `df[df$variable == "valor",]`

2.  Al momento de filtrar en SQL, ¿cuál keyword cumple las mismas
    funciones que el keyword `OR` para filtrar uno o más elementos una
    misma columna?

3.  ¿Por qué en R utilizamos funciones de la familia apply
    (lapply,vapply) en lugar de utilizar ciclos?

4.  ¿Cuál es la diferencia entre utilizar `==` y `=` en R?

5.  ¿Cuál es la forma correcta de cargar un archivo de texto donde el
    delimitador es `:`?

6.  ¿Qué es un vector y en qué se diferencia en una lista en R?

7.  ¿Qué pasa si quiero agregar una nueva categoría a un factor que no
    se encuentra en los niveles existentes?

8.  Si en un dataframe, a una variable de tipo `factor` le agrego un
    nuevo elemento que *no se encuentra en los niveles existentes*,
    ¿cuál sería el resultado esperado y por qué?

    -   El nuevo elemento
    -   `NA`

9.  En SQL, ¿para qué utilizamos el keyword `HAVING`?

10. Si quiero obtener como resultado las filas de la tabla A que no se
    encuentran en la tabla B, ¿cómo debería de completar la siguiente
    sentencia de SQL?

    -   SELECT \* FROM A \_\_\_\_\_\_\_ B ON A.KEY = B.KEY WHERE
        \_\_\_\_\_\_\_\_\_\_ = \_\_\_\_\_\_\_\_\_\_

Extra: ¿Cuántos posibles exámenes de 5 preguntas se pueden realizar
utilizando como banco las diez acá presentadas? (responder con código de
R.)

## Sección II Preguntas prácticas. (30pts)

-   Conteste las siguientes preguntas utilizando sus conocimientos de R.
    Adjunte el código que utilizó para llegar a sus conclusiones en un
    chunk del markdown.

A. De los clientes que están en más de un país,¿cuál cree que es el más
rentable y por qué?

B. Estrategia de negocio ha decidido que ya no operará en aquellos
territorios cuyas pérdidas sean “considerables”. Bajo su criterio,
¿cuáles son estos territorios y por qué ya no debemos operar ahí?

### I. Preguntas teóricas

1.  Para las siguientes sentencias de `base R`, liste su contraparte de
    `dplyr`:

    -   `str()` = `glimpse()`
    -   `df[,c("a","b")]`= `select(df, a, b)`
    -   `names(df)[4] <- "new_name"` donde la posición 4 corresponde a
        la variable `old_name` = `rename(df, new_name = old_name)`
    -   `df[df$variable == "valor",]` =
        `filter(df, variable == "valor")`

2.  Al momento de filtrar en SQL, ¿cuál keyword cumple las mismas
    funciones que el keyword `OR` para filtrar uno o más elementos una
    misma columna? IN

3.  ¿Cuál es la forma correcta de cargar un archivo de texto donde el
    delimitador es `:`? `read.table("archivo.txt", sep = ":")` o
    `read.delim("archivo.txt", sep = ":")`

4.  Si en un dataframe, a una variable de tipo `factor` le agrego un
    nuevo elemento que *no se encuentra en los niveles existentes*,
    ¿cuál sería el resultado esperado y por qué?

    -   El nuevo elemento
    -   `NA` Seria `NA` porque los factores ya estan establecidos y un
        factor que no existe, es un valor NA.

5.  Si quiero obtener como resultado las filas de la tabla A que no se
    encuentran en la tabla B, ¿cómo debería de completar la siguiente
    sentencia de SQL?

    -   SELECT \* FROM A \_\_\_\_\_\_\_ B ON A.KEY = B.KEY WHERE
        \_\_\_\_\_\_\_\_\_\_ = \_\_\_\_\_\_\_\_\_\_

        ``` sql
        SELECT * FROM A LEFT JOIN B ON A.KEY = B.KEY WHERE B.KEY IS NULL;
        ```

``` r
library(dplyr)
data = readRDS('parcial_anonimo.rds')
```

## A

``` r
###A. De los clientes que están en más de un país,¿cuál cree que es el más rentable y por qué?
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
clientes_pais <- data %>%
  group_by(Cliente, Pais) %>%
  summarise(Total_Venta = sum(Venta, na.rm = TRUE)) 
```

    ## `summarise()` has grouped output by 'Cliente'. You can override using the
    ## `.groups` argument.

``` r
clientes_multipais <- clientes_pais %>%
  group_by(Cliente) %>%
  filter(n() > 1) %>%
  summarise(Total_Venta = sum(Total_Venta, na.rm = TRUE)) %>%
  arrange(desc(Total_Venta))

cliente_mas_rentable <- clientes_multipais[1,]
print(paste0("El cliente mas rentable es: ", cliente_mas_rentable$Cliente, " Con un total de ventas de: ", as.character(cliente_mas_rentable$Total_Venta), "Es el mas rentable porque es el que mas ventas tiene."))
```

    ## [1] "El cliente mas rentable es: a17a7558 Con un total de ventas de: 19817.7Es el mas rentable porque es el que mas ventas tiene."

## B

``` r
###B. Estrategia de negocio ha decidido que ya no operará en aquellos territorios cuyas pérdidas sean "considerables". Bajo su criterio, ¿cuáles son estos territorios y por qué ya no debemos operar ahí?

resultados_por_territorio <- data %>%
  group_by(Territorio) %>%
  summarise(
    Ingreso_Total = sum(Venta[Venta > 0], na.rm = TRUE), 
    Perdida_Total = sum(Venta[Venta < 0], na.rm = TRUE), 
    Ganancia_Neta = Ingreso_Total + Perdida_Total 
  ) %>%
  arrange(Ganancia_Neta)

media_perdida <- mean(resultados_por_territorio$Perdida_Total, na.rm = TRUE)
std_perdida <- sd(resultados_por_territorio$Perdida_Total, na.rm = TRUE)

num_desviaciones <- 1.5 
umbral_de_perdida <- media_perdida - num_desviaciones * std_perdida

territorios_no_rentables <- filter(resultados_por_territorio, Perdida_Total < umbral_de_perdida)

data.table::data.table(territorios_no_rentables)
```

    ##    Territorio Ingreso_Total Perdida_Total Ganancia_Neta
    ## 1:   69c1b705      155915.3      -3370.11      152545.2
    ## 2:   1d407777      207900.5      -3299.56      204601.0
    ## 3:   77192d63      252892.5      -5640.55      247252.0
    ## 4:   bc8e06ed      333121.5      -3268.58      329852.9
    ## 5:   72520ba2      360138.1      -3760.95      356377.2
    ## 6:   f7dfc635      931770.7     -14985.02      916785.7

``` r
paste0('Estos territorios son los que mas ventas de perdidas han tenido, con base en 1.5 desviaciones estandar afuera de la media, identificandolos como valores atipicos, sin embargo, ningun territorio muestra una ganancia neta negativa, por lo que todos los territorios generan ganancias')
```

    ## [1] "Estos territorios son los que mas ventas de perdidas han tenido, con base en 1.5 desviaciones estandar afuera de la media, identificandolos como valores atipicos, sin embargo, ningun territorio muestra una ganancia neta negativa, por lo que todos los territorios generan ganancias"

``` r
data.table::data.table(resultados_por_territorio)
```

    ##      Territorio Ingreso_Total Perdida_Total Ganancia_Neta
    ##   1:   e6fd9da9         18.16          0.00         18.16
    ##   2:   13b223c9         49.94          0.00         49.94
    ##   3:   368301e2        121.47          0.00        121.47
    ##   4:   79428560        132.00          0.00        132.00
    ##   5:   e034e3c8        247.16          0.00        247.16
    ##  ---                                                     
    ## 100:   77192d63     252892.55      -5640.55     247252.00
    ## 101:   bc8e06ed     333121.50      -3268.58     329852.92
    ## 102:   72520ba2     360138.14      -3760.95     356377.19
    ## 103:   a0d39798     443501.18      -1779.45     441721.73
    ## 104:   f7dfc635     931770.73     -14985.02     916785.71
