--Change maturityExp date at line 81 
---change scoredate to year/month of scoring at line 1019-- Last run Dec 24, 2015 for Nov 30, 2015 data
Use China_AMC
go

select * into Month00 from tempTotal_Financial where MonthNo=0 
go

select * into Month01 from tempTotal_Financial where MonthNo=1
go

select * into Month02 from tempTotal_Financial where MonthNo=2
go
select * into Month03 from tempTotal_Financial where MonthNo=3 
go

select * into Month04 from tempTotal_Financial where MonthNo=4 
go

select * into Month05 from tempTotal_Financial where MonthNo=5
go
select * into Month06 from tempTotal_Financial where MonthNo=6 
go
select * into Month07 from tempTotal_Financial where MonthNo=7
go

select * into Month08 from tempTotal_Financial where MonthNo=8 
go

select * into Month09 from tempTotal_Financial where MonthNo=9
go

select * into Month10 from tempTotal_Financial where MonthNo=10 
go

select * into Month11 from tempTotal_Financial where MonthNo=11 
go

select * into Month12 from tempTotal_Financial where MonthNo=12
go

select * into Month13 from tempTotal_Financial where MonthNo=13 
go

select * into Month14 from tempTotal_Financial where MonthNo=14
go

select * into Month15 from tempTotal_Financial where MonthNo=15 
go

select * into Month16 from tempTotal_Financial where MonthNo=16
go

select * into Month17 from tempTotal_Financial where MonthNo=17 
go

select * into Month18 from tempTotal_Financial where MonthNo=18 
go

Update Month00 set MAXDPD = DPD where MAXDPD is null
Update Month01 set MAXDPD = DPD where MAXDPD is null
Update Month02 set MAXDPD = DPD where MAXDPD is null
Update Month03 set MAXDPD = DPD where MAXDPD is null
Update Month04 set MAXDPD = DPD where MAXDPD is null
Update Month05 set MAXDPD = DPD where MAXDPD is null
Update Month06 set MAXDPD = DPD where MAXDPD is null
Update Month07 set MAXDPD = DPD where MAXDPD is null
Update Month08 set MAXDPD = DPD where MAXDPD is null
Update Month09 set MAXDPD = DPD where MAXDPD is null
Update Month10 set MAXDPD = DPD where MAXDPD is null
Update Month11 set MAXDPD = DPD where MAXDPD is null
Update Month12 set MAXDPD = DPD where MAXDPD is null
Update Month13 set MAXDPD = DPD where MAXDPD is null
Update Month14 set MAXDPD = DPD where MAXDPD is null
Update Month15 set MAXDPD = DPD where MAXDPD is null
Update Month16 set MAXDPD = DPD where MAXDPD is null
Update Month17 set MAXDPD = DPD where MAXDPD is null
Update Month18 set MAXDPD = DPD where MAXDPD is null
go

select * into Temp_Maturing from Month00 where (MaturityExp < '01/01/2016 12:00:00 AM' OR Balance/LoanAmt < 0.3) --Change maturityExp datemm/dd/yy
go 

Execute sp_RENAME 'Temp_Maturing.Loancycle', 'LoanSeries00' , 'COLUMN'
Execute sp_RENAME 'Temp_Maturing.Loanterm', 'Terms00' , 'COLUMN'
Execute sp_RENAME 'Temp_Maturing.DPD', 'DaysPastDue00' , 'COLUMN'
Execute sp_RENAME 'Temp_Maturing.MAXDPD', 'MAXDPD00' , 'COLUMN'
Execute sp_RENAME 'Temp_Maturing.Balance', 'OutBal00' , 'COLUMN'
go

Alter table Temp_Maturing add MAXDPD01 int,terms01 int , Outbal01 money ,DaysPastDue01 int,LoanSeries01 int , MAXDPD02 int ,terms02 int , Outbal02 money,DaysPastDue02 int,LoanSeries02  int, MAXDPD03 int ,terms03 int, Outbal03 money ,DaysPastDue03 int,LoanSeries03  int, MAXDPD04 int,terms04 int, Outbal04 money,DaysPastDue04 int,LoanSeries04  int, MAXDPD05 money,terms05 int, Outbal05 money,DaysPastDue05 int,LoanSeries05  int, MAXDPD06 money,terms06 int, Outbal06 money,DaysPastDue06 int,LoanSeries06  int, MAXDPD07 int,terms07 int, Outbal07 money,DaysPastDue07 int,LoanSeries07  int, MAXDPD08 money,terms08 int, Outbal08 money,DaysPastDue08 int,LoanSeries08 int, MAXDPD09 int,terms09 int, Outbal09 money,DaysPastDue09 int,LoanSeries09 int, MAXDPD10 int,terms10 int, Outbal10 money,DaysPastDue10 int,LoanSeries10 int, MAXDPD11 int,terms11 int, Outbal11 money,DaysPastDue11 int,LoanSeries11 int, MAXDPD12 int,terms12 int, Outbal12 money,DaysPastDue12 int,LoanSeries12 int 
go

update Temp_Maturing set terms01= A.LoanTerm,Outbal01=A.Balance,DaysPastDue01=A.DPD,LoanSeries01=A.LoanCycle, MAXDPD01=A.MAXDPD From Month01 A, Temp_Maturing B
where B.ClientID=A.ClientID 
go

update Temp_Maturing set terms02= A.LoanTerm,Outbal02=A.Balance,DaysPastDue02=A.DPD,LoanSeries02=A.LoanCycle, MAXDPD02=A.MAXDPD From Month02 A, Temp_Maturing B
where (B.ClientID=A.ClientID  ) 
go

update Temp_Maturing set terms03= A.LoanTerm,Outbal03=A.Balance,DaysPastDue03=A.DPD,LoanSeries03=A.LoanCycle, MAXDPD03=A.MAXDPD From Month03 A, Temp_Maturing B
where (B.ClientID=A.ClientID  ) 
go

update Temp_Maturing set terms04= A.LoanTerm,Outbal04=A.Balance,DaysPastDue04=A.DPD,LoanSeries04=A.LoanCycle, MAXDPD04=A.MAXDPD From Month04 A, Temp_Maturing B
where (B.ClientID=A.ClientID  ) 
go

update Temp_Maturing set terms05= A.LoanTerm,Outbal05=A.Balance,DaysPastDue05=A.DPD,LoanSeries05=A.LoanCycle, MAXDPD05=A.MAXDPD From Month05 A, Temp_Maturing B
where (B.ClientID=A.ClientID  )
go

update Temp_Maturing set terms06= A.LoanTerm,Outbal06=A.Balance,DaysPastDue06=A.DPD,LoanSeries06=A.LoanCycle, MAXDPD06=A.MAXDPD From Month06 A, Temp_Maturing B
where (B.ClientID=A.ClientID  ) 
go

update Temp_Maturing set terms07= A.LoanTerm,Outbal07=A.Balance,DaysPastDue07=A.DPD,LoanSeries07=A.LoanCycle, MAXDPD07=A.MAXDPD From Month07 A, Temp_Maturing B
where (B.ClientID=A.ClientID  )
go

update Temp_Maturing set terms08= A.LoanTerm,Outbal08=A.Balance,DaysPastDue08=A.DPD,LoanSeries08=A.LoanCycle, MAXDPD08=A.MAXDPD From Month08 A, Temp_Maturing B
where (B.ClientID=A.ClientID  )
go

update Temp_Maturing set terms09= A.LoanTerm,Outbal09=A.Balance,DaysPastDue09=A.DPD,LoanSeries09=A.LoanCycle, MAXDPD09=A.MAXDPD From Month09 A, Temp_Maturing B
where (B.ClientID=A.ClientID  )
go

update Temp_Maturing set terms10= A.LoanTerm,Outbal10=A.Balance,DaysPastDue10=A.DPD,LoanSeries10=A.LoanCycle, MAXDPD10=A.MAXDPD From Month10 A, Temp_Maturing B
where (B.ClientID=A.ClientID   )
go

update Temp_Maturing set terms11= A.LoanTerm,Outbal11=A.Balance,DaysPastDue11=A.DPD,LoanSeries11=A.LoanCycle, MAXDPD11=A.MAXDPD From Month11 A, Temp_Maturing B
where (B.ClientID=A.ClientID  )
go

update Temp_Maturing set terms12= A.LoanTerm,Outbal12=A.Balance,DaysPastDue12=A.DPD,LoanSeries12=A.LoanCycle, MAXDPD12=A.MAXDPD From Month12 A, Temp_Maturing B
where (B.ClientID=A.ClientID   )
go

