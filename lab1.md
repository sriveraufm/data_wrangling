lab1
================
2023-08-02

### 1

``` r
paths = list.files()[grepl('.xlsx', list.files())]

read_excel_file <- function(file_path) {
  df <- read_xlsx(file_path)
  df$mes = substr(file_path, 1, 2)
  df$ano = substr(file_path, 4, 7)
  return(df)
}

data_frames <- lapply(paths, read_excel_file)
```

    ## New names:
    ## • `` -> `...10`

``` r
combined_data <- bind_rows(data_frames)
combined_data = combined_data[,-ncol(combined_data)]
dim(combined_data)
```

    ## [1] 2180   11

``` r
head(combined_data)
```

    ## # A tibble: 6 × 11
    ##   COD_VI…¹ CLIENTE UBICA…² CANTI…³ PILOTO     Q CREDITO UNIDAD mes   ano    TIPO
    ##      <dbl> <chr>     <dbl>   <dbl> <chr>  <dbl>   <dbl> <chr>  <chr> <chr> <dbl>
    ## 1 10000001 EL PIN…   76002    1200 Ferna… 300        30 Camio… 01    2018     NA
    ## 2 10000002 TAQUER…   76002    1433 Hecto… 358.       90 Camio… 01    2018     NA
    ## 3 10000003 TIENDA…   76002    1857 Pedro… 464.       60 Camio… 01    2018     NA
    ## 4 10000004 TAQUER…   76002     339 Angel…  84.8      30 Panel  01    2018     NA
    ## 5 10000005 CHICHA…   76001    1644 Juan … 411        30 Camio… 01    2018     NA
    ## 6 10000006 UBIQUO…   76001    1827 Luis … 457.       30 Camio… 01    2018     NA
    ## # … with abbreviated variable names ¹​COD_VIAJE, ²​UBICACION, ³​CANTIDAD

``` r
write.csv2(combined_data, 'combined_data.csv')
```

### 2

``` r
getmode <- function(v) {
   uniqv <- unique(v)
   uniqv[which.max(tabulate(match(v, uniqv)))]
}



modas = unlist(lapply(select(combined_data, c(UBICACION, PILOTO, UNIDAD)), getmode))

print(modas)
```

    ##                 UBICACION                    PILOTO                    UNIDAD 
    ##                   "76002" "Fernando Mariano Berrio"           "Camion Grande"

### 3

``` r
sat_data = read_delim('INE_PARQUE_VEHICULAR_080219.txt',delim = '|')
```

    ## New names:
    ## • `` -> `...11`

    ## Warning: One or more parsing issues, see `problems()` for details

    ## Rows: 2435294 Columns: 11
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: "|"
    ## chr (8): MES, NOMBRE_DEPARTAMENTO, NOMBRE_MUNICIPIO, MODELO_VEHICULO, LINEA_...
    ## dbl (2): ANIO_ALZA, CANTIDAD
    ## lgl (1): ...11
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
sat_data = sat_data[,-ncol(sat_data)]

head(sat_data)
```

    ## # A tibble: 6 × 10
    ##   ANIO_A…¹ MES   NOMBR…² NOMBR…³ MODEL…⁴ LINEA…⁵ TIPO_…⁶ USO_V…⁷ MARCA…⁸ CANTI…⁹
    ##      <dbl> <chr> <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>     <dbl>
    ## 1     2007 05    HUEHUE… "HUEHU… 2007    SPORT1… MOTO    MOTOCI… ASIA H…       1
    ## 2     2007 05    EL PRO… "EL JI… 2007    BT-50 … PICK UP PARTIC… MAZDA         1
    ## 3     2007 05    SAN MA… "OCOS"  2007    JL125   MOTO    MOTOCI… KINLON        1
    ## 4     2007 05    ESCUIN… "SAN J… 2006    JL125T… MOTO    MOTOCI… JIALING       1
    ## 5     2007 05    JUTIAPA "MOYUT… 2007    JH100-2 MOTO    MOTOCI… JIALING       1
    ## 6     2007 05    GUATEM… "FRAIJ… 1997    TACOMA… PICK UP PARTIC… TOYOTA        1
    ## # … with abbreviated variable names ¹​ANIO_ALZA, ²​NOMBRE_DEPARTAMENTO,
    ## #   ³​NOMBRE_MUNICIPIO, ⁴​MODELO_VEHICULO, ⁵​LINEA_VEHICULO, ⁶​TIPO_VEHICULO,
    ## #   ⁷​USO_VEHICULO, ⁸​MARCA_VEHICULO, ⁹​CANTIDAD
