library(xlsx)
library(dplyr)
rm(list=ls())
arrears <- function(current_date, base_date){
    ## Read the data
    base_file <- paste0("./Arrears/Loan_Accounts-chifeng-liyang.qin-2015-",base_date, ".xls")
    latest_file <- paste0("./Arrears/Loan_Accounts-chifeng-liyang.qin-2015-",current_date,".xls")
    classes <- c(rep("character",10), rep("Date", 2), rep("numeric",13))
    base_data <- read.xlsx2(base_file, sheetIndex =1, header = TRUE, colClasses = classes, encoding = "urf-8")
    latest_data <- read.xlsx2(latest_file, sheetIndex =1, header = TRUE, colClasses = classes, encoding = "urf-8")
    
    # Subset the accounts in arrears
    arrears_base <- base_data[base_data$Account.State == "In Arrears", ]
    ## arrear_base <- arrear_base[c("Account.ID", "Principal.Balance","Days.In.Arrears")]
    arrears_latest <- latest_data[latest_data$Account.State == "In Arrears",]
    
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
    if(nrow(New_Delinquency)>0){
        New_Delinquency <- semi_join(arrears_latest,New_Delinquency, by = "Account.ID")
        new_output <- mutate(New_Delinquency, Balance.Change = Principal.Balance)
        new_output <- cbind(Date = base_date, Type = "+ 新增", new_output)
    }
    ## Find closed accout; Search old ID set in new data base
    ## closed account won't show up in new data base
    Closed_Delinquency <- mutual_account[is.na(mutual_account$Ending.Principal.Balance),]
    if(nrow(Closed_Delinquency)>0){
        Closed_Delinquency <- semi_join(arrears_base,Closed_Delinquency, by = "Account.ID")
        closed_output <- mutate(Closed_Delinquency, Balance.Change = Principal.Balance)
        closed_output <- cbind(Date = base_date, Type = "- 结清", closed_output)
    }
    ## Find client that has repaid loan, but the account is still in arrears
    ## These accounts exist in both datasets with difference principle balance
    ## Calculate the balance change
    Account_Repaid <- mutate(mutual_account, Balance.Change = Starting.Principal.Balance - Ending.Principal.Balance)
    Account_Repaid <- filter(Account_Repaid, Balance.Change >0)
    Account_Repaid <- Account_Repaid[c("Account.ID","Balance.Change")]
    if(nrow(Account_Repaid)>0){
        Repaid_Account <- semi_join(arrears_latest, Account_Repaid, by = "Account.ID")
        repaid_output <- full_join(Repaid_Account, Account_Repaid, by="Account.ID")
        repaid_output <- cbind(Date = base_date, Type = "- 减少", repaid_output)
    }
    ## Export the data to excel. 

    output_cf <- data.frame()
    
    if(exists("new_output")){
        output_cf <- rbind(output_cf, new_output)
        rm(new_output)
    }
    
    if(exists("closed_output")){
        output_cf <- rbind(output_cf, closed_output)
        rm(closed_output)
    }
   
    if(exists("repaid_output")){
        output_cf <- rbind(output_cf, repaid_output)
        rm(repaid_output)
    }
    
    ############################################################################
    ## Repeat the process for Wanzhou
   
    base_file <- paste0("./Arrears/Loan_Accounts-wanzhou-liyang.qin-2015-",base_date, ".xls")
    latest_file <- paste0("./Arrears/Loan_Accounts-wanzhou-liyang.qin-2015-",current_date,".xls")
    classes <- c(rep("character",5), "numeric", "character",rep("numeric",7), 
                 "Date", "numeric", "Date", rep("character",3), rep("numeric",5))
    base_data <- read.xlsx2(base_file, sheetIndex =1, header = TRUE, colClasses = classes, encoding = "urf-8")
    latest_data <- read.xlsx2(latest_file, sheetIndex =1, header = TRUE, colClasses = classes, encoding = "urf-8")
    
    # Subset the accounts in arrears
    arrears_base <- base_data[base_data$Account.State == "In Arrears", ]
    ## arrear_base <- arrear_base[c("Account.ID", "Principal.Balance","Days.In.Arrears")]
    arrears_latest <- latest_data[latest_data$Account.State == "In Arrears",]
    
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
    if(nrow(New_Delinquency)>0){
        New_Delinquency <- semi_join(arrears_latest,New_Delinquency, by = "Account.ID")
        new_output <- mutate(New_Delinquency, Balance.Change = Principal.Balance)
        new_output <- cbind(Date = base_date, Type = "+ 新增", new_output)
    }
    ## Find closed accout; Search old ID set in new data base
    ## closed account won't show up in new data base
    Closed_Delinquency <- mutual_account[is.na(mutual_account$Ending.Principal.Balance),]
    if(nrow(Closed_Delinquency)>0){
        Closed_Delinquency <- semi_join(arrears_base,Closed_Delinquency, by = "Account.ID")
        closed_output <- mutate(Closed_Delinquency, Balance.Change = Principal.Balance)
        closed_output <- cbind(Date = base_date, Type = "- 结清", closed_output)
    }
    ## Find client that has repaid loan, but the account is still in arrears
    ## These accounts exist in both datasets with difference principle balance
    ## Calculate the balance change
    Account_Repaid <- mutate(mutual_account, Balance.Change = Starting.Principal.Balance - Ending.Principal.Balance)
    Account_Repaid <- filter(Account_Repaid, Balance.Change >0)
    Account_Repaid <- Account_Repaid[c("Account.ID","Balance.Change")]
    if(nrow(Account_Repaid)>0){
        Repaid_Account <- semi_join(arrears_latest, Account_Repaid, by = "Account.ID")
        repaid_output <- full_join(Repaid_Account, Account_Repaid, by="Account.ID")
        repaid_output <- cbind(Date = base_date, Type = "- 减少", repaid_output)
    }
    ## Export the data to excel. 
    
    output_wz <- data.frame()
    
    if(exists("new_output")){
        output_wz <- rbind(output_wz, new_output)
    }
    
    if(exists("closed_output")){
        output_wz <- rbind(output_wz, closed_output)
    }
    
    if(exists("repaid_output")){
        output_wz <- rbind(output_wz, repaid_output)
    }
    ## Write result to excel
    file_dest <- paste0("./Arrears/Arrear_Changes-2015-", base_date ,".xlsx")
    wb <- createWorkbook()
    sheet1 <- createSheet(wb, sheetName = "Chifeng")
    sheet2 <- createSheet(wb,sheetName = "Wanzhou")
    addDataFrame(output_cf, sheet1, startRow=1, startColumn=1, row.names = FALSE)
    addDataFrame(output_wz, sheet2, startRow=1, startColumn=1, row.names = FALSE)
    saveWorkbook(wb, file_dest)
}