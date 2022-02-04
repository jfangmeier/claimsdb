library(tidyverse)
library(httr2)

codebook <-
  read_rds(here::here("data-raw", "codebook.rds")) %>%
  mutate(
    COL_TYPE = case_when(
      VAR_TYPE == "string" ~ "c",
      VAR_TYPE == "date" ~ "D",
      TRUE ~ "d"
      ))

# Download and read beneficiary files for 2008-2009 from sample 2
bene_years <- 2008:2009
names(bene_years) <- 2008:2009

walk(
  .x = bene_years,
  ~paste0("https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/DE1_0_", .x, "_Beneficiary_Summary_File_Sample_2.zip") %>%
    request() %>%
    req_retry(max_tries = 5) %>%
    req_perform(path = here::here("data-raw", paste0("bene_", .x, ".zip")))
  )

bene_cols <-
  codebook %>%
  filter(TABLE == "Bene") %>%
  pull(COL_TYPE) %>%
  paste(., collapse = "")

bene <-
  map_dfr(
    .x = bene_years,
    ~read_csv(
      here::here("data-raw", paste0("bene_", .x, ".zip")),
      col_types = bene_cols,
      locale = locale(date_format = "%Y%m%d")),
    .id = "BENE_YEAR"
  )

# Select 500 random members from 2008 and keep their 2008-2009 beneficiary data
set.seed(123)
bene_rand <-
  bene %>%
  filter(BENE_YEAR == 2008) %>%
  sample_n(500) %>%
  select(DESYNPUF_ID)

bene_sample <-
  bene %>%
  inner_join(
    bene_rand,
    by = "DESYNPUF_ID"
  )

# For the sampled members, download and read their carrier, inpatient, outpatient, and pde data for 2008-2009
walk(
  .x = c("A", "B"),
  ~paste0("http://downloads.cms.gov/files/DE1_0_2008_to_2010_Carrier_Claims_Sample_2", .x, ".zip") %>%
    request() %>%
    req_retry(max_tries = 5) %>%
    req_perform(path = here::here("data-raw", paste0("carrier_", .x, ".zip")))
)

carrier_cols <-
  codebook %>%
  filter(TABLE == "Carrier") %>%
  pull(COL_TYPE) %>%
  paste(., collapse = "")

carrier_sample <-
  map_dfr(
    .x = c("A", "B"),
    ~read_csv(
      here::here("data-raw", paste0("carrier_", .x, ".zip")),
      col_types = carrier_cols,
      locale = locale(date_format = "%Y%m%d"))
  ) %>%
  inner_join(
    bene_rand, by = "DESYNPUF_ID"
  ) %>%
  filter_at(vars(CLM_FROM_DT, CLM_THRU_DT), all_vars(lubridate::year(.) %in% bene_years))

"https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/DE1_0_2008_to_2010_Inpatient_Claims_Sample_2.zip" %>%
  request() %>%
  req_retry(max_tries = 5) %>%
  req_perform(path = here::here("data-raw", "inpatient.zip"))

inpatient_cols <-
  codebook %>%
  filter(TABLE == "Inpatient") %>%
  pull(COL_TYPE) %>%
  paste(., collapse = "")

inpatient_sample <-
  read_csv(
    here::here("data-raw", "inpatient.zip"),
      col_types = inpatient_cols,
      locale = locale(date_format = "%Y%m%d")) %>%
  inner_join(
    bene_rand, by = "DESYNPUF_ID"
  ) %>%
  filter_at(vars(CLM_FROM_DT, CLM_THRU_DT), all_vars(lubridate::year(.) %in% bene_years))

"https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/DE1_0_2008_to_2010_Outpatient_Claims_Sample_2.zip" %>%
  request() %>%
  req_retry(max_tries = 5) %>%
  req_perform(path = here::here("data-raw", "outpatient.zip"))

outpatient_cols <-
  codebook %>%
  filter(TABLE == "Outpatient") %>%
  pull(COL_TYPE) %>%
  paste(., collapse = "")

outpatient_sample <-
  read_csv(
    here::here("data-raw", "outpatient.zip"),
    col_types = outpatient_cols,
    locale = locale(date_format = "%Y%m%d")) %>%
  inner_join(
    bene_rand, by = "DESYNPUF_ID"
  ) %>%
  filter_at(vars(CLM_FROM_DT, CLM_THRU_DT), all_vars(lubridate::year(.) %in% bene_years))


"http://downloads.cms.gov/files/DE1_0_2008_to_2010_Prescription_Drug_Events_Sample_2.zip" %>%
  request() %>%
  req_retry(max_tries = 5) %>%
  req_perform(path = here::here("data-raw", "pde.zip"))

pde_cols <-
  codebook %>%
  filter(TABLE == "PDE") %>%
  pull(COL_TYPE) %>%
  paste(., collapse = "")

pde_sample <-
  read_csv(
    here::here("data-raw", "pde.zip"),
    col_types = pde_cols,
    locale = locale(date_format = "%Y%m%d")) %>%
  inner_join(
    bene_rand, by = "DESYNPUF_ID"
  ) %>%
  filter(lubridate::year(SRVC_DT) %in% bene_years)

write_rds(bene_sample, here::here("data-raw", "bene.rds"))
write_rds(carrier_sample, here::here("data-raw", "carrier.rds"))
write_rds(inpatient_sample, here::here("data-raw", "inpatient.rds"))
write_rds(outpatient_sample, here::here("data-raw", "outpatient.rds"))
write_rds(pde_sample, here::here("data-raw", "pde.rds"))
