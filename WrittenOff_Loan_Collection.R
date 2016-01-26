wf_collection <- function(obs_date,pmt_date){
    # Load in data
    closed_pattern <- paste0("Loan_Accounts-chifeng-liyang.qin-", obs_date)
    closed_file <- list.files("D:/360MoveData/Documents/Arrears/Collection/", recursive =TRUE, all.files = TRUE, pattern = closed_pattern)
    closed_file <- paste0("D:/360MoveData/Documents/Arrears/Collection/", closed_file)
    pmt_pattern <- paste0("Transactions-chifeng-liyang.qin-", pmt_date)
    pmt_file <- list.files("D:/360MoveData/Documents/Arrears/Collection/", recursive = TRUE, all.files =TRUE, pattern = pmt_pattern)
    pmt_file <- paste0("D:/360MoveData/Documents/Arrears/Collection/", pmt_file)
    
    classes_closed <- c(rep("character",11), rep("numeric",13), rep("Date", 2))
    classes_pmt <- c("Date", rep("character",6), rep("numeric",6), rep("character", 2))
    closed_data <- read.xlsx2(closed_file,sheetIndex =1, header = TRUE, colClasses = classes_closed, encoding = "urf-8")
    pmt_data <- read.xlsx2(pmt_file, sheetIndex =1, header = TRUE, colClasses = classes_pmt, encoding = "urf-8")
 
    # Find payment record coming from closed account. These are repayment from written-off loans.
    # Output shoud be payment record of these write-off loans. 
    closed_act <- closed_data[,1]
    writeoff_collection_cf <- subset(pmt_data, Account.ID %in% closed_act)
    
    file_dest <- paste0("./Arrears/Result/Writtenoff_Account_Collection_until", obs_date ,".xlsx")
    wb <- createWorkbook()
    sheet1 <- createSheet(wb,sheetName = "GIM")
    sheet2 <- createSheet(wb,sheetName = "GCQ")
    sheet3 <- createSheet(wb,sheetName = "GHN")
    addDataFrame(writeoff_collection_cf, sheet1, startRow=1, startColumn=1, row.names = FALSE)
    saveWorkbook(wb, file_dest)
    }