Update Temp_Maturing set DaysPastDue00=-99 where DaysPastDue00 is NULL
Update Temp_Maturing set DaysPastDue01=-99 where DaysPastDue01 is NULL
Update Temp_Maturing set DaysPastDue02=-99 where DaysPastDue02 is NULL
Update Temp_Maturing set DaysPastDue03=-99 where DaysPastDue03 is NULL
Update Temp_Maturing set DaysPastDue04=-99 where DaysPastDue04 is NULL
Update Temp_Maturing set DaysPastDue05=-99 where DaysPastDue05 is NULL
Update Temp_Maturing set DaysPastDue06=-99 where DaysPastDue06 is NULL
Update Temp_Maturing set DaysPastDue07=-99 where DaysPastDue07 is NULL
Update Temp_Maturing set DaysPastDue08=-99 where DaysPastDue08 is NULL
Update Temp_Maturing set DaysPastDue09=-99 where DaysPastDue09 is NULL
Update Temp_Maturing set DaysPastDue10=-99 where DaysPastDue10 is NULL
Update Temp_Maturing set DaysPastDue11=-99 where DaysPastDue11 is NULL
Update Temp_Maturing set DaysPastDue12=-99 where DaysPastDue12 is NULL
go
Update Temp_Maturing set MAXDPD00=-99 where MAXDPD00 is NULL
Update Temp_Maturing set MAXDPD01=-99 where MAXDPD01 is NULL
Update Temp_Maturing set MAXDPD02=-99 where MAXDPD02 is NULL
Update Temp_Maturing set MAXDPD03=-99 where MAXDPD03 is NULL
Update Temp_Maturing set MAXDPD04=-99 where MAXDPD04 is NULL
Update Temp_Maturing set MAXDPD05=-99 where MAXDPD05 is NULL
Update Temp_Maturing set MAXDPD06=-99 where MAXDPD06 is NULL
Update Temp_Maturing set MAXDPD07=-99 where MAXDPD07 is NULL
Update Temp_Maturing set MAXDPD08=-99 where MAXDPD08 is NULL
Update Temp_Maturing set MAXDPD09=-99 where MAXDPD09 is NULL
Update Temp_Maturing set MAXDPD10=-99 where MAXDPD10 is NULL
Update Temp_Maturing set MAXDPD11=-99 where MAXDPD11 is NULL
Update Temp_Maturing set MAXDPD12=-99 where MAXDPD12 is NULL
go

Update Temp_Maturing set Outbal00=0 where Outbal00 is NULL
Update Temp_Maturing set Outbal01=0 where Outbal01 is NULL
Update Temp_Maturing set Outbal02=0 where Outbal02 is NULL
Update Temp_Maturing set Outbal03=0 where Outbal03 is NULL
Update Temp_Maturing set Outbal04=0 where Outbal04 is NULL
Update Temp_Maturing set Outbal05=0 where Outbal05 is NULL
Update Temp_Maturing set Outbal06=0 where Outbal06 is NULL
Update Temp_Maturing set Outbal07=0 where Outbal07 is NULL
Update Temp_Maturing set Outbal08=0 where Outbal08 is NULL
Update Temp_Maturing set Outbal09=0 where Outbal09 is NULL
Update Temp_Maturing set Outbal10=0 where Outbal10 is NULL
Update Temp_Maturing set Outbal11=0 where Outbal11 is NULL
Update Temp_Maturing set Outbal12=0 where Outbal12 is NULL
go

if object_id('Maturity_Report') is not null
drop table Maturity_Report
go

Select * Into Maturity_Report From Temp_Maturing Where LoanSeries00 > 0
go

Drop table Temp_Maturing 
go

Alter table Maturity_Report add Closed00 int, RiskTool nvarchar(20)
go

Update Maturity_Report set Closed00 = 0
Update Maturity_Report set RiskTool = 'MATURING CLIENTS'
go

---*** RESTING CLIENT**---	

Execute sp_RENAME 'Month01.Loancycle', 'LoanSeries00' , 'COLUMN'
Execute sp_RENAME 'Month01.LoanTerm', 'Terms00' , 'COLUMN'
Execute sp_RENAME 'Month01.DPD', 'DaysPastDue00' , 'COLUMN'
Execute sp_RENAME 'Month01.MAXDPD', 'MAXDPD00' , 'COLUMN'
Execute sp_RENAME 'Month01.Balance', 'OutBal00' , 'COLUMN'

Select * Into [Temp Closed 1] From Month01 Where ClientID not in (Select ClientID from tempTotal_Financial where MonthNo =0) 
go
Alter table [Temp Closed 1] add MAXDPD01 int,terms01 int , Outbal01 money ,DaysPastDue01 int,LoanSeries01 int , MAXDPD02 int ,terms02 int , Outbal02 money,DaysPastDue02 int,LoanSeries02  int, MAXDPD03 int ,terms03 int, Outbal03 money ,DaysPastDue03 int,LoanSeries03  int, MAXDPD04 int,terms04 int, Outbal04 money,DaysPastDue04 int,LoanSeries04  int, MAXDPD05 money,terms05 int, Outbal05 money,DaysPastDue05 int,LoanSeries05  int, MAXDPD06 money,terms06 int, Outbal06 money,DaysPastDue06 int,LoanSeries06  int, MAXDPD07 int,terms07 int, Outbal07 money,DaysPastDue07 int,LoanSeries07  int, MAXDPD08 money,terms08 int, Outbal08 money,DaysPastDue08 int,LoanSeries08 int, MAXDPD09 int,terms09 int, Outbal09 money,DaysPastDue09 int,LoanSeries09 int, MAXDPD10 int,terms10 int, Outbal10 money,DaysPastDue10 int,LoanSeries10 int, MAXDPD11 int,terms11 int, Outbal11 money,DaysPastDue11 int,LoanSeries11 int, MAXDPD12 int,terms12 int, Outbal12 money,DaysPastDue12 int,LoanSeries12 int 
go

update [Temp Closed 1] set Outbal01=A.Balance,DaysPastDue01=A.DPD,MAXDPD01=A.MAXDPD From Month02 A, [Temp Closed 1] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 1] set Outbal02=A.Balance,DaysPastDue02=A.DPD,MAXDPD02=A.MAXDPD From Month03 A, [Temp Closed 1] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 1] set Outbal03=A.Balance,DaysPastDue03=A.DPD,MAXDPD03=A.MAXDPD From Month04 A, [Temp Closed 1] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 1] set Outbal04=A.Balance,DaysPastDue04=A.DPD,MAXDPD04=A.MAXDPD From Month05 A, [Temp Closed 1] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 1] set Outbal05=A.Balance,DaysPastDue05=A.DPD,MAXDPD05=A.MAXDPD From Month06 A, [Temp Closed 1] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 1] set Outbal06=A.Balance,DaysPastDue06=A.DPD,MAXDPD06=A.MAXDPD From Month07 A, [Temp Closed 1] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 1] set Outbal07=A.Balance,DaysPastDue07=A.DPD,MAXDPD07=A.MAXDPD From Month08 A, [Temp Closed 1] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 1] set Outbal08=A.Balance,DaysPastDue08=A.DPD,MAXDPD08=A.MAXDPD From Month09 A, [Temp Closed 1] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 1] set Outbal09=A.Balance,DaysPastDue09=A.DPD,MAXDPD09=A.MAXDPD From Month10 A, [Temp Closed 1] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 1] set Outbal10=A.Balance,DaysPastDue10=A.DPD,MAXDPD10=A.MAXDPD From Month11 A, [Temp Closed 1] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 1] set Outbal11=A.Balance,DaysPastDue11=A.DPD,MAXDPD11=A.MAXDPD From Month12 A, [Temp Closed 1] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 1] set Outbal12=A.Balance,DaysPastDue12=A.DPD,MAXDPD12=A.MAXDPD From Month13 A, [Temp Closed 1] B where (B.ClientID=A.ClientID  ) 
go

Alter table [Temp Closed 1] add Closed00 int, RiskTool nvarchar(20)
go

Update [Temp Closed 1] set Closed00 = 1
go
----------------------------------------------------
Execute sp_RENAME 'Month02.Loancycle', 'LoanSeries00' , 'COLUMN'
Execute sp_RENAME 'Month02.LoanTerm', 'Terms00' , 'COLUMN'
Execute sp_RENAME 'Month02.DPD', 'DaysPastDue00' , 'COLUMN'
Execute sp_RENAME 'Month02.MAXDPD', 'MAXDPD00' , 'COLUMN'
Execute sp_RENAME 'Month02.Balance', 'OutBal00' , 'COLUMN'

Select * Into [Temp Closed 2] From Month02 Where ClientID not in (Select ClientID from tempTotal_Financial where MonthNo between 0 and 1) 
go
Alter table [Temp Closed 2] add MAXDPD01 int,terms01 int , Outbal01 money ,DaysPastDue01 int,LoanSeries01 int , MAXDPD02 int ,terms02 int , Outbal02 money,DaysPastDue02 int,LoanSeries02  int, MAXDPD03 int ,terms03 int, Outbal03 money ,DaysPastDue03 int,LoanSeries03  int, MAXDPD04 int,terms04 int, Outbal04 money,DaysPastDue04 int,LoanSeries04  int, MAXDPD05 money,terms05 int, Outbal05 money,DaysPastDue05 int,LoanSeries05  int, MAXDPD06 money,terms06 int, Outbal06 money,DaysPastDue06 int,LoanSeries06  int, MAXDPD07 int,terms07 int, Outbal07 money,DaysPastDue07 int,LoanSeries07  int, MAXDPD08 money,terms08 int, Outbal08 money,DaysPastDue08 int,LoanSeries08 int, MAXDPD09 int,terms09 int, Outbal09 money,DaysPastDue09 int,LoanSeries09 int, MAXDPD10 int,terms10 int, Outbal10 money,DaysPastDue10 int,LoanSeries10 int, MAXDPD11 int,terms11 int, Outbal11 money,DaysPastDue11 int,LoanSeries11 int, MAXDPD12 int,terms12 int, Outbal12 money,DaysPastDue12 int,LoanSeries12 int 
go

