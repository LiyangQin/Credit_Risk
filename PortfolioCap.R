portfoliotest = function(current_date){
## operation site name as shown in the file    
location <- c("chifeng","wanzhou","jishou","china")
## Column names
classes <- c(rep("character",11), rep("numeric",13), rep("Date", 2),"numeric")

for(i in 1:4){
    # load in the data
    site <- location[i]
    print(site)
    latest_pattern <- paste0("Loan_Accounts-",site,"-liyang.qin-",current_date)
    latest_file <- list.files("D:/360MoveData/Documents/Arrears/Mambu/", recursive = TRUE, all.files =TRUE, pattern = latest_pattern)
    latest_file <- paste0("D:/360MoveData/Documents/Arrears/Mambu/", latest_file)
    latest_data <- read.xlsx2(latest_file, sheetIndex =1, header = TRUE, colClasses = classes, encoding = "urf-8")
    # import the product list
    product.list <- read.csv("D:/360MoveData/Documents/Arrears/Credit_Risk/ProductList.csv")   
    
    # Group the data by product
    ## create OS.Portfolio by adding up OS Principal by product
    product <- latest_data %>% group_by(Loan.Name) %>% summarise(OS.Portfolio = sum(Principal.Balance))
    product.PAR <- latest_data %>% filter(Account.State == "In Arrears")
    ## when there's no delinquency account, only transform the data format
    if(nrow(product.PAR)==0){
        ## using left join to asign subtypes to each Loan.Name, then summarize by subtype
        product <- product %>% left_join(product.list)
        productDis <- aggregate(OS.Portfolio ~ Subtype, data = product, sum)
        ## format numbers
        productDis <- productDis %>% mutate(percent = sprintf("%.1f %%", 100*OS.Portfolio / sum(productDis$OS.Portfolio)))
        productDis <- productDis %>% mutate(OS.Portfolio = format(OS.Portfolio, big.mark = ","))
        # branch analysis
        if(site == "china"){
            branch <- latest_data %>% group_by(受理支行Branch) %>% summarise(OS.Portfolio = sum(Principal.Balance))
        }else{
        branch <-latest_data %>% group_by(Branch) %>% summarise(OS.Portfolio = sum(Principal.Balance))
        }
        # format numbers
        branch <- branch %>% mutate(OS.Portfolio=format(OS.Portfolio, big.mark = ","))
    }else{
    # Add in product.PAR value when there is delinquency account
    ## create PAR.Value by adding up OS principal by Loan.Name
    product.PAR<- product.PAR %>% group_by(Loan.Name) %>% summarise(PAR.Value = sum(Principal.Balance))
    ## combine three lists by Loan.Name, overall list / delinquency list / product list
    product <- product %>% left_join(product.PAR) %>% left_join(product.list)
    ## furthur group them by sub product
    productDis <- aggregate(OS.Portfolio ~ Subtype, data = product, sum)
    product.PAR <- aggregate(PAR.Value ~ Subtype, data = product, sum)
    product <- left_join(productDis, product.PAR)
    ## Add In.Risk which is PAR+1 in percentage
    productDis <- product %>% mutate (In.Risk=PAR.Value/OS.Portfolio) %>% mutate(In.Risk= sprintf("%.1f %%", 100*In.Risk))
    ## format numbers
    productDis <- productDis %>% mutate(percent = sprintf("%.1f %%", 100*OS.Portfolio / sum(productDis$OS.Portfolio))) %>% mutate(OS.Portfolio = format(OS.Portfolio, big.mark = ","))
    productDis <- productDis %>% mutate(PAR.Value = format(PAR.Value, big.mark = ","))
    
    ## branch analysis
    if(site == "china"){
        branch <- latest_data %>% group_by(受理支行Branch) %>% summarise(OS.Portfolio = sum(Principal.Balance))
        branch.PAR <- latest_data %>% filter(Account.State == "In Arrears") %>% group_by(受理支行Branch) %>% summarise(PAR.Value = sum(Principal.Balance))
        branch <- left_join(branch, branch.PAR)
        branch <- branch %>% mutate(In.Risk=PAR.Value/OS.Portfolio) %>% mutate(In.Risk = sprintf("%.1f %%", 100*In.Risk)) 
        branch <- branch %>% mutate(OS.Portfolio=format(OS.Portfolio, big.mark = ","))%>% mutate(PAR.Value=format(PAR.Value, big.mark = ","))
    }else{
    branch <- latest_data %>% group_by(Branch) %>% summarise(OS.Portfolio = sum(Principal.Balance))
    branch.PAR <- latest_data %>% filter(Account.State == "In Arrears") %>% group_by(Branch) %>% summarise(PAR.Value = sum(Principal.Balance))
    branch <- left_join(branch, branch.PAR)
    branch <- branch %>% mutate(In.Risk=PAR.Value/OS.Portfolio) %>% mutate(In.Risk = sprintf("%.1f %%", 100*In.Risk)) 
    branch <- branch %>% mutate(OS.Portfolio=format(OS.Portfolio, big.mark = ","))%>% mutate(PAR.Value=format(PAR.Value, big.mark = ","))
    }
    }
    print(productDis)
    print(branch)
    }

}