
<!-- README.md is generated from README.Rmd. Please edit that file -->

# claimsdb

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/claimsdb)](https://CRAN.R-project.org/package=claimsdb)

<!-- badges: end -->

**claimsdb** provides easy access to a sample of health insurance
enrollment and claims data from the [CMS Data Entrepreneurs’ Synthetic
Public Use File
(DE-SynPUF)](https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DE_Syn_PUF),
as a set of relational tables or as an in-memory database using
[DuckDB](https://duckdb.org). This package is inspired by and based on
the [starwarsdb](https://github.com/gadenbuie/starwarsdb) package.

The data are structured as actual Medicare claims data but are fully
“synthetic,” after a process of alterations meant to reduce the risk of
re-identification of real Medicare beneficiaries. The synthetic process
that CMS adopted changes the co-variation across variables, so analysts
should be cautious about drawing inferences about the actual Medicare
population.

The data included in **claimsdb** comes from 500 randomly selected 2008
Medicare beneficiaries from Sample 2 of the DE-SynPUF, and it includes
all the associated claims for these members for 2008-2009. CMS provides
[resources](https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DESample02),
including a codebook, FAQs, and other documents with more information
about this data.

[![Source: CMS Linkable 2008–2010 Medicare
DE-SynPUF](man/figures/README-diagram.PNG "Source: CMS Linkable 2008–2010 Medicare DE-SynPUF")](https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/SynPUF_DUG.pdf)

**Formats:** [Metadata](#health-insurance-claims-data), [Local
Tables](#local-tables), [Remote Database
Tables](#remote-database-tables)

## Installation

You can install the development version of **claimsdb** from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jfangmeier/claimsdb")
```

## Health Insurance Claims Data

All of the tables are available when you load **claimsdb**

``` r
library(dplyr)
library(claimsdb)
```

The tables are also available by loading just the data from **claimsdb**

``` r
data(package = "claimsdb")
```

This includes a `schema` table that describes each of the tables and the
included variables from the [CMS
DE-SynPUF](https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DE_Syn_PUF).

``` r
schema
#> # A tibble: 5 x 5
#>   TABLE      TABLE_TITLE              TABLE_DESCRIPTI~ UNIT_OF_RECORD PROPERTIES
#>   <chr>      <chr>                    <chr>            <chr>          <list>    
#> 1 bene       CMS Beneficiary Summary~ Synthetic Medic~ Beneficiary    <tibble>  
#> 2 carrier    CMS Carrier Claims DE-S~ Synthetic physi~ claim          <tibble>  
#> 3 inpatient  CMS Inpatient Claims DE~ Synthetic inpat~ claim          <tibble>  
#> 4 outpatient CMS Outpatient Claims D~ Synthetic outpa~ claim          <tibble>  
#> 5 pde        CMS Prescription Drug E~ Synthetic Part ~ claim          <tibble>
```

``` r
schema %>% 
  filter(TABLE == "inpatient") %>% 
  pull(PROPERTIES)
#> [[1]]
#> # A tibble: 35 x 3
#>    VARIABLE                 TYPE    DESCRIPTION                                 
#>    <chr>                    <chr>   <chr>                                       
#>  1 DESYNPUF_ID              string  Beneficiary Code                            
#>  2 CLM_ID                   string  Claim ID                                    
#>  3 SEGMENT                  numeric Claim Line Segment                          
#>  4 CLM_FROM_DT              date    Claims start date                           
#>  5 CLM_THRU_DT              date    Claims end date                             
#>  6 PRVDR_NUM                string  Provider Institution                        
#>  7 CLM_PMT_AMT              numeric Claim Payment Amount                        
#>  8 NCH_PRMRY_PYR_CLM_PD_AMT numeric NCH Primary Payer Claim Paid Amount         
#>  9 AT_PHYSN_NPI             string  Attending Physician National Provider Ident~
#> 10 OP_PHYSN_NPI             string  Operating Physician National Provider Ident~
#> # ... with 25 more rows
```

## Local Tables

Using the sample data in the tables, you can ask questions such as,
*what were the average and median prescription drug costs for males and
females in 2008 and 2009?*

``` r
rx_costs <- pde %>% 
  mutate(BENE_YEAR = lubridate::year(SRVC_DT)) %>%  
  group_by(BENE_YEAR, DESYNPUF_ID) %>% 
  summarize(TOTAL_RX_COST = sum(TOT_RX_CST_AMT, na.rm = T), .groups = "drop")

bene %>% 
  transmute(
    BENE_YEAR,
    DESYNPUF_ID,
    BENE_SEX_IDENT = case_when(
      BENE_SEX_IDENT_CD == "1" ~ "Male",
      TRUE ~ "Female")
  ) %>% 
  left_join(
    rx_costs, by = c("BENE_YEAR", "DESYNPUF_ID")
  ) %>% 
  mutate(TOTAL_RX_COST = ifelse(is.na(TOTAL_RX_COST), 0, TOTAL_RX_COST)) %>% 
  group_by(BENE_YEAR, BENE_SEX_IDENT) %>% 
  summarize(
    MEAN_RX_COST = mean(TOTAL_RX_COST, na.rm = T),
    MEDIAN_RX_COST = median(TOTAL_RX_COST, na.rm = T))
#> `summarise()` has grouped output by 'BENE_YEAR'. You can override using the
#> `.groups` argument.
#> # A tibble: 4 x 4
#> # Groups:   BENE_YEAR [2]
#>   BENE_YEAR BENE_SEX_IDENT MEAN_RX_COST MEDIAN_RX_COST
#>       <dbl> <chr>                 <dbl>          <dbl>
#> 1      2008 Female                1147.            270
#> 2      2008 Male                   878.             90
#> 3      2009 Female                1264.            405
#> 4      2009 Male                   956.            230
```

## Remote Database Tables

Many organizations store claims data in a remote database, so
**claimsdb** also includes all of the tables as an in-memory DuckDB
database. This can be a great way to practice working with this type of
data, including building queries with dplyr code using
[dbplyr](https://dbplyr.tidyverse.org/).

``` r
con <- claims_connect()
bene_rmt <- tbl(con, "bene")
pde_rmt <- tbl(con, "pde")
pde_rmt
#> # Source:   table<pde> [?? x 8]
#> # Database: duckdb_connection
#>    DESYNPUF_ID      PDE_ID SRVC_DT    PROD_SRVC_ID QTY_DSPNSD_NUM DAYS_SUPLY_NUM
#>    <chr>            <chr>  <date>     <chr>                 <dbl>          <dbl>
#>  1 00E040C6ECE8F878 83014~ 2008-12-20 49288010404              30             30
#>  2 00E040C6ECE8F878 83594~ 2009-04-25 52959037200              20             30
#>  3 00E040C6ECE8F878 83144~ 2009-09-22 00083400141              80             30
#>  4 00E040C6ECE8F878 83614~ 2009-10-03 63481043301              60             10
#>  5 00E040C6ECE8F878 83014~ 2009-11-16 51129404301              60             30
#>  6 00E040C6ECE8F878 83234~ 2009-12-11 58016096489             270             30
#>  7 014F2C07689C173B 83294~ 2009-09-14 00904582062              90             30
#>  8 014F2C07689C173B 83874~ 2009-10-11 59604053055              40             20
#>  9 014F2C07689C173B 83314~ 2009-11-24 51079017760              30             30
#> 10 014F2C07689C173B 83874~ 2009-12-29 51129370802              30             30
#> # ... with more rows, and 2 more variables: PTNT_PAY_AMT <dbl>,
#> #   TOT_RX_CST_AMT <dbl>

rx_costs_rmt <- pde_rmt %>% 
  # note below that lubridate functions do not currently work on remote databases,
  # so you need to use date/time functions appropriate for the database.
  mutate(BENE_YEAR = date_part('year', SRVC_DT)) %>%  
  group_by(BENE_YEAR, DESYNPUF_ID) %>% 
  summarize(TOTAL_RX_COST = sum(TOT_RX_CST_AMT, na.rm = T), .groups = "drop") %>% 
  ungroup()
rx_costs_rmt
#> # Source:   lazy query [?? x 3]
#> # Database: duckdb_connection
#>    BENE_YEAR DESYNPUF_ID      TOTAL_RX_COST
#>        <dbl> <chr>                    <dbl>
#>  1      2008 00E040C6ECE8F878            10
#>  2      2009 00E040C6ECE8F878           120
#>  3      2009 014F2C07689C173B           790
#>  4      2009 029A22E4A3AAEE15           440
#>  5      2008 03ADA78C0FEF79F4          5020
#>  6      2009 03ADA78C0FEF79F4          5350
#>  7      2008 040A12AB5EAA444C           120
#>  8      2009 040A12AB5EAA444C            40
#>  9      2008 043AAAE41C9A37B7           810
#> 10      2009 043AAAE41C9A37B7            60
#> # ... with more rows

bene_rmt %>% 
  transmute(
    BENE_YEAR,
    DESYNPUF_ID,
    BENE_SEX_IDENT = case_when(
      BENE_SEX_IDENT_CD == "1" ~ "Male",
      TRUE ~ "Female")
  ) %>% 
  left_join(
    rx_costs_rmt, by = c("BENE_YEAR", "DESYNPUF_ID")
  ) %>% 
  mutate(TOTAL_RX_COST = ifelse(is.na(TOTAL_RX_COST), 0, TOTAL_RX_COST)) %>% 
  group_by(BENE_YEAR, BENE_SEX_IDENT) %>% 
  summarize(
    MEAN_RX_COST = mean(TOTAL_RX_COST, na.rm = T),
    MEDIAN_RX_COST = median(TOTAL_RX_COST, na.rm = T))
#> `summarise()` has grouped output by 'BENE_YEAR'. You can override using the
#> `.groups` argument.
#> # Source:   lazy query [?? x 4]
#> # Database: duckdb_connection
#> # Groups:   BENE_YEAR
#>   BENE_YEAR BENE_SEX_IDENT MEAN_RX_COST MEDIAN_RX_COST
#>       <dbl> <chr>                 <dbl>          <dbl>
#> 1      2008 Female                1147.            270
#> 2      2009 Female                1264.            405
#> 3      2008 Male                   878.             90
#> 4      2009 Male                   956.            230
```
