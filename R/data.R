claimsdb_tables <- function() {
  list(
    bene = claimsdb::bene,
    carrier = claimsdb::carrier,
    inpatient = claimsdb::inpatient,
    outpatient = claimsdb::outpatient,
    pde = claimsdb::pde
  )
}


#' CMS Beneficiary Summary DE-SynPUF
#'
#' Synthetic Medicare beneficiary records
#'
#' @format A data frame with 998 rows and 33 variables:
#' \describe{
#'   \item{\code{BENE_YEAR}}{Beneficiary Enrollment Year}
#'   \item{\code{DESYNPUF_ID}}{Beneficiary Code}
#'   \item{\code{BENE_BIRTH_DT}}{Date of birth}
#'   \item{\code{BENE_DEATH_DT}}{Date of death}
#'   \item{\code{BENE_SEX_IDENT_CD}}{Sex}
#'   \item{\code{BENE_RACE_CD}}{Beneficiary Race Code}
#'   \item{\code{BENE_ESRD_IND}}{End stage renal disease Indicator}
#'   \item{\code{SP_STATE_CODE}}{State Code}
#'   \item{\code{BENE_COUNTY_CD}}{County Code}
#'   \item{\code{BENE_HI_CVRAGE_TOT_MONS}}{Total number of months of part A coverage for the beneficiary}
#'   \item{\code{BENE_SMI_CVRAGE_TOT_MONS}}{Total number of months of part B coverage for the beneficiary}
#'   \item{\code{BENE_HMO_CVRAGE_TOT_MONS}}{Total number of months of HMO coverage for the beneficiary}
#'   \item{\code{PLAN_CVRG_MOS_NUM}}{Total number of months of part D plan coverage for the beneficiary}
#'   \item{\code{SP_ALZHDMTA}}{Chronic Condition Alzheimer or related disorders or senile}
#'   \item{\code{SP_CHF}}{Chronic Condition Heart Failure}
#'   \item{\code{SP_CHRNKIDN}}{Chronic Condition Chronic Kidney Disease}
#'   \item{\code{SP_CNCR}}{Chronic Condition Cancer}
#'   \item{\code{SP_COPD}}{Chronic Condition Chronic Obstructive Pulmonary Disease}
#'   \item{\code{SP_DEPRESSN}}{Chronic Condition Depression}
#'   \item{\code{SP_DIABETES}}{Chronic Condition Diabetes}
#'   \item{\code{SP_ISCHMCHT}}{Chronic Condition Ischemic Heart Disease}
#'   \item{\code{SP_OSTEOPRS}}{Chronic Condition Osteoporosis}
#'   \item{\code{SP_RA_OA}}{Chronic Condition RAOA}
#'   \item{\code{SP_STRKETIA}}{Chronic Condition Stroketransient Ischemic Attack}
#'   \item{\code{MEDREIMB_IP}}{Inpatient annual Medicare reimbursement amount}
#'   \item{\code{BENRES_IP}}{Inpatient annual beneficiary responsibility amount}
#'   \item{\code{PPPYMT_IP}}{Inpatient annual primary payer reimbursement amount}
#'   \item{\code{MEDREIMB_OP}}{Outpatient Institutional annual Medicare reimbursement amount}
#'   \item{\code{BENRES_OP}}{Outpatient Institutional annual beneficiary responsibility amount}
#'   \item{\code{PPPYMT_OP}}{Outpatient Institutional annual primary payer reimbursement amount}
#'   \item{\code{MEDREIMB_CAR}}{Carrier annual Medicare reimbursement amount}
#'   \item{\code{BENRES_CAR}}{Carrier annual beneficiary responsibility amount}
#'   \item{\code{PPPYMT_CAR}}{Carrier annual primary payer reimbursement amount}
#' }
#' @source \url{https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DE_Syn_PUF}
"bene"