update [Temp Closed 2] set Outbal01=A.Balance,DaysPastDue01=A.DPD,MAXDPD01=A.MAXDPD From Month03 A, [Temp Closed 2] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 2] set Outbal02=A.Balance,DaysPastDue02=A.DPD,MAXDPD02=A.MAXDPD From Month04 A, [Temp Closed 2] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 2] set Outbal03=A.Balance,DaysPastDue03=A.DPD,MAXDPD03=A.MAXDPD From Month05 A, [Temp Closed 2] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 2] set Outbal04=A.Balance,DaysPastDue04=A.DPD,MAXDPD04=A.MAXDPD From Month06 A, [Temp Closed 2] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 2] set Outbal05=A.Balance,DaysPastDue05=A.DPD,MAXDPD05=A.MAXDPD From Month07 A, [Temp Closed 2] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 2] set Outbal06=A.Balance,DaysPastDue06=A.DPD,MAXDPD06=A.MAXDPD From Month08 A, [Temp Closed 2] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 2] set Outbal07=A.Balance,DaysPastDue07=A.DPD,MAXDPD07=A.MAXDPD From Month09 A, [Temp Closed 2] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 2] set Outbal08=A.Balance,DaysPastDue08=A.DPD,MAXDPD08=A.MAXDPD From Month10 A, [Temp Closed 2] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 2] set Outbal09=A.Balance,DaysPastDue09=A.DPD,MAXDPD09=A.MAXDPD From Month11 A, [Temp Closed 2] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 2] set Outbal10=A.Balance,DaysPastDue10=A.DPD,MAXDPD10=A.MAXDPD From Month12 A, [Temp Closed 2] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 2] set Outbal11=A.Balance,DaysPastDue11=A.DPD,MAXDPD11=A.MAXDPD From Month13 A, [Temp Closed 2] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 2] set Outbal12=A.Balance,DaysPastDue12=A.DPD,MAXDPD12=A.MAXDPD From Month14 A, [Temp Closed 2] B where (B.ClientID=A.ClientID  ) 
go
Alter table [Temp Closed 2] add Closed00 int, RiskTool nvarchar(20)
go

Update [Temp Closed 2] set Closed00 = 2
go

----------------------------------------------------
Execute sp_RENAME 'Month03.Loancycle', 'LoanSeries00' , 'COLUMN'
Execute sp_RENAME 'Month03.LoanTerm', 'Terms00' , 'COLUMN'
Execute sp_RENAME 'Month03.DPD', 'DaysPastDue00' , 'COLUMN'
Execute sp_RENAME 'Month03.MAXDPD', 'MAXDPD00' , 'COLUMN'
Execute sp_RENAME 'Month03.Balance', 'OutBal00' , 'COLUMN'

Select * Into [Temp Closed 3] From Month03 Where ClientID not in (Select ClientID from tempTotal_Financial where MonthNo between 0 and 2) 
go
Alter table [Temp Closed 3] add MAXDPD01 int,terms01 int , Outbal01 money ,DaysPastDue01 int,LoanSeries01 int , MAXDPD02 int ,terms02 int , Outbal02 money,DaysPastDue02 int,LoanSeries02  int, MAXDPD03 int ,terms03 int, Outbal03 money ,DaysPastDue03 int,LoanSeries03  int, MAXDPD04 int,terms04 int, Outbal04 money,DaysPastDue04 int,LoanSeries04  int, MAXDPD05 money,terms05 int, Outbal05 money,DaysPastDue05 int,LoanSeries05  int, MAXDPD06 money,terms06 int, Outbal06 money,DaysPastDue06 int,LoanSeries06  int, MAXDPD07 int,terms07 int, Outbal07 money,DaysPastDue07 int,LoanSeries07  int, MAXDPD08 money,terms08 int, Outbal08 money,DaysPastDue08 int,LoanSeries08 int, MAXDPD09 int,terms09 int, Outbal09 money,DaysPastDue09 int,LoanSeries09 int, MAXDPD10 int,terms10 int, Outbal10 money,DaysPastDue10 int,LoanSeries10 int, MAXDPD11 int,terms11 int, Outbal11 money,DaysPastDue11 int,LoanSeries11 int, MAXDPD12 int,terms12 int, Outbal12 money,DaysPastDue12 int,LoanSeries12 int 
go

update [Temp Closed 3] set Outbal01=A.Balance,DaysPastDue01=A.DPD,MAXDPD01=A.MAXDPD From Month04 A, [Temp Closed 3] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 3] set Outbal02=A.Balance,DaysPastDue02=A.DPD,MAXDPD02=A.MAXDPD From Month05 A, [Temp Closed 3] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 3] set Outbal03=A.Balance,DaysPastDue03=A.DPD,MAXDPD03=A.MAXDPD From Month06 A, [Temp Closed 3] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 3] set Outbal04=A.Balance,DaysPastDue04=A.DPD,MAXDPD04=A.MAXDPD From Month07 A, [Temp Closed 3] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 3] set Outbal05=A.Balance,DaysPastDue05=A.DPD,MAXDPD05=A.MAXDPD From Month08 A, [Temp Closed 3] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 3] set Outbal06=A.Balance,DaysPastDue06=A.DPD,MAXDPD06=A.MAXDPD From Month09 A, [Temp Closed 3] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 3] set Outbal07=A.Balance,DaysPastDue07=A.DPD,MAXDPD07=A.MAXDPD From Month10 A, [Temp Closed 3] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 3] set Outbal08=A.Balance,DaysPastDue08=A.DPD,MAXDPD08=A.MAXDPD From Month11 A,[Temp Closed 3] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 3] set Outbal09=A.Balance,DaysPastDue09=A.DPD,MAXDPD09=A.MAXDPD From Month12 A, [Temp Closed 3] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 3] set Outbal10=A.Balance,DaysPastDue10=A.DPD,MAXDPD10=A.MAXDPD From Month13 A, [Temp Closed 3] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 3] set Outbal11=A.Balance,DaysPastDue11=A.DPD,MAXDPD11=A.MAXDPD From Month14 A, [Temp Closed 3] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 3] set Outbal12=A.Balance,DaysPastDue12=A.DPD,MAXDPD12=A.MAXDPD From Month15 A, [Temp Closed 3] B where (B.ClientID=A.ClientID  ) 
go
Alter table [Temp Closed 3] add Closed00 int, RiskTool nvarchar(20)
go

Update [Temp Closed 3] set Closed00 = 3
go

---------------------------------------------
Execute sp_RENAME 'Month04.Loancycle', 'LoanSeries00' , 'COLUMN'
Execute sp_RENAME 'Month04.LoanTerm', 'Terms00' , 'COLUMN'
Execute sp_RENAME 'Month04.DPD', 'DaysPastDue00' , 'COLUMN'
Execute sp_RENAME 'Month04.MAXDPD', 'MAXDPD00' , 'COLUMN'
Execute sp_RENAME 'Month04.Balance', 'OutBal00' , 'COLUMN'

Select * Into [Temp Closed 4] From Month04 Where ClientID not in (Select ClientID from tempTotal_Financial where MonthNo between 0 and 3) 
go
Alter table [Temp Closed 4] add MAXDPD01 int,terms01 int , Outbal01 money ,DaysPastDue01 int,LoanSeries01 int , MAXDPD02 int ,terms02 int , Outbal02 money,DaysPastDue02 int,LoanSeries02  int, MAXDPD03 int ,terms03 int, Outbal03 money ,DaysPastDue03 int,LoanSeries03  int, MAXDPD04 int,terms04 int, Outbal04 money,DaysPastDue04 int,LoanSeries04  int, MAXDPD05 money,terms05 int, Outbal05 money,DaysPastDue05 int,LoanSeries05  int, MAXDPD06 money,terms06 int, Outbal06 money,DaysPastDue06 int,LoanSeries06  int, MAXDPD07 int,terms07 int, Outbal07 money,DaysPastDue07 int,LoanSeries07  int, MAXDPD08 money,terms08 int, Outbal08 money,DaysPastDue08 int,LoanSeries08 int, MAXDPD09 int,terms09 int, Outbal09 money,DaysPastDue09 int,LoanSeries09 int, MAXDPD10 int,terms10 int, Outbal10 money,DaysPastDue10 int,LoanSeries10 int, MAXDPD11 int,terms11 int, Outbal11 money,DaysPastDue11 int,LoanSeries11 int, MAXDPD12 int,terms12 int, Outbal12 money,DaysPastDue12 int,LoanSeries12 int 
go

