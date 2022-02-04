library(tidyverse)

raw <- list(
  bene = read_rds(here::here("data-raw", "bene.rds")),
  carrier = read_rds(here::here("data-raw", "carrier.rds")),
  inpatient = read_rds(here::here("data-raw", "inpatient.rds")),
  outpatient = read_rds(here::here("data-raw", "outpatient.rds")),
  pde = read_rds(here::here("data-raw", "pde.rds"))
)

codebook <- read_rds(here::here("data-raw", "codebook.rds"))

schema <-
  tribble(
    ~TABLE, ~VAR_NAME, ~VAR_DESCR, ~VAR_TYPE,
    "Bene", "BENE_YEAR", "Beneficiary Enrollment Year", "numeric"
  ) %>%
  bind_rows(codebook) %>%
  mutate(VAR_NUM = parse_number(VAR_DESCR)) %>%
  filter(is.na(VAR_NUM) | VAR_NUM <= 5) %>%
  select(
    TABLE,
    VARIABLE = VAR_NAME,
    TYPE = VAR_TYPE,
    DESCRIPTION = VAR_DESCR
  ) %>%
  nest(PROPERTIES = c(VARIABLE, TYPE, DESCRIPTION)) %>%
  bind_cols(
    tribble(
      ~TABLE_TITLE, ~TABLE_DESCRIPTION, ~UNIT_OF_RECORD,
      "CMS Beneficiary Summary DE-SynPUF", "Synthetic Medicare beneficiary records", "Beneficiary",
      "CMS Carrier Claims DE-SynPUF", "Synthetic physician/supplier claim records", "claim",
      "CMS Inpatient Claims DE-SynPUF", "Synthetic inpatient claim records", "claim",
      "CMS Outpatient Claims DE-SynPUF", "Synthetic outpatient claim records", "claim",
      "CMS Prescription Drug Events (PDE) DE-SynPUF", "Synthetic Part D event records", "claim"
    )
  ) %>%
  select(TABLE, TABLE_TITLE, TABLE_DESCRIPTION, UNIT_OF_RECORD, PROPERTIES) %>%
  mutate(TABLE = str_to_lower(TABLE))

write_rds(schema, here::here("data-raw", "schema.rds"))

usethis::use_data(schema, overwrite = TRUE)

cms_synth <-
  raw %>%
  map(
    . %>%
      select(
        .,
        -num_range("ICD9_DGNS_CD_", 6:20),
        -num_range("HCPCS_CD_", 6:45),
        -num_range("LINE_ICD9_DGNS_CD_", 6:20),
        -num_range("TAX_NUM_", 6:20),
        -num_range("PRF_PHYSN_NPI_", 6:20),
        -num_range("ICD9_PRCDR_CD_", 6:20),
        -num_range("LINE_NCH_PMT_AMT_", 6:20),
        -num_range("LINE_BENE_PTB_DDCTBL_AMT_", 6:20),
        -num_range("LINE_BENE_PRMRY_PYR_PD_AMT_", 6:20),
        -num_range("LINE_COINSRNC_AMT_", 6:20),
        -num_range("LINE_ALOWD_CHRG_AMT_", 6:20),
        -num_range("LINE_PRCSG_IND_CD_", 6:20)
      )
  ) %>%
  map_at("bene", . %>% mutate(BENE_YEAR = as.numeric(BENE_YEAR)))

cms_synth %>% iwalk(function(data, name) {
  assign(name, data)
  eval(parse(text = glue::glue("usethis::use_data({name}, overwrite = TRUE)")))
})