#' CMS Carrier Claims DE-SynPUF
#'
#' Synthetic physician/supplier claim records
#'
#' @format A data frame with 16,677 rows and 59 variables:
#' \describe{
#'   \item{\code{DESYNPUF_ID}}{Beneficiary Code}
#'   \item{\code{CLM_ID}}{Claim ID}
#'   \item{\code{CLM_FROM_DT}}{Claims start date}
#'   \item{\code{CLM_THRU_DT}}{Claims end date}
#'   \item{\code{ICD9_DGNS_CD_1}}{Claim Diagnosis Code (1)}
#'   \item{\code{ICD9_DGNS_CD_2}}{Claim Diagnosis Code (2)}
#'   \item{\code{ICD9_DGNS_CD_3}}{Claim Diagnosis Code (3)}
#'   \item{\code{ICD9_DGNS_CD_4}}{Claim Diagnosis Code (4)}
#'   \item{\code{ICD9_DGNS_CD_5}}{Claim Diagnosis Code (5)}
#'   \item{\code{PRF_PHYSN_NPI_1}}{Provider Physician National Provider Identifier Number (1)}
#'   \item{\code{PRF_PHYSN_NPI_2}}{Provider Physician National Provider Identifier Number (2)}
#'   \item{\code{PRF_PHYSN_NPI_3}}{Provider Physician National Provider Identifier Number (3)}
#'   \item{\code{PRF_PHYSN_NPI_4}}{Provider Physician National Provider Identifier Number (4)}
#'   \item{\code{PRF_PHYSN_NPI_5}}{Provider Physician National Provider Identifier Number (5)}
#'   \item{\code{TAX_NUM_1}}{Provider Institution Tax Number (1)}
#'   \item{\code{TAX_NUM_2}}{Provider Institution Tax Number (2)}
#'   \item{\code{TAX_NUM_3}}{Provider Institution Tax Number (3)}
#'   \item{\code{TAX_NUM_4}}{Provider Institution Tax Number (4)}
#'   \item{\code{TAX_NUM_5}}{Provider Institution Tax Number (5)}
#'   \item{\code{HCPCS_CD_1}}{Revenue Center HCFA Common Procedure Coding System (1)}
#'   \item{\code{HCPCS_CD_2}}{Revenue Center HCFA Common Procedure Coding System (2)}
#'   \item{\code{HCPCS_CD_3}}{Revenue Center HCFA Common Procedure Coding System (3)}
#'   \item{\code{HCPCS_CD_4}}{Revenue Center HCFA Common Procedure Coding System (4)}
#'   \item{\code{HCPCS_CD_5}}{Revenue Center HCFA Common Procedure Coding System (5)}
#'   \item{\code{LINE_NCH_PMT_AMT_1}}{Line NCH Payment Amount (1)}
#'   \item{\code{LINE_NCH_PMT_AMT_2}}{Line NCH Payment Amount (2)}
#'   \item{\code{LINE_NCH_PMT_AMT_3}}{Line NCH Payment Amount (3)}
#'   \item{\code{LINE_NCH_PMT_AMT_4}}{Line NCH Payment Amount (4)}
#'   \item{\code{LINE_NCH_PMT_AMT_5}}{Line NCH Payment Amount (5)}
#'   \item{\code{LINE_BENE_PTB_DDCTBL_AMT_1}}{Line Beneficiary Part B Deductible Amount (1)}
#'   \item{\code{LINE_BENE_PTB_DDCTBL_AMT_2}}{Line Beneficiary Part B Deductible Amount (2)}
#'   \item{\code{LINE_BENE_PTB_DDCTBL_AMT_3}}{Line Beneficiary Part B Deductible Amount (3)}
#'   \item{\code{LINE_BENE_PTB_DDCTBL_AMT_4}}{Line Beneficiary Part B Deductible Amount (4)}
#'   \item{\code{LINE_BENE_PTB_DDCTBL_AMT_5}}{Line Beneficiary Part B Deductible Amount (5)}
#'   \item{\code{LINE_BENE_PRMRY_PYR_PD_AMT_1}}{Line Beneficiary Primary Payer Paid Amount (1)}
#'   \item{\code{LINE_BENE_PRMRY_PYR_PD_AMT_2}}{Line Beneficiary Primary Payer Paid Amount (2)}
#'   \item{\code{LINE_BENE_PRMRY_PYR_PD_AMT_3}}{Line Beneficiary Primary Payer Paid Amount (3)}
#'   \item{\code{LINE_BENE_PRMRY_PYR_PD_AMT_4}}{Line Beneficiary Primary Payer Paid Amount (4)}
#'   \item{\code{LINE_BENE_PRMRY_PYR_PD_AMT_5}}{Line Beneficiary Primary Payer Paid Amount (5)}
#'   \item{\code{LINE_COINSRNC_AMT_1}}{Line Coinsurance Amount (1)}
#'   \item{\code{LINE_COINSRNC_AMT_2}}{Line Coinsurance Amount (2)}
#'   \item{\code{LINE_COINSRNC_AMT_3}}{Line Coinsurance Amount (3)}
#'   \item{\code{LINE_COINSRNC_AMT_4}}{Line Coinsurance Amount (4)}
#'   \item{\code{LINE_COINSRNC_AMT_5}}{Line Coinsurance Amount (5)}
#'   \item{\code{LINE_ALOWD_CHRG_AMT_1}}{Line Allowed Charge Amount (1)}
#'   \item{\code{LINE_ALOWD_CHRG_AMT_2}}{Line Allowed Charge Amount (2)}
#'   \item{\code{LINE_ALOWD_CHRG_AMT_3}}{Line Allowed Charge Amount (3)}
#'   \item{\code{LINE_ALOWD_CHRG_AMT_4}}{Line Allowed Charge Amount (4)}
#'   \item{\code{LINE_ALOWD_CHRG_AMT_5}}{Line Allowed Charge Amount (5)}
#'   \item{\code{LINE_PRCSG_IND_CD_1}}{Line Processing Indicator Code (1)}
#'   \item{\code{LINE_PRCSG_IND_CD_2}}{Line Processing Indicator Code (2)}
#'   \item{\code{LINE_PRCSG_IND_CD_3}}{Line Processing Indicator Code (3)}
#'   \item{\code{LINE_PRCSG_IND_CD_4}}{Line Processing Indicator Code (4)}
#'   \item{\code{LINE_PRCSG_IND_CD_5}}{Line Processing Indicator Code (5)}
#'   \item{\code{LINE_ICD9_DGNS_CD_1}}{Line Diagnosis Code (1)}
#'   \item{\code{LINE_ICD9_DGNS_CD_2}}{Line Diagnosis Code (2)}
#'   \item{\code{LINE_ICD9_DGNS_CD_3}}{Line Diagnosis Code (3)}
#'   \item{\code{LINE_ICD9_DGNS_CD_4}}{Line Diagnosis Code (4)}
#'   \item{\code{LINE_ICD9_DGNS_CD_5}}{Line Diagnosis Code (5)}
#' }
#' @source \url{https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DE_Syn_PUF}
"carrier"

