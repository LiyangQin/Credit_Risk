library(xlsx)
library(dplyr)
rm(list=ls())
arrears <- function(current_date, base_date){
    ## Read the data
    base_pattern <- paste0("Loan_Accounts-chifeng-liyang.qin-",base_date)
    latest_pattern <- paste0("Loan_Accounts-chifeng-liyang.qin-",current_date)
    base_file <- list.files("D:/360MoveData/Documents/Arrears/Mambu/", recursive =TRUE, all.files = TRUE, pattern = base_pattern)
    base_file <- paste0("D:/360MoveData/Documents/Arrears/Mambu/", base_file)
    latest_file <- list.files("D:/360MoveData/Documents/Arrears/Mambu/", recursive = TRUE, all.files =TRUE, pattern = latest_pattern)
    latest_file <- paste0("D:/360MoveData/Documents/Arrears/Mambu/", latest_file)
<<<<<<< HEAD
    classes <- c(rep("character",11), rep("numeric",13), rep("Date", 2),"numeric")
=======
    classes <- c(rep("character",11), rep("numeric",13), rep("Date", 2))
>>>>>>> 2485dd1... Initial commite for write off collection script
    base_data <- read.xlsx2(base_file,sheetIndex =1, header = TRUE, colClasses = classes, encoding = "urf-8")
    latest_data <- read.xlsx2(latest_file, sheetIndex =1, header = TRUE, colClasses = classes, encoding = "urf-8")
	
    ## Prepare excel file for exporting
    file_dest <- paste0("./Arrears/Result/Arrear_Changes_", base_date ,".xlsx")
    wb <- createWorkbook()
    sheet1 <- createSheet(wb, sheetName = "GIM")
    sheet2 <- createSheet(wb,sheetName = "GCQ")
    sheet3 <- createSheet(wb,sheetName = "GHN")
    
    # Portfolio Observation Section
    chifeng.ptf <- sapply(split(latest_data$Principal.Balance,latest_data$Account.State), sum)
    cf_OSPtf <- sum(latest_data$Principal.Balance)
    cf_OSPtf <- format(cf_OSPtf, big.mark = ",", decimal.mark = ".", nsmall = 0, scientific = FALSE)
    cf_PARValue <- format(chifeng.ptf[[2]], big.mark = ",", decimal.mark = ".", scientific = FALSE, nsmall = 0)
    par1 <- chifeng.ptf[[2]]/(chifeng.ptf[[1]]+chifeng.ptf[[2]])
    par1 <-  sprintf("%.1f %%", 100*par1)
    cf_actNo <- nrow(latest_data)
    cf_actNo <- format(cf_actNo, big.mark = ",", decimal.mark = ".", scientific = FALSE, nsmall = 0)
    
    cf_ptf <- paste("GIM:风险贷款额度", cf_PARValue, "风险贷款比例PAR1+", par1, "贷款余额", cf_OSPtf,
                    "活跃账户数", cf_actNo)
    
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
	cf_txt <- paste("现汇报每日逾期变动情况如下：", base_date, "赤峰 Chifeng", sep=" ")
    
    if(exists("new_output")){
        output_cf <- rbind(output_cf, new_output)
		cf_txt <- paste(cf_txt, "新增逾期", nrow(new_output), "笔",nrow(new_output), "new loans in arrears",sep=" ")
        rm(new_output)
    }
    
    if(exists("closed_output")){
        output_cf <- rbind(output_cf, closed_output)
		cf_txt <- paste(cf_txt,"逾期减少",nrow(closed_output),"笔",nrow(closed_output),"loans back to good standing",sep=" ")
        rm(closed_output)
    }
    
    if(exists("repaid_output")){
        output_cf <- rbind(output_cf, repaid_output)
		cf_txt <- paste(cf_txt,"逾期还款",nrow(repaid_output),"笔","collected repayment from",nrow(repaid_output),"loans",sep=" ")
        rm(repaid_output)
    }
	

	addDataFrame(output_cf, sheet1, startRow=1, startColumn=1, row.names = FALSE)
	saveWorkbook(wb, file_dest)
	print(cf_ptf)
	
    ############################################################################
    ## Repeat the process for chongqing
    
    base_pattern <- paste0("Loan_Accounts-wanzhou-liyang.qin-",base_date)
    latest_pattern <- paste0("Loan_Accounts-wanzhou-liyang.qin-",current_date)
    base_file <- list.files("D:/360MoveData/Documents/Arrears/Mambu/", recursive =TRUE, all.files = TRUE, pattern = base_pattern)
    base_file <- paste0("D:/360MoveData/Documents/Arrears/Mambu/", base_file)
    latest_file <- list.files("D:/360MoveData/Documents/Arrears/Mambu/", recursive = TRUE, all.files =TRUE, pattern = latest_pattern)
    latest_file <- paste0("D:/360MoveData/Documents/Arrears/Mambu/", latest_file)
    classes <- c(rep("character",11), rep("numeric",13), rep("Date", 2))
    base_data <- read.xlsx2(base_file,sheetIndex =1, header = TRUE, colClasses = classes, encoding = "urf-8")
    latest_data <- read.xlsx2(latest_file, sheetIndex =1, header = TRUE, colClasses = classes, encoding = "urf-8")
    
    # Portfolio Observation Section#
    chongqing.ptf <- sapply(split(latest_data$Principal.Balance,latest_data$Account.State), sum)
    cq_OSPtf <- sum(latest_data$Principal.Balance)
    cq_OSPtf <- format(cq_OSPtf, big.mark = ",", decimal.mark = ".", nsmall = 0, scientific = FALSE)
    cq_actNo <- nrow(latest_data)
    cq_actNo <- format(cq_actNo, big.mark = ",", decimal.mark = ".", scientific = FALSE, nsmall = 0)
    cq_PARValue <- format(chongqing.ptf[[2]], big.mark = ",", decimal.mark = ".", scientific = FALSE, nsmall = 0)
    par1 <- chongqing.ptf[[2]]/(chongqing.ptf[[1]]+chongqing.ptf[[2]])
    par1 <-  sprintf("%.1f %%", 100*par1)
    
    cq_ptf <- paste("GCQ:风险贷款额度", cq_PARValue, "风险贷款比例PAR1+", par1, "贷款余额", cq_OSPtf,
                    "活跃账户数", cq_actNo)
    
    
    ## Subset the accounts in arrears
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
	 
	## Export the data to variable. 
    
    output_cq<- data.frame()
	cq_txt <- "万州 chongqing"
    	
    if(exists("new_output")){
        output_cq <- rbind(output_cq, new_output)
		cq_txt <- paste(cq_txt,"新增逾期",nrow(new_output),"笔",nrow(new_output),"new loans in arrears",sep=" ")
        rm(new_output)
    }
    
    if(exists("closed_output")){
        output_cq <- rbind(output_cq, closed_output)
		cq_txt <- paste(cq_txt,"逾期减少",nrow(closed_output),"笔",nrow(closed_output),"loans back to good standing",sep=" ")
        rm(closed_output)
    }
    
    if(exists("repaid_output")){
        output_cq <- rbind(output_cq, repaid_output)
		cq_txt <- paste(cq_txt,"逾期还款",nrow(repaid_output),"笔","collected repayment from",nrow(repaid_output),"loans",sep=" ")
        rm(repaid_output)
    }
	

	addDataFrame(output_cq, sheet2, startRow=1, startColumn=1, row.names = FALSE)
	saveWorkbook(wb, file_dest)
	print(cq_ptf)

	############################################################################
    ## Repeat the process for hunan
    
    base_pattern <- paste0("Loan_Accounts-jishou-liyang.qin-",base_date)
    latest_pattern <- paste0("Loan_Accounts-jishou-liyang.qin-",current_date)
    base_file <- list.files("D:/360MoveData/Documents/Arrears/Mambu/", recursive =TRUE, all.files = TRUE, pattern = base_pattern)
    base_file <- paste0("D:/360MoveData/Documents/Arrears/Mambu/", base_file)
    latest_file <- list.files("D:/360MoveData/Documents/Arrears/Mambu/", recursive = TRUE, all.files =TRUE, pattern = latest_pattern)
    latest_file <- paste0("D:/360MoveData/Documents/Arrears/Mambu/", latest_file)
    # classes <- c(rep("character",11), rep("numeric",13), rep("Date", 2))
    base_data <- read.xlsx2(base_file,sheetIndex =1, header = TRUE, colClasses = classes, encoding = "urf-8")
    latest_data <- read.xlsx2(latest_file, sheetIndex =1, header = TRUE, colClasses = classes, encoding = "urf-8")
    
    
    # Subset the accounts in arrears
    arrears_base <- base_data[base_data$Account.State == "In Arrears", ]
    ## arrear_base <- arrear_base[c("Account.ID", "Principal.Balance","Days.In.Arrears")]
    arrears_latest <- latest_data[latest_data$Account.State == "In Arrears",]
   
     # Portfolio Observation Section
    hunan.ptf <- sapply(split(latest_data$Principal.Balance,latest_data$Account.State), sum)
    hn_OSPtf <- sum(latest_data$Principal.Balance)
    hn_OSPtf <- format(hn_OSPtf, big.mark = ",", decimal.mark = ".", nsmall = 0, scientific = FALSE)
    hn_actNo <- nrow(latest_data)
    hn_actNo <- format(hn_actNo, big.mark = ",", decimal.mark = ".", scientific = FALSE, nsmall = 0)
    
    if(nrow(arrears_latest) == 0){
        
        hn_ptf <- paste("GHN:无风险贷款", "贷款余额", hn_OSPtf,"活跃账户数", hn_actNo)
        
    }else {
        hn_PARValue <- format(hunan.ptf[[2]], big.mark = ",", decimal.mark = ".", scientific = FALSE, nsmall = 0)
        par1 <- hunan.ptf[[2]]/(hunan.ptf[[1]]+hunan.ptf[[2]])
        par1 <- sprintf("%.1f %%", 100*par1)
        hn_ptf <- paste("GHN:风险贷款额度", hn_PARValue, "风险贷款比例PAR1+", par1, "贷款余额", hn_OSPtf,
                        "活跃账户数", hn_actNo)
        
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
	
   ## Export the data to variable. 
   
    output_hn <- data.frame()
	hn_txt <- "吉首 hunan"
    
    if(exists("new_output")){
        output_hn <- rbind(output_hn, new_output)
		hn_txt <- paste(hn_txt, "新增逾期",nrow(new_output),"笔",nrow(new_output),"new loans in arrears" ,sep=" ")
    }
    
    if(exists("closed_output")){
        output_hn <- rbind(output_hn, closed_output)
		hn_txt <- paste(hn_txt,"逾期减少",nrow(closed_output),"笔",nrow(closed_output),"loans back to good standing",sep=" ")
    }
    
    if(exists("repaid_output")){
        output_hn <- rbind(output_hn, repaid_output)
		hn_txt <- paste(hn_txt,"逾期还款",nrow(repaid_output),"笔","collected repayment from",nrow(repaid_output),"loans",sep=" ")
    }
	
	addDataFrame(output_hn, sheet3, startRow=1, startColumn=1, row.names = FALSE)
    }
    print(hn_ptf)
    
	##Describe findings
    saveWorkbook(wb, file_dest)
    
	if(exists("cf_txt")){
	    print(cf_txt)
	}
    if(exists("cq_txt")){
        print(cq_txt)
    }
    if(exists("hn_txt")){
        print(hn_txt)
    }
    
    print("祝好，丽洋 Regards, Liyang")

}