portfoliotest = function(current_date){
## site for data    
location <- c("chifeng","wanzhou","jishou")
## Column names
classes <- c(rep("character",11), rep("numeric",13), rep("Date", 2),"numeric")

for(i in 1:3){
    site <- location[i]
    latest_pattern <- paste0("Loan_Accounts-",site,"-liyang.qin-",current_date)
    latest_file <- list.files("D:/360MoveData/Documents/Arrears/Mambu/", recursive = TRUE, all.files =TRUE, pattern = latest_pattern)
    latest_file <- paste0("D:/360MoveData/Documents/Arrears/Mambu/", latest_file)
    latest_data <- read.xlsx2(latest_file, sheetIndex =1, header = TRUE, colClasses = classes, encoding = "urf-8")
    product.list <- read.csv("D:/360MoveData/Documents/Arrears/Credit_Risk/ProductList.csv")   
    
    ## Group the data
    product <- latest_data %>% group_by(Loan.Name) %>% summarise(OS.Portfolio = sum(Principal.Balance))
    product.PAR <- latest_data %>% filter(Account.State == "In Arrears")
    if(nrow(product.PAR)==0){
        product <- product %>% left_join(product.list)
        productDis <- aggregate(OS.Portfolio ~ Subtype, data = product, sum)
        ## format numbers
        productDis <- productDis %>% mutate(percent = sprintf("%.1f %%", 100*OS.Portfolio / sum(productDis$OS.Portfolio)))
        productDis <- productDis %>% mutate(OS.Portfolio = format(OS.Portfolio, big.mark = ","))
        # branch analysis
        branch <- latest_data %>% group_by(Branch) %>% summarise(OS.Portfolio = sum(Principal.Balance))
        branch <- branch %>% mutate(OS.Portfolio=format(OS.Portfolio, big.mark = ","))
     
    }else{
    product.PAR<- product.PAR %>% group_by(Loan.Name) %>% summarise(PAR.Value = sum(Principal.Balance))
    product <- product %>% left_join(product.PAR) %>% left_join(product.list)
    productDis <- aggregate(OS.Portfolio ~ Subtype, data = product, sum)
    product.PAR <- aggregate(PAR.Value ~ Subtype, data = product, sum)
    product <- left_join(productDis, product.PAR)
    productDis <- product %>% mutate (In.Risk=PAR.Value/OS.Portfolio) %>% mutate(In.Risk= sprintf("%.1f %%", 100*In.Risk))
    ## format numbers
    productDis <- productDis %>% mutate(percent = sprintf("%.1f %%", 100*OS.Portfolio / sum(productDis$OS.Portfolio))) %>% mutate(OS.Portfolio = format(OS.Portfolio, big.mark = ","))
    productDis <- productDis %>% mutate(PAR.Value = format(PAR.Value, big.mark = ","))
    
    ## branch analysis
    branch <- latest_data %>% group_by(Branch) %>% summarise(OS.Portfolio = sum(Principal.Balance))
    branch.PAR <- latest_data %>% filter(Account.State == "In Arrears") %>% group_by(Branch) %>% summarise(PAR.Value = sum(Principal.Balance))
    branch <- left_join(branch, branch.PAR)
    branch <- branch %>% mutate(In.Risk=PAR.Value/OS.Portfolio) %>% mutate(In.Risk = sprintf("%.1f %%", 100*In.Risk)) 
    branch <- branch %>% mutate(OS.Portfolio=format(OS.Portfolio, big.mark = ","))%>% mutate(PAR.Value=format(PAR.Value, big.mark = ","))
    }
    
    print(productDis)
    print(branch)
    }

}