#' CMS Inpatient Claims DE-SynPUF
#'
#' Synthetic inpatient claim records
#'
#' @format A data frame with 225 rows and 35 variables:
#' \describe{
#'   \item{\code{DESYNPUF_ID}}{Beneficiary Code}
#'   \item{\code{CLM_ID}}{Claim ID}
#'   \item{\code{SEGMENT}}{Claim Line Segment}
#'   \item{\code{CLM_FROM_DT}}{Claims start date}
#'   \item{\code{CLM_THRU_DT}}{Claims end date}
#'   \item{\code{PRVDR_NUM}}{Provider Institution}
#'   \item{\code{CLM_PMT_AMT}}{Claim Payment Amount}
#'   \item{\code{NCH_PRMRY_PYR_CLM_PD_AMT}}{NCH Primary Payer Claim Paid Amount}
#'   \item{\code{AT_PHYSN_NPI}}{Attending Physician National Provider Identifier Number}
#'   \item{\code{OP_PHYSN_NPI}}{Operating Physician National Provider Identifier Number}
#'   \item{\code{OT_PHYSN_NPI}}{Other Physician National Provider Identifier Number}
#'   \item{\code{CLM_ADMSN_DT}}{Inpatient admission date}
#'   \item{\code{ADMTNG_ICD9_DGNS_CD}}{Claim Admitting Diagnosis Code}
#'   \item{\code{CLM_PASS_THRU_PER_DIEM_AMT}}{Claim Pass Thru Per Diem Amount}
#'   \item{\code{NCH_BENE_IP_DDCTBL_AMT}}{NCH Beneficiary Inpatient Deductible Amount}
#'   \item{\code{NCH_BENE_PTA_COINSRNC_LBLTY_AM}}{NCH Beneficiary Part A Coinsurance Liability Amount}
#'   \item{\code{NCH_BENE_BLOOD_DDCTBL_LBLTY_AM}}{NCH Beneficiary Blood Deductible Liability Amount}
#'   \item{\code{CLM_UTLZTN_DAY_CNT}}{Claim Utilization Day Count}
#'   \item{\code{NCH_BENE_DSCHRG_DT}}{Inpatient discharged date}
#'   \item{\code{CLM_DRG_CD}}{Claim Diagnosis Related Group Code}
#'   \item{\code{ICD9_DGNS_CD_1}}{Claim Diagnosis Code (1)}
#'   \item{\code{ICD9_DGNS_CD_2}}{Claim Diagnosis Code (2)}
#'   \item{\code{ICD9_DGNS_CD_3}}{Claim Diagnosis Code (3)}
#'   \item{\code{ICD9_DGNS_CD_4}}{Claim Diagnosis Code (4)}
#'   \item{\code{ICD9_DGNS_CD_5}}{Claim Diagnosis Code (5)}
#'   \item{\code{ICD9_PRCDR_CD_1}}{Claim Procedure Code (1)}
#'   \item{\code{ICD9_PRCDR_CD_2}}{Claim Procedure Code (2)}
#'   \item{\code{ICD9_PRCDR_CD_3}}{Claim Procedure Code (3)}
#'   \item{\code{ICD9_PRCDR_CD_4}}{Claim Procedure Code (4)}
#'   \item{\code{ICD9_PRCDR_CD_5}}{Claim Procedure Code (5)}
#'   \item{\code{HCPCS_CD_1}}{Revenue Center HCFA Common Procedure Coding System (1)}
#'   \item{\code{HCPCS_CD_2}}{Revenue Center HCFA Common Procedure Coding System (2)}
#'   \item{\code{HCPCS_CD_3}}{Revenue Center HCFA Common Procedure Coding System (3)}
#'   \item{\code{HCPCS_CD_4}}{Revenue Center HCFA Common Procedure Coding System (4)}
#'   \item{\code{HCPCS_CD_5}}{Revenue Center HCFA Common Procedure Coding System (5)}
#' }
#' @source \url{https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DE_Syn_PUF}
"inpatient"