update [Temp Closed 4] set Outbal01=A.Balance,DaysPastDue01=A.DPD,MAXDPD01=A.MAXDPD From Month05 A, [Temp Closed 4] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 4] set Outbal02=A.Balance,DaysPastDue02=A.DPD,MAXDPD02=A.MAXDPD From Month06 A, [Temp Closed 4] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 4] set Outbal03=A.Balance,DaysPastDue03=A.DPD,MAXDPD03=A.MAXDPD From Month07 A, [Temp Closed 4] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 4] set Outbal04=A.Balance,DaysPastDue04=A.DPD,MAXDPD04=A.MAXDPD From Month08 A, [Temp Closed 4] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 4] set Outbal05=A.Balance,DaysPastDue05=A.DPD,MAXDPD05=A.MAXDPD From Month09 A, [Temp Closed 4] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 4] set Outbal06=A.Balance,DaysPastDue06=A.DPD,MAXDPD06=A.MAXDPD From Month10 A, [Temp Closed 4] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 4] set Outbal07=A.Balance,DaysPastDue07=A.DPD,MAXDPD07=A.MAXDPD From Month11 A, [Temp Closed 4] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 4] set Outbal08=A.Balance,DaysPastDue08=A.DPD,MAXDPD08=A.MAXDPD From Month12 A, [Temp Closed 4] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 4] set Outbal09=A.Balance,DaysPastDue09=A.DPD,MAXDPD09=A.MAXDPD From Month13 A, [Temp Closed 4] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 4] set Outbal10=A.Balance,DaysPastDue10=A.DPD,MAXDPD10=A.MAXDPD From Month14 A, [Temp Closed 4] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 4] set Outbal11=A.Balance,DaysPastDue11=A.DPD,MAXDPD11=A.MAXDPD From Month15 A, [Temp Closed 4] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 4] set Outbal12=A.Balance,DaysPastDue12=A.DPD,MAXDPD12=A.MAXDPD From Month16 A, [Temp Closed 4] B where (B.ClientID=A.ClientID  ) 
go
Alter table [Temp Closed 4] add Closed00 int, RiskTool nvarchar(20)
go

Update [Temp Closed 4] set Closed00 = 4
go

---------------------------------------------
Execute sp_RENAME 'Month05.Loancycle', 'LoanSeries00' , 'COLUMN'
Execute sp_RENAME 'Month05.LoanTerm', 'Terms00' , 'COLUMN'
Execute sp_RENAME 'Month05.DPD', 'DaysPastDue00' , 'COLUMN'
Execute sp_RENAME 'Month05.MAXDPD', 'MAXDPD00' , 'COLUMN'
Execute sp_RENAME 'Month05.Balance', 'OutBal00' , 'COLUMN'

Select * Into [Temp Closed 5] From Month05 Where ClientID not in (Select ClientID from tempTotal_Financial where MonthNo between 0 and 4) 
go
Alter table [Temp Closed 5] add MAXDPD01 int,terms01 int , Outbal01 money ,DaysPastDue01 int,LoanSeries01 int , MAXDPD02 int ,terms02 int , Outbal02 money,DaysPastDue02 int,LoanSeries02  int, MAXDPD03 int ,terms03 int, Outbal03 money ,DaysPastDue03 int,LoanSeries03  int, MAXDPD04 int,terms04 int, Outbal04 money,DaysPastDue04 int,LoanSeries04  int, MAXDPD05 money,terms05 int, Outbal05 money,DaysPastDue05 int,LoanSeries05  int, MAXDPD06 money,terms06 int, Outbal06 money,DaysPastDue06 int,LoanSeries06  int, MAXDPD07 int,terms07 int, Outbal07 money,DaysPastDue07 int,LoanSeries07  int, MAXDPD08 money,terms08 int, Outbal08 money,DaysPastDue08 int,LoanSeries08 int, MAXDPD09 int,terms09 int, Outbal09 money,DaysPastDue09 int,LoanSeries09 int, MAXDPD10 int,terms10 int, Outbal10 money,DaysPastDue10 int,LoanSeries10 int, MAXDPD11 int,terms11 int, Outbal11 money,DaysPastDue11 int,LoanSeries11 int, MAXDPD12 int,terms12 int, Outbal12 money,DaysPastDue12 int,LoanSeries12 int 
go

update [Temp Closed 5] set Outbal01=A.Balance,DaysPastDue01=A.DPD,MAXDPD01=A.MAXDPD From Month06 A, [Temp Closed 5] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 5] set Outbal02=A.Balance,DaysPastDue02=A.DPD,MAXDPD02=A.MAXDPD From Month07 A, [Temp Closed 5] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 5] set Outbal03=A.Balance,DaysPastDue03=A.DPD,MAXDPD03=A.MAXDPD From Month08 A, [Temp Closed 5] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 5] set Outbal04=A.Balance,DaysPastDue04=A.DPD,MAXDPD04=A.MAXDPD From Month09 A, [Temp Closed 5] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 5] set Outbal05=A.Balance,DaysPastDue05=A.DPD,MAXDPD05=A.MAXDPD From Month10 A, [Temp Closed 5] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 5] set Outbal06=A.Balance,DaysPastDue06=A.DPD,MAXDPD06=A.MAXDPD From Month11 A, [Temp Closed 5] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 5] set Outbal07=A.Balance,DaysPastDue07=A.DPD,MAXDPD07=A.MAXDPD From Month12 A, [Temp Closed 5] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 5] set Outbal08=A.Balance,DaysPastDue08=A.DPD,MAXDPD08=A.MAXDPD From Month13 A, [Temp Closed 5] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 5] set Outbal09=A.Balance,DaysPastDue09=A.DPD,MAXDPD09=A.MAXDPD From Month14 A, [Temp Closed 5] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 5] set Outbal10=A.Balance,DaysPastDue10=A.DPD,MAXDPD10=A.MAXDPD From Month15 A, [Temp Closed 5] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 5] set Outbal11=A.Balance,DaysPastDue11=A.DPD,MAXDPD11=A.MAXDPD From Month16 A, [Temp Closed 5] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 5] set Outbal12=A.Balance,DaysPastDue12=A.DPD,MAXDPD12=A.MAXDPD From Month17 A, [Temp Closed 5] B where (B.ClientID=A.ClientID  ) 
go
Alter table [Temp Closed 5] add Closed00 int, RiskTool nvarchar(20)
go

Update [Temp Closed 5] set Closed00 = 5
go

-----------------------
Execute sp_RENAME 'Month06.Loancycle', 'LoanSeries00' , 'COLUMN'
Execute sp_RENAME 'Month06.LoanTerm', 'Terms00' , 'COLUMN'
Execute sp_RENAME 'Month06.DPD', 'DaysPastDue00' , 'COLUMN'
Execute sp_RENAME 'Month06.MAXDPD', 'MAXDPD00' , 'COLUMN'
Execute sp_RENAME 'Month06.Balance', 'OutBal00' , 'COLUMN'

Select * Into [Temp Closed 6] From Month06 Where ClientID not in (Select ClientID from tempTotal_Financial where MonthNo between 0 and 5) 
go
Alter table [Temp Closed 6] add MAXDPD01 int,terms01 int , Outbal01 money ,DaysPastDue01 int,LoanSeries01 int , MAXDPD02 int ,terms02 int , Outbal02 money,DaysPastDue02 int,LoanSeries02  int, MAXDPD03 int ,terms03 int, Outbal03 money ,DaysPastDue03 int,LoanSeries03  int, MAXDPD04 int,terms04 int, Outbal04 money,DaysPastDue04 int,LoanSeries04  int, MAXDPD05 money,terms05 int, Outbal05 money,DaysPastDue05 int,LoanSeries05  int, MAXDPD06 money,terms06 int, Outbal06 money,DaysPastDue06 int,LoanSeries06  int, MAXDPD07 int,terms07 int, Outbal07 money,DaysPastDue07 int,LoanSeries07  int, MAXDPD08 money,terms08 int, Outbal08 money,DaysPastDue08 int,LoanSeries08 int, MAXDPD09 int,terms09 int, Outbal09 money,DaysPastDue09 int,LoanSeries09 int, MAXDPD10 int,terms10 int, Outbal10 money,DaysPastDue10 int,LoanSeries10 int, MAXDPD11 int,terms11 int, Outbal11 money,DaysPastDue11 int,LoanSeries11 int, MAXDPD12 int,terms12 int, Outbal12 money,DaysPastDue12 int,LoanSeries12 int 
go

update [Temp Closed 6] set Outbal01=A.Balance,DaysPastDue01=A.DPD,MAXDPD01=A.MAXDPD From Month07 A, [Temp Closed 6] B where (B.ClientID=A.ClientID  ) 
go

update [Temp Closed 6] set Outbal02=A.Balance,DaysPastDue02=A.DPD,MAXDPD02=A.MAXDPD From Month08 A, [Temp Closed 6] B where (B.ClientID=A.ClientID) 
go

update [Temp Closed 6] set Outbal03=A.Balance,DaysPastDue03=A.DPD,MAXDPD03=A.MAXDPD From Month09 A, [Temp Closed 6] B where (B.ClientID=A.ClientID) 
go

update [Temp Closed 6] set Outbal04=A.Balance,DaysPastDue04=A.DPD,MAXDPD04=A.MAXDPD From Month10 A, [Temp Closed 6] B where (B.ClientID=A.ClientID) 
go

