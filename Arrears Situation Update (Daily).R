library(xlsx)
library(dplyr)
arrears <- function(MCC = "chifeng", current_date, base_date){
    ## Read the data
    base_file <- paste0("./Arrears/Loan_Accounts-", MCC,"-liyang.qin-2015-",base_date, ".xls")
    latest_file <- paste0("./Arrears/Loan_Accounts-", MCC, "-liyang.qin-2015-",current_date,".xls")
    classes <- c(rep("character",10), rep("Date", 2), rep("numeric",13))
    base_data <- read.xlsx2(base_file, sheetIndex =1, header = TRUE, colClasses = classes, encoding = "urf-8")
    latest_data <- read.xlsx2(latest_file, sheetIndex =1, header = TRUE, colClasses = classes, encoding = "urf-8")
    
    ## Subset key variables for filtering the changes
    arrears_start <- arrears_base[c("Account.ID", "Principal.Balance")]
    arrears_start <- rename(arrears_start, Starting.Principal.Balance = Principal.Balance)
    arrears_end <- arrears_latest[c("Account.ID","Principal.Balance")]
    arrears_end <- rename(arrears_end, Ending.Principal.Balance = Principal.Balance)
   
    ## Join the mutual accounts in these two data sets. 
    mutual_account <- full_join(arrears_start, arrears_end, by = "Account.ID")
    ## Find new delinquencies; Search new ID in old data base
    ## new delinquencies do not exist in old data base
    New_Delinquency <- mutual_account[is.na(mutual_account$Starting.Principal.Balance),]
    ## Find closed accout; Search old ID set in new data base
    ## closed account won't show up in new data base
    Closed_Delinquency <- mutual_account[is.na(mutual_account$Ending.Principal.Balance),]
    
    ## Find client that has repaid loan, but the account is still in arrears
    ## These accounts exist in both datasets with difference principle balance
    ## Calculate the balance change
    Account_Repaid <- mutate(mutual_account, repayment = Starting.Principal.Balance - Ending.Principal.Balance)
    Account_Repaid <- filter(Account_Repaid, repayment >0)
    
    ## Export the data to excel. 
    ## We want to add lable of date and types of change in the file
	
    
}