#' CMS Outpatient Claims DE-SynPUF
#'
#' Synthetic outpatient claim records
#'
#' @format A data frame with 2,827 rows and 30 variables:
#' \describe{
#'   \item{\code{DESYNPUF_ID}}{Beneficiary Code}
#'   \item{\code{CLM_ID}}{Claim ID}
#'   \item{\code{SEGMENT}}{Claim Line Segment}
#'   \item{\code{CLM_FROM_DT}}{Claims start date}
#'   \item{\code{CLM_THRU_DT}}{Claims end date}
#'   \item{\code{PRVDR_NUM}}{Provider Institution}
#'   \item{\code{CLM_PMT_AMT}}{Claim Payment Amount}
#'   \item{\code{NCH_PRMRY_PYR_CLM_PD_AMT}}{NCH Primary Payer Claim Paid Amount}
#'   \item{\code{AT_PHYSN_NPI}}{Attending Physician National Provider Identifier Number}
#'   \item{\code{OP_PHYSN_NPI}}{Operating Physician National Provider Identifier Number}
#'   \item{\code{OT_PHYSN_NPI}}{Other Physician National Provider Identifier Number}
#'   \item{\code{NCH_BENE_BLOOD_DDCTBL_LBLTY_AM}}{NCH Beneficiary Blood Deductible Liability Amount}
#'   \item{\code{ICD9_DGNS_CD_1}}{Claim Diagnosis Code (1)}
#'   \item{\code{ICD9_DGNS_CD_2}}{Claim Diagnosis Code (2)}
#'   \item{\code{ICD9_DGNS_CD_3}}{Claim Diagnosis Code (3)}
#'   \item{\code{ICD9_DGNS_CD_4}}{Claim Diagnosis Code (4)}
#'   \item{\code{ICD9_DGNS_CD_5}}{Claim Diagnosis Code (5)}
#'   \item{\code{ICD9_PRCDR_CD_1}}{Claim Procedure Code (1)}
#'   \item{\code{ICD9_PRCDR_CD_2}}{Claim Procedure Code (2)}
#'   \item{\code{ICD9_PRCDR_CD_3}}{Claim Procedure Code (3)}
#'   \item{\code{ICD9_PRCDR_CD_4}}{Claim Procedure Code (4)}
#'   \item{\code{ICD9_PRCDR_CD_5}}{Claim Procedure Code (5)}
#'   \item{\code{NCH_BENE_PTB_DDCTBL_AMT}}{NCH Beneficiary Part B Deductible Amount}
#'   \item{\code{NCH_BENE_PTB_COINSRNC_AMT}}{NCH Beneficiary Part B Coinsurance Amount}
#'   \item{\code{ADMTNG_ICD9_DGNS_CD}}{Claim Admitting Diagnosis Code}
#'   \item{\code{HCPCS_CD_1}}{Revenue Center HCFA Common Procedure Coding System (1)}
#'   \item{\code{HCPCS_CD_2}}{Revenue Center HCFA Common Procedure Coding System (2)}
#'   \item{\code{HCPCS_CD_3}}{Revenue Center HCFA Common Procedure Coding System (3)}
#'   \item{\code{HCPCS_CD_4}}{Revenue Center HCFA Common Procedure Coding System (4)}
#'   \item{\code{HCPCS_CD_5}}{Revenue Center HCFA Common Procedure Coding System (5)}
#' }
#' @source \url{https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DE_Syn_PUF}
"outpatient"