update [Temp Closed 6] set Outbal05=A.Balance,DaysPastDue05=A.DPD,MAXDPD05=A.MAXDPD From Month11 A, [Temp Closed 6] B where (B.ClientID=A.ClientID) 
go

update [Temp Closed 6] set Outbal06=A.Balance,DaysPastDue06=A.DPD,MAXDPD06=A.MAXDPD From Month12 A, [Temp Closed 6] B where (B.ClientID=A.ClientID) 
go

update [Temp Closed 6] set Outbal07=A.Balance,DaysPastDue07=A.DPD,MAXDPD07=A.MAXDPD From Month13 A, [Temp Closed 6] B where (B.ClientID=A.ClientID) 
go

update [Temp Closed 6] set Outbal08=A.Balance,DaysPastDue08=A.DPD,MAXDPD08=A.MAXDPD From Month14 A, [Temp Closed 6] B where (B.ClientID=A.ClientID) 
go

update [Temp Closed 6] set Outbal09=A.Balance,DaysPastDue09=A.DPD,MAXDPD09=A.MAXDPD From Month15 A, [Temp Closed 6] B where (B.ClientID=A.ClientID) 
go

update [Temp Closed 6] set Outbal10=A.Balance,DaysPastDue10=A.DPD,MAXDPD10=A.MAXDPD From Month16 A, [Temp Closed 6] B where (B.ClientID=A.ClientID) 
go

update [Temp Closed 6] set Outbal11=A.Balance,DaysPastDue11=A.DPD,MAXDPD11=A.MAXDPD From Month17 A, [Temp Closed 6] B where (B.ClientID=A.ClientID) 
go

update [Temp Closed 6] set Outbal12=A.Balance,DaysPastDue12=A.DPD,MAXDPD12=A.MAXDPD From Month18 A, [Temp Closed 6] B where (B.ClientID=A.ClientID) 
go
Alter table [Temp Closed 6] add Closed00 int, RiskTool nvarchar(20)
go

Update [Temp Closed 6] set Closed00 = 6
go

-----------------------

Select * into [Closed Client Report]  from [Temp Closed 1] union select * from [Temp Closed 2] union select * from [Temp Closed 3] union select * from [Temp Closed 4] union select * from [Temp Closed 5] union select * from [Temp Closed 6]
go

Update [Closed Client Report] set RiskTool = 'Closed Clients'
go

If object_ID('tempTotal_Clients') is not null
drop table tempTotal_Clients
go

Select * into tempTotal_Clients from Maturity_Report union select * from [Closed Client Report]
go

Execute sp_RENAME 'tempTotal_Clients.EMI', 'Instal' , 'COLUMN'
go

alter table tempTotal_Clients alter column ClientName nvarchar (100)

Update tempTotal_Clients set DaysPastDue00=-99 where DaysPastDue00 is NULL
Update tempTotal_Clients set DaysPastDue01=-99 where DaysPastDue01 is NULL
Update tempTotal_Clients set DaysPastDue02=-99 where DaysPastDue02 is NULL
Update tempTotal_Clients set DaysPastDue03=-99 where DaysPastDue03 is NULL
Update tempTotal_Clients set DaysPastDue04=-99 where DaysPastDue04 is NULL
Update tempTotal_Clients set DaysPastDue05=-99 where DaysPastDue05 is NULL
Update tempTotal_Clients set DaysPastDue06=-99 where DaysPastDue06 is NULL
Update tempTotal_Clients set DaysPastDue07=-99 where DaysPastDue07 is NULL
Update tempTotal_Clients set DaysPastDue08=-99 where DaysPastDue08 is NULL
Update tempTotal_Clients set DaysPastDue09=-99 where DaysPastDue09 is NULL
Update tempTotal_Clients set DaysPastDue10=-99 where DaysPastDue10 is NULL
Update tempTotal_Clients set DaysPastDue11=-99 where DaysPastDue11 is NULL
Update tempTotal_Clients set DaysPastDue12=-99 where DaysPastDue12 is NULL
go

Update tempTotal_Clients set MAXDPD00=-99 where MAXDPD00 is NULL
Update tempTotal_Clients set MAXDPD01=-99 where MAXDPD01 is NULL
Update tempTotal_Clients set MAXDPD02=-99 where MAXDPD02 is NULL
Update tempTotal_Clients set MAXDPD03=-99 where MAXDPD03 is NULL
Update tempTotal_Clients set MAXDPD04=-99 where MAXDPD04 is NULL
Update tempTotal_Clients set MAXDPD05=-99 where MAXDPD05 is NULL
Update tempTotal_Clients set MAXDPD06=-99 where MAXDPD06 is NULL
Update tempTotal_Clients set MAXDPD07=-99 where MAXDPD07 is NULL
Update tempTotal_Clients set MAXDPD08=-99 where MAXDPD08 is NULL
Update tempTotal_Clients set MAXDPD09=-99 where MAXDPD09 is NULL
Update tempTotal_Clients set MAXDPD10=-99 where MAXDPD10 is NULL
Update tempTotal_Clients set MAXDPD11=-99 where MAXDPD11 is NULL
Update tempTotal_Clients set MAXDPD12=-99 where MAXDPD12 is NULL
go

Update tempTotal_Clients set OutBal00=0 where OutBal00 is NULL
Update tempTotal_Clients set OutBal01=0 where OutBal01 is NULL
Update tempTotal_Clients set OutBal02=0 where OutBal02 is NULL
Update tempTotal_Clients set OutBal03=0 where OutBal03 is NULL
Update tempTotal_Clients set OutBal04=0 where OutBal04 is NULL
Update tempTotal_Clients set OutBal05=0 where OutBal05 is NULL
Update tempTotal_Clients set OutBal06=0 where OutBal06 is NULL
Update tempTotal_Clients set OutBal07=0 where OutBal07 is NULL
Update tempTotal_Clients set OutBal08=0 where OutBal08 is NULL
Update tempTotal_Clients set OutBal09=0 where OutBal09 is NULL
Update tempTotal_Clients set OutBal10=0 where OutBal10 is NULL
Update tempTotal_Clients set OutBal11=0 where OutBal11 is NULL
Update tempTotal_Clients set OutBal12=0 where OutBal12 is NULL
go

Alter table tempTotal_Clients add is00 int, is01 int, is02 int, is03 int, is04 int, is05 int, is06 int, is07 int, is08 int, is09 int, is10 int, is11 int, is12 int, dpd00 int,dpd01 int,dpd02 int,dpd03 int,dpd04 int,dpd05 int,dpd06 int,dpd07 int,dpd08 int,dpd09 int,dpd10 int,dpd11 int,dpd12 int,MaxDPD3Mo int, MaxDPD6Mo int,MaxDPD12Mo int,Is3Mo int, Is6Mo int,Is12Mo int,AvgDays3Mo float, AvgDays6Mo float,AvgDays12Mo float, RatioDaysLate float,MonthsClient int,  InfoOK int, ScAvgDays6Mo float,ScRatioDaysLate float, ScMonthsClient float, ScMaxDPD3Mo int,  TotalScore money, Strategy varchar(8), Process varchar(25), EMI_FACTOR money, EMI Money, IncreaseAmount money, IncreaseEMI money, IncreaseTerm int, isM00 int, isM01 int,isM02 int,isM03 int,isM04 int,isM05 int,isM06 int,isM07 int,isM08 int,isM09 int,isM10 int,isM11 int,isM12 int,Mdpd00 int,Mdpd01 int, Mdpd02 int, Mdpd03 int, Mdpd04 int, Mdpd05 int, Mdpd06 int, Mdpd07 int, Mdpd08 int, Mdpd09 int, Mdpd10 int,Mdpd11 int, Mdpd12 int,ILL00 money,ILL10 money,ILL01 money,ILL02 money,ILL03 money,ILL04 money,ILL05 money,ILL06 money,ILL07 money,ILL08 money,ILL09 money,ILL11 money,ILL12 money,NoIllLate money,ScNoIllLate money,ScTimeClosed int,MaxBalance money,Delinquent int,ScoreDate int
go

Update tempTotal_Clients set is00=1 where DaysPastDue00<>-99
Update tempTotal_Clients set is01=1 where DaysPastDue01<>-99
Update tempTotal_Clients set is02=1 where DaysPastDue02<>-99
Update tempTotal_Clients set is03=1 where DaysPastDue03<>-99
Update tempTotal_Clients set is04=1 where DaysPastDue04<>-99
Update tempTotal_Clients set is05=1 where DaysPastDue05<>-99
Update tempTotal_Clients set is06=1 where DaysPastDue06<>-99
Update tempTotal_Clients set is07=1 where DaysPastDue07<>-99
Update tempTotal_Clients set is08=1 where DaysPastDue08<>-99
Update tempTotal_Clients set is09=1 where DaysPastDue09<>-99
Update tempTotal_Clients set is10=1 where DaysPastDue10<>-99
Update tempTotal_Clients set is11=1 where DaysPastDue11<>-99
Update tempTotal_Clients set is12=1 where DaysPastDue12<>-99
go

