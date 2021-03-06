% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{carrier}
\alias{carrier}
\title{CMS Carrier Claims DE-SynPUF}
\format{
A data frame with 16,677 rows and 59 variables:
\describe{
\item{\code{DESYNPUF_ID}}{Beneficiary Code}
\item{\code{CLM_ID}}{Claim ID}
\item{\code{CLM_FROM_DT}}{Claims start date}
\item{\code{CLM_THRU_DT}}{Claims end date}
\item{\code{ICD9_DGNS_CD_1}}{Claim Diagnosis Code (1)}
\item{\code{ICD9_DGNS_CD_2}}{Claim Diagnosis Code (2)}
\item{\code{ICD9_DGNS_CD_3}}{Claim Diagnosis Code (3)}
\item{\code{ICD9_DGNS_CD_4}}{Claim Diagnosis Code (4)}
\item{\code{ICD9_DGNS_CD_5}}{Claim Diagnosis Code (5)}
\item{\code{PRF_PHYSN_NPI_1}}{Provider Physician National Provider Identifier Number (1)}
\item{\code{PRF_PHYSN_NPI_2}}{Provider Physician National Provider Identifier Number (2)}
\item{\code{PRF_PHYSN_NPI_3}}{Provider Physician National Provider Identifier Number (3)}
\item{\code{PRF_PHYSN_NPI_4}}{Provider Physician National Provider Identifier Number (4)}
\item{\code{PRF_PHYSN_NPI_5}}{Provider Physician National Provider Identifier Number (5)}
\item{\code{TAX_NUM_1}}{Provider Institution Tax Number (1)}
\item{\code{TAX_NUM_2}}{Provider Institution Tax Number (2)}
\item{\code{TAX_NUM_3}}{Provider Institution Tax Number (3)}
\item{\code{TAX_NUM_4}}{Provider Institution Tax Number (4)}
\item{\code{TAX_NUM_5}}{Provider Institution Tax Number (5)}
\item{\code{HCPCS_CD_1}}{Revenue Center HCFA Common Procedure Coding System (1)}
\item{\code{HCPCS_CD_2}}{Revenue Center HCFA Common Procedure Coding System (2)}
\item{\code{HCPCS_CD_3}}{Revenue Center HCFA Common Procedure Coding System (3)}
\item{\code{HCPCS_CD_4}}{Revenue Center HCFA Common Procedure Coding System (4)}
\item{\code{HCPCS_CD_5}}{Revenue Center HCFA Common Procedure Coding System (5)}
\item{\code{LINE_NCH_PMT_AMT_1}}{Line NCH Payment Amount (1)}
\item{\code{LINE_NCH_PMT_AMT_2}}{Line NCH Payment Amount (2)}
\item{\code{LINE_NCH_PMT_AMT_3}}{Line NCH Payment Amount (3)}
\item{\code{LINE_NCH_PMT_AMT_4}}{Line NCH Payment Amount (4)}
\item{\code{LINE_NCH_PMT_AMT_5}}{Line NCH Payment Amount (5)}
\item{\code{LINE_BENE_PTB_DDCTBL_AMT_1}}{Line Beneficiary Part B Deductible Amount (1)}
\item{\code{LINE_BENE_PTB_DDCTBL_AMT_2}}{Line Beneficiary Part B Deductible Amount (2)}
\item{\code{LINE_BENE_PTB_DDCTBL_AMT_3}}{Line Beneficiary Part B Deductible Amount (3)}
\item{\code{LINE_BENE_PTB_DDCTBL_AMT_4}}{Line Beneficiary Part B Deductible Amount (4)}
\item{\code{LINE_BENE_PTB_DDCTBL_AMT_5}}{Line Beneficiary Part B Deductible Amount (5)}
\item{\code{LINE_BENE_PRMRY_PYR_PD_AMT_1}}{Line Beneficiary Primary Payer Paid Amount (1)}
\item{\code{LINE_BENE_PRMRY_PYR_PD_AMT_2}}{Line Beneficiary Primary Payer Paid Amount (2)}
\item{\code{LINE_BENE_PRMRY_PYR_PD_AMT_3}}{Line Beneficiary Primary Payer Paid Amount (3)}
\item{\code{LINE_BENE_PRMRY_PYR_PD_AMT_4}}{Line Beneficiary Primary Payer Paid Amount (4)}
\item{\code{LINE_BENE_PRMRY_PYR_PD_AMT_5}}{Line Beneficiary Primary Payer Paid Amount (5)}
\item{\code{LINE_COINSRNC_AMT_1}}{Line Coinsurance Amount (1)}
\item{\code{LINE_COINSRNC_AMT_2}}{Line Coinsurance Amount (2)}
\item{\code{LINE_COINSRNC_AMT_3}}{Line Coinsurance Amount (3)}
\item{\code{LINE_COINSRNC_AMT_4}}{Line Coinsurance Amount (4)}
\item{\code{LINE_COINSRNC_AMT_5}}{Line Coinsurance Amount (5)}
\item{\code{LINE_ALOWD_CHRG_AMT_1}}{Line Allowed Charge Amount (1)}
\item{\code{LINE_ALOWD_CHRG_AMT_2}}{Line Allowed Charge Amount (2)}
\item{\code{LINE_ALOWD_CHRG_AMT_3}}{Line Allowed Charge Amount (3)}
\item{\code{LINE_ALOWD_CHRG_AMT_4}}{Line Allowed Charge Amount (4)}
\item{\code{LINE_ALOWD_CHRG_AMT_5}}{Line Allowed Charge Amount (5)}
\item{\code{LINE_PRCSG_IND_CD_1}}{Line Processing Indicator Code (1)}
\item{\code{LINE_PRCSG_IND_CD_2}}{Line Processing Indicator Code (2)}
\item{\code{LINE_PRCSG_IND_CD_3}}{Line Processing Indicator Code (3)}
\item{\code{LINE_PRCSG_IND_CD_4}}{Line Processing Indicator Code (4)}
\item{\code{LINE_PRCSG_IND_CD_5}}{Line Processing Indicator Code (5)}
\item{\code{LINE_ICD9_DGNS_CD_1}}{Line Diagnosis Code (1)}
\item{\code{LINE_ICD9_DGNS_CD_2}}{Line Diagnosis Code (2)}
\item{\code{LINE_ICD9_DGNS_CD_3}}{Line Diagnosis Code (3)}
\item{\code{LINE_ICD9_DGNS_CD_4}}{Line Diagnosis Code (4)}
\item{\code{LINE_ICD9_DGNS_CD_5}}{Line Diagnosis Code (5)}
}
}
\source{
\url{https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DE_Syn_PUF}
}
\usage{
carrier
}
\description{
Synthetic physician/supplier claim records
}
\keyword{datasets}