#' CMS Prescription Drug Events (PDE) DE-SynPUF
#'
#' Synthetic Part D event records
#'
#' @format A data frame with 17,443 rows and 8 variables:
#' \describe{
#'   \item{\code{DESYNPUF_ID}}{Beneficiary Code}
#'   \item{\code{PDE_ID}}{CCW Part D Event Number}
#'   \item{\code{SRVC_DT}}{RX Service Date}
#'   \item{\code{PROD_SRVC_ID}}{Product Service ID}
#'   \item{\code{QTY_DSPNSD_NUM}}{Quantity Dispensed}
#'   \item{\code{DAYS_SUPLY_NUM}}{Days Supply}
#'   \item{\code{PTNT_PAY_AMT}}{Patient Pay Amount}
#'   \item{\code{TOT_RX_CST_AMT}}{Gross Drug Cost}
#' }
#' @source \url{https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DE_Syn_PUF}
"pde"

#' CMS Data Entrepreneurs’ Synthetic Public Use File Schema
#'
#' Includes information about the schema of the tables that were sourced from
#' [CMS](https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DE_Syn_PUF),
#' the _CMS 2008-2010 Data Entrepreneurs’ Synthetic Public Use File (DE-SynPUF)_.
#' This package include 500 randomly selected beneficiaries from the 2008 file in
#' sample 2, along with their associated beneficiary records and claims for 2008
#' and 2009. Not all variables from the DE-SynPUF are columns in the data
#' in this package: numbered fields (e.g., claims diagnosis codes) were limited
#' to the first 5 to limit file size. Full documentation for the DE-SynPUF is
#' available for sample 2 from [CMS](https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DESample02).
#'
#' @format A data frame with 5 rows and 5 variables:
#' \describe{
#'   \item{\code{TABLE}}{Name of the DE_SynPUF table}
#'   \item{\code{TABLE_TITLE}}{Full title of the DE_SynPUF table}
#'   \item{\code{TABLE_DESCRIPTION}}{Description of the DE_SynPUF table}
#'   \item{\code{UNIT_OF_RECORD}}{Description of the type of records in the table}
#'   \item{\code{PROPERTIES}}{The properties of the table as a nested table containing the `VARIABLE`, the data `TYPE`, and a `DESCRIPTION` of the columns}
#' }
"schema"