Update tempTotal_Clients set dpd00=DaysPastDue00 where DaysPastDue00<>-99
Update tempTotal_Clients set dpd01=DaysPastDue01 where DaysPastDue01<>-99
Update tempTotal_Clients set dpd02=DaysPastDue02 where DaysPastDue02<>-99
Update tempTotal_Clients set dpd03=DaysPastDue03 where DaysPastDue03<>-99
Update tempTotal_Clients set dpd04=DaysPastDue04 where DaysPastDue04<>-99
Update tempTotal_Clients set dpd05=DaysPastDue05 where DaysPastDue05<>-99
Update tempTotal_Clients set dpd06=DaysPastDue06 where DaysPastDue06<>-99
Update tempTotal_Clients set dpd07=DaysPastDue07 where DaysPastDue07<>-99
Update tempTotal_Clients set dpd08=DaysPastDue08 where DaysPastDue08<>-99
Update tempTotal_Clients set dpd09=DaysPastDue09 where DaysPastDue09<>-99
Update tempTotal_Clients set dpd10=DaysPastDue10 where DaysPastDue10<>-99
Update tempTotal_Clients set dpd11=DaysPastDue11 where DaysPastDue11<>-99
Update tempTotal_Clients set dpd12=DaysPastDue12 where DaysPastDue12<>-99
go

Update tempTotal_Clients set isM00=1 where MAXDPD00<>-99
Update tempTotal_Clients set isM01=1 where MAXDPD01<>-99
Update tempTotal_Clients set isM02=1 where MAXDPD02<>-99
Update tempTotal_Clients set isM03=1 where MAXDPD03<>-99
Update tempTotal_Clients set isM04=1 where MAXDPD04<>-99
Update tempTotal_Clients set isM05=1 where MAXDPD05<>-99
Update tempTotal_Clients set isM06=1 where MAXDPD06<>-99
Update tempTotal_Clients set isM07=1 where MAXDPD07<>-99
Update tempTotal_Clients set isM08=1 where MAXDPD08<>-99
Update tempTotal_Clients set isM09=1 where MAXDPD09<>-99
Update tempTotal_Clients set isM10=1 where MAXDPD10<>-99
Update tempTotal_Clients set isM11=1 where MAXDPD11<>-99
Update tempTotal_Clients set isM12=1 where MAXDPD12<>-99
go

Update tempTotal_Clients set Mdpd00=MAXDPD00 where MAXDPD00<>-99
Update tempTotal_Clients set Mdpd01=MAXDPD01 where MAXDPD01<>-99
Update tempTotal_Clients set Mdpd02=MAXDPD02 where MAXDPD02<>-99
Update tempTotal_Clients set Mdpd03=MAXDPD03 where MAXDPD03<>-99
Update tempTotal_Clients set Mdpd04=MAXDPD04 where MAXDPD04<>-99
Update tempTotal_Clients set Mdpd05=MAXDPD05 where MAXDPD05<>-99
Update tempTotal_Clients set Mdpd06=MAXDPD06 where MAXDPD06<>-99
Update tempTotal_Clients set Mdpd07=MAXDPD07 where MAXDPD07<>-99
Update tempTotal_Clients set Mdpd08=MAXDPD08 where MAXDPD08<>-99
Update tempTotal_Clients set Mdpd09=MAXDPD09 where MAXDPD09<>-99
Update tempTotal_Clients set Mdpd10=MAXDPD10 where MAXDPD10<>-99
Update tempTotal_Clients set Mdpd11=MAXDPD11 where MAXDPD11<>-99
Update tempTotal_Clients set Mdpd12=MAXDPD12 where MAXDPD12<>-99
go

Update tempTotal_Clients set ILL00=1 where MAXDPD00 > 0
Update tempTotal_Clients set ILL01=1 where MAXDPD01 > 0
Update tempTotal_Clients set ILL02=1 where MAXDPD02 > 0
Update tempTotal_Clients set ILL03=1 where MAXDPD03 > 0
Update tempTotal_Clients set ILL04=1 where MAXDPD04 > 0
Update tempTotal_Clients set ILL05=1 where MAXDPD05 > 0
Update tempTotal_Clients set ILL06=1 where MAXDPD06 > 0
Update tempTotal_Clients set ILL07=1 where MAXDPD07 > 0
Update tempTotal_Clients set ILL08=1 where MAXDPD08 > 0
Update tempTotal_Clients set ILL09=1 where MAXDPD09 > 0
Update tempTotal_Clients set ILL10=1 where MAXDPD10 > 0
Update tempTotal_Clients set ILL11=1 where MAXDPD11 > 0
Update tempTotal_Clients set ILL12=1 where MAXDPD12 > 0
go

Update tempTotal_Clients set ILL00=0 where ILL00 is NULL
Update tempTotal_Clients set ILL01=0 where ILL01 is NULL
Update tempTotal_Clients set ILL02=0 where ILL02 is NULL
Update tempTotal_Clients set ILL03=0 where ILL03 is NULL
Update tempTotal_Clients set ILL04=0 where ILL04 is NULL
Update tempTotal_Clients set ILL05=0 where ILL05 is NULL
Update tempTotal_Clients set ILL06=0 where ILL06 is NULL
Update tempTotal_Clients set ILL07=0 where ILL07 is NULL
Update tempTotal_Clients set ILL08=0 where ILL08 is NULL
Update tempTotal_Clients set ILL09=0 where ILL09 is NULL
Update tempTotal_Clients set ILL10=0 where ILL10 is NULL
Update tempTotal_Clients set ILL11=0 where ILL11 is NULL
Update tempTotal_Clients set ILL12=0 where ILL12 is NULL
go

Update tempTotal_Clients set NoIllLate=ILL00 + ILL01 + ILL02 + ILL03 + ILL04 + ILL05+ILL06+ILL07+ILL08+ILL09+ILL10+ILL11+ILL12
go

Update tempTotal_Clients set is00=0 where is00 is NULL
Update tempTotal_Clients set is01=0 where is01 is NULL
Update tempTotal_Clients set is02=0 where is02 is NULL
Update tempTotal_Clients set is03=0 where is03 is NULL
Update tempTotal_Clients set is04=0 where is04 is NULL
Update tempTotal_Clients set is05=0 where is05 is NULL
Update tempTotal_Clients set is06=0 where is06 is NULL
Update tempTotal_Clients set is07=0 where is07 is NULL
Update tempTotal_Clients set is08=0 where is08 is NULL
Update tempTotal_Clients set is09=0 where is09 is NULL
Update tempTotal_Clients set is10=0 where is10 is NULL
Update tempTotal_Clients set is11=0 where is11 is NULL
Update tempTotal_Clients set is12=0 where is12 is NULL
go

Update tempTotal_Clients set dpd00=0 where dpd00 is NULL
Update tempTotal_Clients set dpd01=0 where dpd01 is NULL
Update tempTotal_Clients set dpd02=0 where dpd02 is NULL
Update tempTotal_Clients set dpd03=0 where dpd03 is NULL
Update tempTotal_Clients set dpd04=0 where dpd04 is NULL
Update tempTotal_Clients set dpd05=0 where dpd05 is NULL
Update tempTotal_Clients set dpd06=0 where dpd06 is NULL
Update tempTotal_Clients set dpd07=0 where dpd07 is NULL
Update tempTotal_Clients set dpd08=0 where dpd08 is NULL
Update tempTotal_Clients set dpd09=0 where dpd09 is NULL
Update tempTotal_Clients set dpd10=0 where dpd10 is NULL
Update tempTotal_Clients set dpd11=0 where dpd11 is NULL
Update tempTotal_Clients set dpd12=0 where dpd12 is NULL
go

Update tempTotal_Clients set Mdpd00=0 where Mdpd00 is NULL
Update tempTotal_Clients set Mdpd01=0 where Mdpd01 is NULL
Update tempTotal_Clients set Mdpd02=0 where Mdpd02 is NULL
Update tempTotal_Clients set Mdpd03=0 where Mdpd03 is NULL
Update tempTotal_Clients set Mdpd04=0 where Mdpd04 is NULL
Update tempTotal_Clients set Mdpd05=0 where Mdpd05 is NULL
Update tempTotal_Clients set Mdpd06=0 where Mdpd06 is NULL
Update tempTotal_Clients set Mdpd07=0 where Mdpd07 is NULL
Update tempTotal_Clients set Mdpd08=0 where Mdpd08 is NULL
Update tempTotal_Clients set Mdpd09=0 where Mdpd09 is NULL
Update tempTotal_Clients set Mdpd10=0 where Mdpd10 is NULL
Update tempTotal_Clients set Mdpd11=0 where Mdpd11 is NULL
Update tempTotal_Clients set Mdpd12=0 where Mdpd12 is NULL
go

Update tempTotal_Clients set isM00=0 where isM00 is NULL
Update tempTotal_Clients set isM01=0 where isM01 is NULL
Update tempTotal_Clients set isM02=0 where isM02 is NULL
Update tempTotal_Clients set isM03=0 where isM03 is NULL
Update tempTotal_Clients set isM04=0 where isM04 is NULL
Update tempTotal_Clients set isM05=0 where isM05 is NULL
Update tempTotal_Clients set isM06=0 where isM06 is NULL
Update tempTotal_Clients set isM07=0 where isM07 is NULL
Update tempTotal_Clients set isM08=0 where isM08 is NULL
Update tempTotal_Clients set isM09=0 where isM09 is NULL
Update tempTotal_Clients set isM10=0 where isM10 is NULL
Update tempTotal_Clients set isM11=0 where isM11 is NULL
Update tempTotal_Clients set isM12=0 where isM12 is NULL
go

