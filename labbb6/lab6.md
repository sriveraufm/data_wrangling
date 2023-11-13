lab6
================
2023-11-13

1.  

``` r
placas <- c("ABC1234", "XYZ9999", "AAA1111", "123ABCD", "AB12CD3", "abcd1234")
coincidencias <- str_detect(placas, pattern = "^[A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9]$")

resultados <- data.frame(Placa = placas, EsPlacaValida = coincidencias)

print(resultados)
```

    ##      Placa EsPlacaValida
    ## 1  ABC1234          TRUE
    ## 2  XYZ9999          TRUE
    ## 3  AAA1111          TRUE
    ## 4  123ABCD         FALSE
    ## 5  AB12CD3         FALSE
    ## 6 abcd1234         FALSE

2.  

``` r
archivos <- c("Ejemplo1.pdf", "prueba2.PDF", "respuestas_del_examen.jpg", "amor.JPG")
coincidencias <- str_detect(archivos, pattern = ".*\\.(pdf|jpg|PDF|JPG)$")
resultados <- data.frame(Archivo = archivos, Coincide = coincidencias)

print(resultados)
```

    ##                     Archivo Coincide
    ## 1              Ejemplo1.pdf     TRUE
    ## 2               prueba2.PDF     TRUE
    ## 3 respuestas_del_examen.jpg     TRUE
    ## 4                  amor.JPG     TRUE

3.  

``` r
contraseñas <- c("Password1!", "abcdEFGH", "1234!", "Abc!defgh", "ABC!defgh")

coincidencias <- str_detect(contraseñas, pattern = "^(?=.*[A-Z])(?=.*[!@#$%^&*()_+])[A-Za-z0-9!@#$%^&*()_+]{8,}$")

resultados <- data.frame(Contraseña = contraseñas, EsValida = coincidencias)

print(resultados)
```

    ##   Contraseña EsValida
    ## 1 Password1!     TRUE
    ## 2   abcdEFGH    FALSE
    ## 3      1234!    FALSE
    ## 4  Abc!defgh     TRUE
    ## 5  ABC!defgh     TRUE

5.  

``` r
texto1 <- c("pit", "spot", "spate", "slaptwo", "respite")
texto2 <- c("pt", "Pot", "pea‎t", "part")


coincidencias1 <- str_detect(texto1, pattern = "\\b[a-z]*[aeiou](?![aeiou])(?![a-z]*r)[a-z]+\\b")
coincidencias2 <- str_detect(texto2, pattern = "\\b[a-z]*[aeiou](?![aeiou])(?![a-z]*r)[a-z]+\\b")

count_true_texto1 <- sum(coincidencias1)
count_true_texto2 <- sum(coincidencias2)


print(paste("Count in Texto 1:", count_true_texto1, "- Count in Texto 2:", count_true_texto2))
```

    ## [1] "Count in Texto 1: 5 - Count in Texto 2: 0"

6.  

``` r
numeros_telefonicos <- c("+50254821151", "4210-7640", "52018150", "24346854", "11234569", "50211234578")

regex_numeros_gt <- "(\\+?502)?[2|4-6]([0-9]{3}[- ]?[0-9]{4}|[0-9]{7})"
#Asumiendo que puede o no tener el 502
coincidencias <- str_detect(numeros_telefonicos, pattern = regex_numeros_gt)

resultados <- data.frame(Número = numeros_telefonicos, Coincide = coincidencias)

print(resultados)
```

    ##         Número Coincide
    ## 1 +50254821151     TRUE
    ## 2    4210-7640     TRUE
    ## 3     52018150     TRUE
    ## 4     24346854     TRUE
    ## 5     11234569    FALSE
    ## 6  50211234578     TRUE

7.  

``` r
library(stringr)

correos <- c("jsrivera@gmail.com","jsrivera@ufm.edu","estudiante@ufm.edu", "profesor@ufm.edu", "info@ufm.edu", "usuario@gmail.com", "contacto@ufm.com")

regex_correos_ufm <- ".*@ufm\\.edu"

coincidencias <- str_detect(correos, pattern = regex_correos_ufm)

resultados <- data.frame(Correo = correos, Coincide = coincidencias)

print(resultados)
```

    ##               Correo Coincide
    ## 1 jsrivera@gmail.com    FALSE
    ## 2   jsrivera@ufm.edu     TRUE
    ## 3 estudiante@ufm.edu     TRUE
    ## 4   profesor@ufm.edu     TRUE
    ## 5       info@ufm.edu     TRUE
    ## 6  usuario@gmail.com    FALSE
    ## 7   contacto@ufm.com    FALSE
