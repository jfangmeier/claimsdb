library(tidyverse)
library(archive)
library(httr2)

parse_sas <- function(sas_url){
  sas_url %>% 
    request() %>% 
    req_retry(max_tries = 5) %>% 
    req_perform(path = file.path(tempdir(), "sas.zip"))
  
  txt <- archive_read(
    file.path(tempdir(), "sas.zip"), 1
  ) %>% 
    read_file()
  
  var_df <- 
    txt %>% 
    str_split(., "attrib ", simplify = TRUE) %>%
    pluck(., 2) %>%
    str_split(., "\\;", simplify = TRUE) %>%
    pluck(., 1) %>%
    enframe() %>% 
    separate_rows(value, sep = "\r\n") %>% 
    mutate(
      value = str_remove(value, "informat=yymmdd8."),
      value = str_remove(value, "%addseqattrib\\(varname="),
      value = str_remove(value, "\\,nvars="),
      value = str_replace_all(value, "\\,", " ")) %>% 
    filter(str_detect(value, "[:alpha:]")) %>% 
    transmute(value = str_squish(value)) %>% 
    separate(col = value, into = c("VAR", "LEN", "FMT", "LBL"), remove = T, sep = " ", extra = "merge")
  
  return(var_df)
}

sas_urls <- 
  c(
    "https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/Bene_SAS.zip",
    "https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/Carrier_SAS.zip",
    "https://www.cms.gov/files/zip/de-10-inpatient-claims-sas-code.zip",
    "https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/Outpatient_SAS.zip",
    "https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/PDE_SAS.zip"
  )

names(sas_urls) <- 
  c(
    "Bene",
    "Carrier",
    "Inpatient",
    "Outpatient",
    "PDE"
  )

codebook_raw <- 
  sas_urls %>% 
  map_dfr(
    .,
    ~parse_sas(.x),
    .id = "TABLE"
  ) %>% 
  mutate(ORDER = row_number())

codebook_df <- 
  codebook_raw %>% 
  filter(str_detect(VAR, "[:digit:]$", negate = F)) %>% 
  transmute(
    ORDER,
    TABLE,
    VAR,
    TYPE = case_when(
      str_detect(FMT, "\\$") ~ "string",
      str_detect(FMT, "yymmdd") ~ "date",
      TRUE ~ "numeric"),
    DESCR = str_extract(LBL, "(?<=\\:)[:print:]{1,}")
  ) %>% 
  mutate(
    DESCR = str_remove_all(DESCR, "[:punct:]"),
    DESCR = str_squish(DESCR)
  ) %>% 
  mutate(
    COUNT = as.numeric(str_extract(VAR, "[:digit:]{1,2}$")),
    VAR = str_remove(VAR, "[:digit:]{1,2}$")) %>% 
  uncount(COUNT) %>% 
  group_by(TABLE, VAR) %>% 
  mutate(
    ROW = row_number(),
    DESCR = paste0(DESCR, " (", ROW, ")")) %>%
  ungroup() %>% 
  mutate(VAR = paste0(VAR, ROW)) %>%
  bind_rows(
    codebook_raw %>% 
      filter(str_detect(VAR, "[:digit:]$", negate = T)) %>% 
      transmute(
        ORDER,
        TABLE,
        VAR,
        TYPE = case_when(
          str_detect(FMT, "\\$") ~ "string",
          str_detect(FMT, "yymmdd|YYMMDD") ~ "date",
          TRUE ~ "numeric"),
        DESCR = str_extract(LBL, "(?<=\\:)[:print:]{1,}")
      ) %>% 
      mutate(
        DESCR = str_remove_all(DESCR, "[:punct:]"),
        DESCR = str_squish(DESCR)
      )
  ) %>% 
  arrange(ORDER, ROW) %>% 
  select(
    TABLE, 
    VAR_NAME = VAR, 
    VAR_DESCR = DESCR, 
    VAR_TYPE = TYPE)

write_rds(codebook_df, here::here("data-raw", "codebook.rds"))