Update tempTotal_Clients set MAXDPD00=0 where MAXDPD00 is NULL
Update tempTotal_Clients set MAXDPD01=0 where MAXDPD01 is NULL
Update tempTotal_Clients set MAXDPD02=0 where MAXDPD02 is NULL
Update tempTotal_Clients set MAXDPD03=0 where MAXDPD03 is NULL
Update tempTotal_Clients set MAXDPD04=0 where MAXDPD04 is NULL
Update tempTotal_Clients set MAXDPD05=0 where MAXDPD05 is NULL
Update tempTotal_Clients set MAXDPD06=0 where MAXDPD06 is NULL
Update tempTotal_Clients set MAXDPD07=0 where MAXDPD07 is NULL
Update tempTotal_Clients set MAXDPD08=0 where MAXDPD08 is NULL
Update tempTotal_Clients set MAXDPD09=0 where MAXDPD09 is NULL
Update tempTotal_Clients set MAXDPD10=0 where MAXDPD10 is NULL
Update tempTotal_Clients set MAXDPD11=0 where MAXDPD11 is NULL
Update tempTotal_Clients set MAXDPD12=0 where MAXDPD12 is NULL
go

Update tempTotal_Clients set Terms00=0 where Terms00 is NULL
Update tempTotal_Clients set Loanseries00=0 where Loanseries00 is NULL
Update tempTotal_Clients set Delinquent = 1 where DaysPastDue00 > 10
Update tempTotal_Clients set Delinquent = 0 where DaysPastDue00 <= 10
go

Update tempTotal_Clients set MaxDPD3Mo= Case When MDPD00 > MDPD01 And MDPD00 > MDPD02 Then MDPD00 When MDPD01 > MDPD02 Then MDPD01 Else MDPD02 End From tempTotal_Clients 
go

Update tempTotal_Clients set MaxDPD6Mo= case 
when 
MDPD00 > MDPD01 and
MDPD00 > MDPD02 and
MDPD00 > MDPD03 and
MDPD00 > MDPD04 and
MDPD00 > MDPD05 then MDPD00 
when 
MDPD01 > MDPD02 and
MDPD01 > MDPD03 and
MDPD01 > MDPD04 and
MDPD01 > MDPD05 then MDPD01
when
MDPD02 > MDPD03 and
MDPD02 > MDPD04 and
MDPD02 > MDPD05 then MDPD02
when
MDPD03 > MDPD04 and
MDPD03 > MDPD05 then MDPD03
when
MDPD04 > MDPD05 then MDPD04
Else
MDPD05 End From tempTotal_Clients
go

Update tempTotal_Clients set MaxDPD12Mo= case
when
MDPD00 > MDPD01 and
MDPD00 > MDPD02 and
MDPD00 > MDPD03 and
MDPD00 > MDPD04 and
MDPD00 > MDPD05 and
MDPD00 > MDPD06 and
MDPD00 > MDPD07 and
MDPD00 > MDPD08 and
MDPD00 > MDPD09 and
MDPD00 > MDPD10 and
MDPD00 > MDPD11 then MDPD00
when
MDPD01 > MDPD02 and
MDPD01 > MDPD03 and
MDPD01 > MDPD04 and
MDPD01 > MDPD05 and 
MDPD01 > MDPD06 and 
MDPD01 > MDPD07 and 
MDPD01 > MDPD08 and
MDPD01 > MDPD09 and 
MDPD01 > MDPD10 and 
MDPD01 > MDPD11 then MDPD01 
when
MDPD02 > MDPD03 and
MDPD02 > MDPD04 and
MDPD02 > MDPD05 and
MDPD02 > MDPD06 and
MDPD02 > MDPD07 and
MDPD02 > MDPD08 and
MDPD02 > MDPD09 and
MDPD02 > MDPD10 and
MDPD02 > MDPD11 then MDPD02
when
MDPD03 > MDPD04 and
MDPD03 > MDPD05 and
MDPD03 > MDPD06 and
MDPD03 > MDPD07 and
MDPD03 > MDPD08 and
MDPD03 > MDPD09 and
MDPD03 > MDPD10 and
MDPD03 > MDPD11 then MDPD03
when
MDPD04 > MDPD05 and
MDPD04 > MDPD06 and
MDPD04 > MDPD07 and
MDPD04 > MDPD08 and
MDPD04 > MDPD09 and
MDPD04 > MDPD10 and
MDPD04 > MDPD11 then MDPD04
when
MDPD05 > MDPD06 and
MDPD05 > MDPD07 and
MDPD05 > MDPD08 and
MDPD05 > MDPD09 and
MDPD05 > MDPD10 and
MDPD05 > MDPD11 then MDPD05
when
MDPD06 > MDPD07 and
MDPD06 > MDPD08 and
MDPD06 > MDPD09 and
MDPD06 > MDPD10 and
MDPD06 > MDPD11 then MDPD06
when
MDPD07 > MDPD08 and
MDPD07 > MDPD09 and
MDPD07 > MDPD10 and
MDPD07 > MDPD11 then MDPD07
when
MDPD08 > MDPD09 and
MDPD08 > MDPD10 and
MDPD08 > MDPD11 then MDPD08
when
MDPD09 > MDPD10 and
MDPD09 > MDPD11 then MDPD09
when
MDPD10 > MDPD11 then MDPD10
Else
MDPD11 End From tempTotal_Clients
go

Update tempTotal_Clients set Is3Mo=(isM00+isM01+isM02)
go
Update tempTotal_Clients set Is6Mo=(isM00+isM01+isM02+isM03+isM04+isM05)
go
Update tempTotal_Clients set Is12Mo=(isM00+isM01+isM02+isM03+isM04+isM05+isM06+isM07+isM08+isM09+isM10+isM11)
go

Update tempTotal_Clients set AvgDays3Mo=(MDPD00 + MDPD01 + MDPD02)/(Is3Mo)
go
Update tempTotal_Clients set AvgDays6Mo=(MDPD00 + MDPD01 + MDPD02 + MDPD03 + MDPD04 + MDPD05)/(Is6Mo) 
go
Update tempTotal_Clients set AvgDays12Mo=(MDPD00 + MDPD01 + MDPD02 + MDPD03 + MDPD04 + MDPD05 + MDPD06 + MDPD07 + MDPD08 + MDPD09 + MDPD10 + MDPD11)/(Is12Mo) 
go

Update tempTotal_Clients set RatioDaysLate = MaxDPD12Mo / (Is12Mo) 
go

Update tempTotal_Clients set MonthsClient=terms00-1+(LoanSeries00-1)*terms00 
go
Update tempTotal_Clients set InfoOK = is00+is01+is02+is03+is04+is05+ is06 + is07 + is08 + is09 + is10 + is11
go

Update tempTotal_Clients set ScAvgDays6Mo=100 where (AvgDays6Mo=0 and InfoOk>4)
Update tempTotal_Clients set ScAvgDays6Mo=0 where (AvgDays6Mo>=0.0000000001 and AvgDays6Mo<=1.5 and InfoOk>4)
Update tempTotal_Clients set ScAvgDays6Mo=-50 where (AvgDays6Mo>=1.5000000001 and AvgDays6Mo<=6 and InfoOk>4)
Update tempTotal_Clients set ScAvgDays6Mo=-100 where (AvgDays6Mo>=6.0000000001 and AvgDays6Mo<=10 and InfoOk>4)
Update tempTotal_Clients set ScAvgDays6Mo=-150 where (AvgDays6Mo>=10.0000000001 and InfoOk>4)
go

Update tempTotal_Clients set ScRatioDaysLate=100 where (RatioDaysLate = 0 and InfoOk>4)
Update tempTotal_Clients set ScRatioDaysLate=50 where (RatioDaysLate>=0.0000001 and RatioDaysLate<=0.6 and InfoOk>4)
Update tempTotal_Clients set ScRatioDaysLate=0 where (RatioDaysLate>=0.60000001 and RatioDaysLate<=1 and InfoOk>4)
Update tempTotal_Clients set ScRatioDaysLate=-50 where (RatioDaysLate>=1.0000001 and RatioDaysLate<=6 and InfoOk>4)
Update tempTotal_Clients set ScRatioDaysLate=-200 where (RatioDaysLate>=6.0000001 and InfoOk>4)
go


Update tempTotal_Clients set ScNoIllLate=200 where (NoIllLate=0 and InfoOk>4)
Update tempTotal_Clients set ScNoIllLate=100 where (NoIllLate=1 and InfoOk>4)
Update tempTotal_Clients set ScNoIllLate=0 where (NoIllLate>=2 and NoIllLate<=3 and InfoOk>4)
Update tempTotal_Clients set ScNoIllLate=-50 where (NoIllLate > 3 and NoIllLate<=5 and InfoOk>4)
Update tempTotal_Clients set ScNoIllLate=-200 where (NoIllLate > 5  and InfoOk>4)

