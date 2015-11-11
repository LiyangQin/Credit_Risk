library(xlsx)
library(dplyr)
arrears <- function(MCC = "chifeng", current_date, base_date){
    ## Read the data
    base_file <- paste0("./Arrears/Loan_Accounts-", MCC,"-liyang.qin-2015-",base_date, ".xls")
    latest_file <- paste0("./Arrears/Loan_Accounts-", MCC, "-liyang.qin-2015-",current_date,".xls")
    base_data <- read.xlsx2(base_file, sheetIndex =1, header = TRUE, encoding = "urf-8")
    latest_data <- read.xlsx2(latest_file, sheetIndex =1, header = TRUE, encoding = "urf-8")
    
    # Subset the accounts in arrears
    arrears_base <- base_data[base_data$Account.State == "In Arrears", ]
    ## arrear_base <- arrear_base[c("Account.ID", "Principal.Balance","Days.In.Arrears")]
    arrears_latest <- latest_data[latest_data$Account.State == "In Arrears",]
    ## arrear_latest <- arrear_latest[c("Account.ID","Principal.Balance","Days.In.Arrears")]
    
    ## Find new delinquencies; Search new ID in old data base
    ## new delinquencies do not exist in old data base
    New_Delinquency <- anti_join(arrears_latest, arrears_base, by = "Account.ID")
    ## Find closed accout; Search old ID set in new data base
    ## closed account won't show up in new data base
    Closed_Delinquency <- anti_join(arrears_base,arrears_latest, by ="Account.ID")
    
    ## Find client that has repaid loan, but the account is still in arrears
    
}