Update tempTotal_Clients set ScMonthsClient=-1000 where MonthsClient<=-1 
Update tempTotal_Clients set ScMonthsClient=-150 where (MonthsClient>=0 and MonthsClient<=10)
Update tempTotal_Clients set ScMonthsClient=-100 where (MonthsClient>=10.0000000001 and MonthsClient<=15)
Update tempTotal_Clients set ScMonthsClient=0 where (MonthsClient>=15.0000000001 and MonthsClient<=24)
Update tempTotal_Clients set ScMonthsClient=50 where (MonthsClient>=24.0000000001 and MonthsClient<=40)
Update tempTotal_Clients set ScMonthsClient=150 where MonthsClient>=40.0000000001
go

Update tempTotal_Clients set ScMaxDPD3Mo=100 where (MaxDPD3Mo>=0 and MaxDPD3Mo<=2)
Update tempTotal_Clients set ScMaxDPD3Mo=0 where (MaxDPD3Mo>=2.0000000001 and MaxDPD3Mo<=4)
Update tempTotal_Clients set ScMaxDPD3Mo=-50 where (MaxDPD3Mo>=4.0000000001 and MaxDPD3Mo<=10)
Update tempTotal_Clients set ScMaxDPD3Mo=-150 where (MaxDPD3Mo>=10.0000000001 and MaxDPD3Mo<=32)
Update tempTotal_Clients set ScMaxDPD3Mo=-200 where MaxDPD3Mo>=32.0000000001
go

Update tempTotal_Clients set ScAvgDays6Mo=-1000 where ScAvgDays6Mo is NULL
Update tempTotal_Clients set ScRatioDaysLate=-1000 where ScRatioDaysLate is NULL
Update tempTotal_Clients set ScNoIllLate=-1000 where ScNoIllLate is NULL
Update tempTotal_Clients set ScMaxDPD3Mo =-1000 where ScMaxDPD3Mo is Null
go

Update tempTotal_Clients set ScTimeClosed = 0 where (Closed00 = 0 or Closed00 =3 or closed00 =4)
Update tempTotal_Clients set ScTimeClosed = 50 where (Closed00 = 1 or closed00 =2)
Update tempTotal_Clients set ScTimeClosed = -50 where (Closed00 = 5 or closed00 =6)
go

Update tempTotal_Clients set TotalScore= ScAvgDays6Mo + ScRatioDaysLate + ScMonthsClient + ScMaxDPD3Mo + ScTimeClosed+  ScNoIllLate
go

Update tempTotal_Clients set EMI_FACTOR= ((power(1.03,Terms00))*0.03)/((power(1.03,terms00))-1)
go
Update tempTotal_Clients set EMI=round(EMI_FACTOR*LoanAmt,0)
go

Update tempTotal_Clients set Strategy='D' where (TotalScore<=-1000)
Update tempTotal_Clients set Strategy='C' where (TotalScore>=-999 and TotalScore<=-151)
Update tempTotal_Clients set Strategy='B' where (TotalScore>=-150 and TotalScore<=399)
Update tempTotal_Clients set Strategy='A' where (TotalScore>=400 and TotalScore<=499)
Update tempTotal_Clients set Strategy='AA' where (TotalScore>=500)
go

Update tempTotal_Clients set Process='5-Incomplete information' where (TotalScore<=-1000)
Update tempTotal_Clients set Process='4-Reject' where (TotalScore>=-999 and TotalScore<=-151)
Update tempTotal_Clients set Process='3-Full' where (TotalScore>=-150 and TotalScore<=399)
Update tempTotal_Clients set Process='2-Rapid' where (TotalScore>=400 and TotalScore<=499)
Update tempTotal_Clients set Process='1-Preapproved' where (TotalScore>=500)
go

Update tempTotal_Clients set IncreaseAmount=1 where (TotalScore<=-1000)
Update tempTotal_Clients set IncreaseAmount=0 where (TotalScore>=-999 and TotalScore<=-151)
Update tempTotal_Clients set IncreaseAmount=1.00 where (TotalScore>=-150 and TotalScore<=399)
Update tempTotal_Clients set IncreaseAmount=1.3 where (TotalScore>=400 and TotalScore<=499)
Update tempTotal_Clients set IncreaseAmount=1.5 where (TotalScore>=500)
go

Update tempTotal_Clients set IncreaseEMI=1 where (TotalScore<=-1000)
Update tempTotal_Clients set IncreaseEMI=0 where (TotalScore>=-999 and TotalScore<=-151)
Update tempTotal_Clients set IncreaseEMI=1.00 where (TotalScore>=-150 and TotalScore<=399)
Update tempTotal_Clients set IncreaseEMI=1.15 where (TotalScore>=400 and TotalScore<=499)
Update tempTotal_Clients set IncreaseEMI=1.25 where (TotalScore>=500)
go

Update tempTotal_Clients set IncreaseTerm=0 where (TotalScore<=-1000)
Update tempTotal_Clients set IncreaseTerm=0 where (TotalScore>=-999 and TotalScore<=-151)
Update tempTotal_Clients set IncreaseTerm=0 where (TotalScore>=-150 and TotalScore<=399)
Update tempTotal_Clients set IncreaseTerm=3 where (TotalScore>=400 and TotalScore<=499)
Update tempTotal_Clients set IncreaseTerm=3 where (TotalScore>=500)
go

Update tempTotal_Clients Set MaxBalance=(Loanamt*IncreaseAmount)
go

drop table Month00,Month01,Month02,Month03,Month04,Month05,Month06,Month07,Month08,Month09,Month10,Month11,Month12,Month13,Month14,Month15,Month16,Month17,Month18,[Temp Closed 1],[Temp Closed 2],[Temp Closed 3],[Temp Closed 4],[Temp Closed 5],[Temp Closed 6]
go

If Object_ID('Total_Clients') is not null
Drop table Total_Clients
go

Select Lnnote as LoanID,ClientID, ClientName,Branch, LO,Closed00 as MonthClosed,RiskTool,EMI as Prev_EMI,Terms00 as Prev_Term,LoanAmt as Prev_LoanAmt, TotalScore,Process, Reco_EMI=round((EMI*IncreaseEMI),-1),Reco_Term=(Terms00+IncreaseTerm),Reco_LoanAmt=round(((EMI*IncreaseEMI * (((power(1.03,terms00)-1))/(((power(1.03,Terms00))*0.03)))/100)*100),-2),MaxBalance as MaxLoan,ScAvgDays6Mo,ScRatioDaysLate,ScMonthsClient,ScMaxDPD3Mo,ScTimeClosed,ScNoIllLate 
into Total_Clients from tempTotal_Clients 
go

If Object_ID('Total_Clients_CNAA') is not null
Drop table Total_Clients_CNAA
go
select * into Total_Clients_CNAA from Total_Clients where Branch='CNAA'
go

If Object_ID('Total_Clients_CNAB') is not null
Drop table Total_Clients_CNAB
go

select * into Total_Clients_CNAB from Total_Clients where Branch='CNAB'
go

IF Object_ID ('Total_Clients_CNAC') is not null
Drop table Total_Clients_CNAC
go
select * into Total_Clients_CNAC from Total_Clients where Branch='CNAC'
go

Update tempTotal_Clients set ScoreDate = 201511  ---change scoredate to year/month of scoring
go

Declare @Max int
Declare @CMax int
Declare @Mscoredate int

Select @Mscoredate = scoredate from tempTotal_Clients
Delete from consolidated_renewal where scoredate = @Mscoredate

Select @Max = MAX(monthobs) from tempTotal_Clients 
Select @cMax = MAX(monthobs) from Consolidated_Renewal

IF @Max > @CMax or @CMax is null
	Begin
		Insert Into Consolidated_Renewal
		Select Lnnote as LoanID,ClientID, Branch, LO,Closed00 as MonthClosed,LoanSeries00,DaysPastDue00,RiskTool,EMI as Prev_EMI,Terms00 as Prev_Term,LoanAmt as Prev_LoanAmt, TotalScore,Strategy,Process, Reco_EMI=round((EMI*IncreaseEMI),-1),Reco_Term=(Terms00+IncreaseTerm),Reco_LoanAmt=round(((EMI*IncreaseEMI * (((power(1.03,terms00)-1))/(((power(1.03,Terms00))*0.03)))/100)*100),-2),MaxBalance as MaxLoan,RatioDaysLate,ScAvgDays6Mo,ScRatioDaysLate,ScMonthsClient,ScMaxDPD3Mo,ScTimeClosed,ScNoIllLate,Delinquent,Monthobs,ScoreDate,MaxDPD00,MaxDPD01,MaxDPD02,MaxDPD03,MaxDPD04,MaxDPD05,MaxDPD06,MaxDPD07,MaxDPD08,MaxDPD09,MaxDPD10,MaxDPD11,Is3Mo,Is6Mo,Is12Mo,MonthsClient,AvgDays6Mo,NoIllLate,MaxDPD3Mo,ILL00,ILL01,ILL02,ILL03,ILL04,ILL05,ILL06,ILL07,ILL08,ILL09,ILL10,ILL11,InfoOK from tempTotal_Clients 
	End
go

Drop Table Maturity_Report,[Closed Client Report],tempTotal_Clients
go