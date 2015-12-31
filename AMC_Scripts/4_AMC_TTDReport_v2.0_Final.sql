-----last run Dec 1, 2015 for Nov 30, 2015 data----

use China_AMC 
go

if OBJECT_ID('Temp_ScoreStability') is not null
Drop table Temp_ScoreStability

Select * Into Temp_ScoreStability from Consolidated_Renewal
go

Alter Table Temp_ScoreStability add Score_Monthno int null
go

declare @Rowc as int  
declare @count as int  
declare @min as int  
declare @max as int  
declare @Monthobs as int  
declare @counter as int  
declare @intCount as int  


select @Rowc = count(Scoredate), @count = COUNT(distinct(Scoredate)),@min = Min(Scoredate), @max = Max(Scoredate)
 from Temp_ScoreStability where Scoredate is not null

set @intCount = 1
set @counter = @count -1
set @Monthobs = @min


while (@intCount <= @Rowc) and (@max >= @Monthobs) 
 begin
  update Temp_ScoreStability set score_MonthNo = @counter  where  Scoredate =@Monthobs 
  
  if RIGHT(@Monthobs,2) <> 12
   begin
    set @Monthobs = (@Monthobs + 1)
   end
  else
   begin
    set @Monthobs = (@Monthobs + 89)  
   end   
   
   if @Monthobs in (select Scoredate from Temp_ScoreStability)
   begin
    set @intCount = @intCount +1
    set @counter = @counter - 1 
   end
   else
    set @counter = @counter 
  
 end
 go
 
 If OBJECT_ID('ScoreStability') is not null
 Drop Table ScoreStability
 
 Select * Into ScoreStability From Temp_ScoreStability where score_Monthno < 13
 go
 
 Alter Table ScoreStability add RangeScore int null
 go
 
 Update ScoreStability set RangeScore = 1 where TotalScore <= -230
 Update ScoreStability set RangeScore = 2 where TotalScore > -230 and TotalScore <= -200
 Update ScoreStability set RangeScore = 3 where TotalScore > -200 and TotalScore <=-150
 Update ScoreStability set RangeScore = 4 where TotalScore > -150 and TotalScore <= -50
 Update ScoreStability set RangeScore = 5 where TotalScore > -50 and TotalScore <= 80
 Update ScoreStability set RangeScore = 6 where TotalScore > 80 and TotalScore <= 150
 Update ScoreStability set RangeScore = 7 where TotalScore > 150 and TotalScore <= 250
 Update ScoreStability set RangeScore = 8 where TotalScore > 250 and TotalScore <= 300
 Update ScoreStability set RangeScore = 9 where TotalScore > 300 and TotalScore <= 350
 Update ScoreStability set RangeScore = 10 where TotalScore > 350
 go
 
 Drop Table Temp_ScoreStability 
 go
 
 If OBJECT_ID('Renewal') is not null
 Drop table Renewal 
  
 Select Lnnote,clientid,ClientName,Branch,prod,LoanTerm,LO,LoanAmt,Disbursement_Date,MaturityExp,MOB, MonthDisbursed,MatExp,LoanCycle, Monthterm, NewRenew, LnProd,MonthNo,MonthDisbNo  Into Renewal From tempTotal_Financial where MonthNo < 12 and loancycle >1 and MOB = 0 order by MonthDisbursed,ClientID 
 go
 
Alter table Renewal add MaxDPD00 int,MaxDPD01 int,MaxDPD02 int,MaxDPD03 int,MaxDPD04 int,MaxDPD05 int,MaxDPD06 int,MaxDPD07 int,MaxDPD08 int, MaxDPD09 int,MaxDPD10 int,MaxDPD11 int,Is3Mo int,Is6Mo int,Is12Mo int,MonthsClient int,AvgDays6Mo int,NoIllLate int,MaxDPD3Mo int,ILL00 int,ILL01 int,ILL02 int,ILL03 int,ILL04 int,ILL05 int,ILL06 int,ILL07 int,ILL08 int,ILL09 int,ILL10 int,ILL11 int,InfoOK int,LoanSeries00 int,MonthClosed int,Prev_Term int,ScTimeClosed float,RISKTOOL nvarchar(25),RatioDaysLate float,ScAvgDays6Mo float,ScRatioDaysLate float,ScMonthsClient float,ScMaxDPD3Mo float,ScNoIllLate float,TotalScore float,Strategy nvarchar(50),Process nvarchar(50),Delinquent float,Reco_Term int,Reco_EMI money,Reco_LoanAmt money,ScoreDate int,Score_Monthno int
go

Update Renewal set MaxDPD00 = B.MaxDPD00,MaxDPD01= B.MaxDPD01,MaxDPD02= B.MaxDPD02,MaxDPD03= B.MaxDPD03,MaxDPD04= B.MaxDPD04,MaxDPD05= B.MaxDPD05,MaxDPD06= B.MaxDPD06,MaxDPD07= B.MaxDPD07,MaxDPD08= B.MaxDPD08,MaxDPD09= B.MaxDPD09,MaxDPD10= B.MaxDPD10,MaxDPD11= B.MaxDPD11,Is3Mo=B.Is3Mo,Is6Mo=B.Is6Mo,Is12Mo=B.Is12Mo,MonthsClient=B.MonthsClient,AvgDays6Mo=B.AvgDays6Mo,NoIllLate=B.NoIllLate,MaxDPD3Mo=B.MaxDPD3Mo,ILL00=B.ILL00,ILL01=B.ILL01,ILL02=B.ILL02,ILL03=B.ILL03,ILL04=B.ILL04,ILL05=B.ILL05,ILL06=B.ILL06,ILL07=B.ILL07,ILL08=B.ILL08,ILL09=B.ILL09,ILL10=B.ILL10,ILL11=B.ILL11,InfoOK=B.InfoOK, LoanSeries00 = B.LoanSeries00, MonthClosed = B.monthclosed, Prev_Term = B.Prev_Term, ScTimeClosed = B.ScTimeClosed, RISKTOOL = B.RISKTOOL,RatioDaysLate = b.RatioDaysLate, ScAvgDays6Mo =B.ScAvgDays6Mo,ScRatioDaysLate = B.ScRatioDaysLate,ScMonthsClient = B.ScMonthsClient,ScMaxDPD3Mo =B.ScMaxDPD3Mo,ScNoIllLate =B.ScNoIllLate,TotalScore =B.TotalScore,Strategy =B.Strategy,Process =B.Process, Delinquent =B.Delinquent,Reco_Term =B.Reco_Term,Reco_EMI = B.Reco_EMI,Reco_LoanAmt = B.Reco_LoanAmt,ScoreDate =B.ScoreDate,Score_Monthno =B.score_monthno  From Renewal A,ScoreStability B 
Where A.MonthNo = 0 and b.score_Monthno = 1 and A.ClientID collate database_default= B.ClientID collate database_default
go

Update Renewal set MaxDPD00 = B.MaxDPD00,MaxDPD01= B.MaxDPD01,MaxDPD02= B.MaxDPD02,MaxDPD03= B.MaxDPD03,MaxDPD04= B.MaxDPD04,MaxDPD05= B.MaxDPD05,MaxDPD06= B.MaxDPD06,MaxDPD07= B.MaxDPD07,MaxDPD08= B.MaxDPD08,MaxDPD09= B.MaxDPD09,MaxDPD10= B.MaxDPD10,MaxDPD11= B.MaxDPD11,Is3Mo=B.Is3Mo,Is6Mo=B.Is6Mo,Is12Mo=B.Is12Mo,MonthsClient=B.MonthsClient,AvgDays6Mo=B.AvgDays6Mo,NoIllLate=B.NoIllLate,MaxDPD3Mo=B.MaxDPD3Mo,ILL00=B.ILL00,ILL01=B.ILL01,ILL02=B.ILL02,ILL03=B.ILL03,ILL04=B.ILL04,ILL05=B.ILL05,ILL06=B.ILL06,ILL07=B.ILL07,ILL08=B.ILL08,ILL09=B.ILL09,ILL10=B.ILL10,ILL11=B.ILL11,InfoOK=B.InfoOK,LoanSeries00 = B.LoanSeries00, MonthClosed = B.monthclosed, Prev_Term = B.Prev_Term, ScTimeClosed = B.ScTimeClosed, RISKTOOL = B.RISKTOOL,RatioDaysLate = b.RatioDaysLate, ScAvgDays6Mo =B.ScAvgDays6Mo,ScRatioDaysLate = B.ScRatioDaysLate,ScMonthsClient = B.ScMonthsClient,ScMaxDPD3Mo =B.ScMaxDPD3Mo,ScNoIllLate =B.ScNoIllLate,TotalScore =B.TotalScore,Strategy =B.Strategy,Process =B.Process, Delinquent =B.Delinquent,Reco_Term =B.Reco_Term,Reco_EMI = B.Reco_EMI,Reco_LoanAmt = B.Reco_LoanAmt,ScoreDate =B.ScoreDate,Score_Monthno =B.score_monthno  From Renewal A,ScoreStability B 
Where A.MonthNo = 1 and b.score_Monthno = 2 and A.ClientID collate database_default= B.ClientID collate database_default
go

Update Renewal set MaxDPD00 = B.MaxDPD00,MaxDPD01= B.MaxDPD01,MaxDPD02= B.MaxDPD02,MaxDPD03= B.MaxDPD03,MaxDPD04= B.MaxDPD04,MaxDPD05= B.MaxDPD05,MaxDPD06= B.MaxDPD06,MaxDPD07= B.MaxDPD07,MaxDPD08= B.MaxDPD08,MaxDPD09= B.MaxDPD09,MaxDPD10= B.MaxDPD10,MaxDPD11= B.MaxDPD11,Is3Mo=B.Is3Mo,Is6Mo=B.Is6Mo,Is12Mo=B.Is12Mo,MonthsClient=B.MonthsClient,AvgDays6Mo=B.AvgDays6Mo,NoIllLate=B.NoIllLate,MaxDPD3Mo=B.MaxDPD3Mo,ILL00=B.ILL00,ILL01=B.ILL01,ILL02=B.ILL02,ILL03=B.ILL03,ILL04=B.ILL04,ILL05=B.ILL05,ILL06=B.ILL06,ILL07=B.ILL07,ILL08=B.ILL08,ILL09=B.ILL09,ILL10=B.ILL10,ILL11=B.ILL11,InfoOK=B.InfoOK, LoanSeries00 = B.LoanSeries00, MonthClosed = B.monthclosed, Prev_Term = B.Prev_Term, ScTimeClosed = B.ScTimeClosed, RISKTOOL = B.RISKTOOL,RatioDaysLate = b.RatioDaysLate, ScAvgDays6Mo =B.ScAvgDays6Mo,ScRatioDaysLate = B.ScRatioDaysLate,ScMonthsClient = B.ScMonthsClient,ScMaxDPD3Mo =B.ScMaxDPD3Mo,ScNoIllLate =B.ScNoIllLate,TotalScore =B.TotalScore,Strategy =B.Strategy,Process =B.Process, Delinquent =B.Delinquent,Reco_Term =B.Reco_Term,Reco_EMI = B.Reco_EMI,Reco_LoanAmt = B.Reco_LoanAmt,ScoreDate =B.ScoreDate,Score_Monthno =B.score_monthno  From Renewal A,ScoreStability B 
Where A.MonthNo = 2 and b.score_Monthno = 3 and A.ClientID collate database_default= B.ClientID collate database_default
go

Update Renewal set MaxDPD00 = B.MaxDPD00,MaxDPD01= B.MaxDPD01,MaxDPD02= B.MaxDPD02,MaxDPD03= B.MaxDPD03,MaxDPD04= B.MaxDPD04,MaxDPD05= B.MaxDPD05,MaxDPD06= B.MaxDPD06,MaxDPD07= B.MaxDPD07,MaxDPD08= B.MaxDPD08,MaxDPD09= B.MaxDPD09,MaxDPD10= B.MaxDPD10,MaxDPD11= B.MaxDPD11,Is3Mo=B.Is3Mo,Is6Mo=B.Is6Mo,Is12Mo=B.Is12Mo,MonthsClient=B.MonthsClient,AvgDays6Mo=B.AvgDays6Mo,NoIllLate=B.NoIllLate,MaxDPD3Mo=B.MaxDPD3Mo,ILL00=B.ILL00,ILL01=B.ILL01,ILL02=B.ILL02,ILL03=B.ILL03,ILL04=B.ILL04,ILL05=B.ILL05,ILL06=B.ILL06,ILL07=B.ILL07,ILL08=B.ILL08,ILL09=B.ILL09,ILL10=B.ILL10,ILL11=B.ILL11,InfoOK=B.InfoOK, LoanSeries00 = B.LoanSeries00, MonthClosed = B.monthclosed, Prev_Term = B.Prev_Term, ScTimeClosed = B.ScTimeClosed, RISKTOOL = B.RISKTOOL,RatioDaysLate = b.RatioDaysLate, ScAvgDays6Mo =B.ScAvgDays6Mo,ScRatioDaysLate = B.ScRatioDaysLate,ScMonthsClient = B.ScMonthsClient,ScMaxDPD3Mo =B.ScMaxDPD3Mo,ScNoIllLate =B.ScNoIllLate,TotalScore =B.TotalScore,Strategy =B.Strategy,Process =B.Process, Delinquent =B.Delinquent,Reco_Term =B.Reco_Term,Reco_EMI = B.Reco_EMI,Reco_LoanAmt = B.Reco_LoanAmt,ScoreDate =B.ScoreDate,Score_Monthno =B.score_monthno  From Renewal A,ScoreStability B 
Where A.MonthNo = 3 and b.score_Monthno = 4 and A.ClientID collate database_default= B.ClientID collate database_default
go

Update Renewal set MaxDPD00 = B.MaxDPD00,MaxDPD01= B.MaxDPD01,MaxDPD02= B.MaxDPD02,MaxDPD03= B.MaxDPD03,MaxDPD04= B.MaxDPD04,MaxDPD05= B.MaxDPD05,MaxDPD06= B.MaxDPD06,MaxDPD07= B.MaxDPD07,MaxDPD08= B.MaxDPD08,MaxDPD09= B.MaxDPD09,MaxDPD10= B.MaxDPD10,MaxDPD11= B.MaxDPD11,Is3Mo=B.Is3Mo,Is6Mo=B.Is6Mo,Is12Mo=B.Is12Mo,MonthsClient=B.MonthsClient,AvgDays6Mo=B.AvgDays6Mo,NoIllLate=B.NoIllLate,MaxDPD3Mo=B.MaxDPD3Mo,ILL00=B.ILL00,ILL01=B.ILL01,ILL02=B.ILL02,ILL03=B.ILL03,ILL04=B.ILL04,ILL05=B.ILL05,ILL06=B.ILL06,ILL07=B.ILL07,ILL08=B.ILL08,ILL09=B.ILL09,ILL10=B.ILL10,ILL11=B.ILL11,InfoOK=B.InfoOK, LoanSeries00 = B.LoanSeries00, MonthClosed = B.monthclosed, Prev_Term = B.Prev_Term, ScTimeClosed = B.ScTimeClosed, RISKTOOL = B.RISKTOOL,RatioDaysLate = b.RatioDaysLate, ScAvgDays6Mo =B.ScAvgDays6Mo,ScRatioDaysLate = B.ScRatioDaysLate,ScMonthsClient = B.ScMonthsClient,ScMaxDPD3Mo =B.ScMaxDPD3Mo,ScNoIllLate =B.ScNoIllLate,TotalScore =B.TotalScore,Strategy =B.Strategy,Process =B.Process, Delinquent =B.Delinquent,Reco_Term =B.Reco_Term,Reco_EMI = B.Reco_EMI,Reco_LoanAmt = B.Reco_LoanAmt,ScoreDate =B.ScoreDate,Score_Monthno =B.score_monthno  From Renewal A,ScoreStability B 
Where A.MonthNo = 4 and b.score_Monthno = 5 and A.ClientID collate database_default= B.ClientID collate database_default
go

Update Renewal set MaxDPD00 = B.MaxDPD00,MaxDPD01= B.MaxDPD01,MaxDPD02= B.MaxDPD02,MaxDPD03= B.MaxDPD03,MaxDPD04= B.MaxDPD04,MaxDPD05= B.MaxDPD05,MaxDPD06= B.MaxDPD06,MaxDPD07= B.MaxDPD07,MaxDPD08= B.MaxDPD08,MaxDPD09= B.MaxDPD09,MaxDPD10= B.MaxDPD10,MaxDPD11= B.MaxDPD11,Is3Mo=B.Is3Mo,Is6Mo=B.Is6Mo,Is12Mo=B.Is12Mo,MonthsClient=B.MonthsClient,AvgDays6Mo=B.AvgDays6Mo,NoIllLate=B.NoIllLate,MaxDPD3Mo=B.MaxDPD3Mo,ILL00=B.ILL00,ILL01=B.ILL01,ILL02=B.ILL02,ILL03=B.ILL03,ILL04=B.ILL04,ILL05=B.ILL05,ILL06=B.ILL06,ILL07=B.ILL07,ILL08=B.ILL08,ILL09=B.ILL09,ILL10=B.ILL10,ILL11=B.ILL11,InfoOK=B.InfoOK, LoanSeries00 = B.LoanSeries00, MonthClosed = B.monthclosed, Prev_Term = B.Prev_Term, ScTimeClosed = B.ScTimeClosed, RISKTOOL = B.RISKTOOL,RatioDaysLate = b.RatioDaysLate, ScAvgDays6Mo =B.ScAvgDays6Mo,ScRatioDaysLate = B.ScRatioDaysLate,ScMonthsClient = B.ScMonthsClient,ScMaxDPD3Mo =B.ScMaxDPD3Mo,ScNoIllLate =B.ScNoIllLate,TotalScore =B.TotalScore,Strategy =B.Strategy,Process =B.Process, Delinquent =B.Delinquent,Reco_Term =B.Reco_Term,Reco_EMI = B.Reco_EMI,Reco_LoanAmt = B.Reco_LoanAmt,ScoreDate =B.ScoreDate,Score_Monthno =B.score_monthno  From Renewal A,ScoreStability B  
Where A.MonthNo = 5 and b.score_Monthno = 6 and A.ClientID collate database_default= B.ClientID collate database_default
go

Update Renewal set MaxDPD00 = B.MaxDPD00,MaxDPD01= B.MaxDPD01,MaxDPD02= B.MaxDPD02,MaxDPD03= B.MaxDPD03,MaxDPD04= B.MaxDPD04,MaxDPD05= B.MaxDPD05,MaxDPD06= B.MaxDPD06,MaxDPD07= B.MaxDPD07,MaxDPD08= B.MaxDPD08,MaxDPD09= B.MaxDPD09,MaxDPD10= B.MaxDPD10,MaxDPD11= B.MaxDPD11,Is3Mo=B.Is3Mo,Is6Mo=B.Is6Mo,Is12Mo=B.Is12Mo,MonthsClient=B.MonthsClient,AvgDays6Mo=B.AvgDays6Mo,NoIllLate=B.NoIllLate,MaxDPD3Mo=B.MaxDPD3Mo,ILL00=B.ILL00,ILL01=B.ILL01,ILL02=B.ILL02,ILL03=B.ILL03,ILL04=B.ILL04,ILL05=B.ILL05,ILL06=B.ILL06,ILL07=B.ILL07,ILL08=B.ILL08,ILL09=B.ILL09,ILL10=B.ILL10,ILL11=B.ILL11,InfoOK=B.InfoOK, LoanSeries00 = B.LoanSeries00, MonthClosed = B.monthclosed, Prev_Term = B.Prev_Term, ScTimeClosed = B.ScTimeClosed, RISKTOOL = B.RISKTOOL,RatioDaysLate = b.RatioDaysLate, ScAvgDays6Mo =B.ScAvgDays6Mo,ScRatioDaysLate = B.ScRatioDaysLate,ScMonthsClient = B.ScMonthsClient,ScMaxDPD3Mo =B.ScMaxDPD3Mo,ScNoIllLate =B.ScNoIllLate,TotalScore =B.TotalScore,Strategy =B.Strategy,Process =B.Process, Delinquent =B.Delinquent,Reco_Term =B.Reco_Term,Reco_EMI = B.Reco_EMI,Reco_LoanAmt = B.Reco_LoanAmt,ScoreDate =B.ScoreDate,Score_Monthno =B.score_monthno  From Renewal A,ScoreStability B 
Where A.MonthNo = 6 and b.score_Monthno = 7 and A.ClientID collate database_default= B.ClientID collate database_default
go

Update Renewal set MaxDPD00 = B.MaxDPD00,MaxDPD01= B.MaxDPD01,MaxDPD02= B.MaxDPD02,MaxDPD03= B.MaxDPD03,MaxDPD04= B.MaxDPD04,MaxDPD05= B.MaxDPD05,MaxDPD06= B.MaxDPD06,MaxDPD07= B.MaxDPD07,MaxDPD08= B.MaxDPD08,MaxDPD09= B.MaxDPD09,MaxDPD10= B.MaxDPD10,MaxDPD11= B.MaxDPD11,Is3Mo=B.Is3Mo,Is6Mo=B.Is6Mo,Is12Mo=B.Is12Mo,MonthsClient=B.MonthsClient,AvgDays6Mo=B.AvgDays6Mo,NoIllLate=B.NoIllLate,MaxDPD3Mo=B.MaxDPD3Mo,ILL00=B.ILL00,ILL01=B.ILL01,ILL02=B.ILL02,ILL03=B.ILL03,ILL04=B.ILL04,ILL05=B.ILL05,ILL06=B.ILL06,ILL07=B.ILL07,ILL08=B.ILL08,ILL09=B.ILL09,ILL10=B.ILL10,ILL11=B.ILL11,InfoOK=B.InfoOK, LoanSeries00 = B.LoanSeries00, MonthClosed = B.monthclosed, Prev_Term = B.Prev_Term, ScTimeClosed = B.ScTimeClosed, RISKTOOL = B.RISKTOOL,RatioDaysLate = b.RatioDaysLate, ScAvgDays6Mo =B.ScAvgDays6Mo,ScRatioDaysLate = B.ScRatioDaysLate,ScMonthsClient = B.ScMonthsClient,ScMaxDPD3Mo =B.ScMaxDPD3Mo,ScNoIllLate =B.ScNoIllLate,TotalScore =B.TotalScore,Strategy =B.Strategy,Process =B.Process, Delinquent =B.Delinquent,Reco_Term =B.Reco_Term,Reco_EMI = B.Reco_EMI,Reco_LoanAmt = B.Reco_LoanAmt,ScoreDate =B.ScoreDate,Score_Monthno =B.score_monthno  From Renewal A,ScoreStability B 
Where A.MonthNo = 7 and b.score_Monthno = 8 and A.ClientID collate database_default= B.ClientID collate database_default
go

Update Renewal set MaxDPD00 = B.MaxDPD00,MaxDPD01= B.MaxDPD01,MaxDPD02= B.MaxDPD02,MaxDPD03= B.MaxDPD03,MaxDPD04= B.MaxDPD04,MaxDPD05= B.MaxDPD05,MaxDPD06= B.MaxDPD06,MaxDPD07= B.MaxDPD07,MaxDPD08= B.MaxDPD08,MaxDPD09= B.MaxDPD09,MaxDPD10= B.MaxDPD10,MaxDPD11= B.MaxDPD11,Is3Mo=B.Is3Mo,Is6Mo=B.Is6Mo,Is12Mo=B.Is12Mo,MonthsClient=B.MonthsClient,AvgDays6Mo=B.AvgDays6Mo,NoIllLate=B.NoIllLate,MaxDPD3Mo=B.MaxDPD3Mo,ILL00=B.ILL00,ILL01=B.ILL01,ILL02=B.ILL02,ILL03=B.ILL03,ILL04=B.ILL04,ILL05=B.ILL05,ILL06=B.ILL06,ILL07=B.ILL07,ILL08=B.ILL08,ILL09=B.ILL09,ILL10=B.ILL10,ILL11=B.ILL11,InfoOK=B.InfoOK, LoanSeries00 = B.LoanSeries00, MonthClosed = B.monthclosed, Prev_Term = B.Prev_Term, ScTimeClosed = B.ScTimeClosed, RISKTOOL = B.RISKTOOL,RatioDaysLate = b.RatioDaysLate, ScAvgDays6Mo =B.ScAvgDays6Mo,ScRatioDaysLate = B.ScRatioDaysLate,ScMonthsClient = B.ScMonthsClient,ScMaxDPD3Mo =B.ScMaxDPD3Mo,ScNoIllLate =B.ScNoIllLate,TotalScore =B.TotalScore,Strategy =B.Strategy,Process =B.Process, Delinquent =B.Delinquent,Reco_Term =B.Reco_Term,Reco_EMI = B.Reco_EMI,Reco_LoanAmt = B.Reco_LoanAmt,ScoreDate =B.ScoreDate,Score_Monthno =B.score_monthno  From Renewal A,ScoreStability B 
Where A.MonthNo = 8 and b.score_Monthno = 9 and A.ClientID collate database_default= B.ClientID collate database_default
go

Update Renewal set MaxDPD00 = B.MaxDPD00,MaxDPD01= B.MaxDPD01,MaxDPD02= B.MaxDPD02,MaxDPD03= B.MaxDPD03,MaxDPD04= B.MaxDPD04,MaxDPD05= B.MaxDPD05,MaxDPD06= B.MaxDPD06,MaxDPD07= B.MaxDPD07,MaxDPD08= B.MaxDPD08,MaxDPD09= B.MaxDPD09,MaxDPD10= B.MaxDPD10,MaxDPD11= B.MaxDPD11,Is3Mo=B.Is3Mo,Is6Mo=B.Is6Mo,Is12Mo=B.Is12Mo,MonthsClient=B.MonthsClient,AvgDays6Mo=B.AvgDays6Mo,NoIllLate=B.NoIllLate,MaxDPD3Mo=B.MaxDPD3Mo,ILL00=B.ILL00,ILL01=B.ILL01,ILL02=B.ILL02,ILL03=B.ILL03,ILL04=B.ILL04,ILL05=B.ILL05,ILL06=B.ILL06,ILL07=B.ILL07,ILL08=B.ILL08,ILL09=B.ILL09,ILL10=B.ILL10,ILL11=B.ILL11,InfoOK=B.InfoOK, LoanSeries00 = B.LoanSeries00, MonthClosed = B.MonthClosed, Prev_Term = B.Prev_Term, ScTimeClosed = B.ScTimeClosed, RISKTOOL = B.RISKTOOL,RatioDaysLate = b.RatioDaysLate, ScAvgDays6Mo =B.ScAvgDays6Mo,ScRatioDaysLate = B.ScRatioDaysLate,ScMonthsClient = B.ScMonthsClient,ScMaxDPD3Mo =B.ScMaxDPD3Mo,ScNoIllLate =B.ScNoIllLate,TotalScore =B.TotalScore,Strategy =B.Strategy,Process =B.Process, Delinquent =B.Delinquent,Reco_Term =B.Reco_Term,Reco_EMI = B.Reco_EMI,Reco_LoanAmt = B.Reco_LoanAmt,ScoreDate =B.ScoreDate,Score_Monthno =B.score_monthno  From Renewal A,ScoreStability B 
Where A.MonthNo = 9 and b.score_Monthno = 10 and A.ClientID collate database_default= B.ClientID collate database_default
go

Update Renewal set MaxDPD00 = B.MaxDPD00,MaxDPD01= B.MaxDPD01,MaxDPD02= B.MaxDPD02,MaxDPD03= B.MaxDPD03,MaxDPD04= B.MaxDPD04,MaxDPD05= B.MaxDPD05,MaxDPD06= B.MaxDPD06,MaxDPD07= B.MaxDPD07,MaxDPD08= B.MaxDPD08,MaxDPD09= B.MaxDPD09,MaxDPD10= B.MaxDPD10,MaxDPD11= B.MaxDPD11,Is3Mo=B.Is3Mo,Is6Mo=B.Is6Mo,Is12Mo=B.Is12Mo,MonthsClient=B.MonthsClient,AvgDays6Mo=B.AvgDays6Mo,NoIllLate=B.NoIllLate,MaxDPD3Mo=B.MaxDPD3Mo,ILL00=B.ILL00,ILL01=B.ILL01,ILL02=B.ILL02,ILL03=B.ILL03,ILL04=B.ILL04,ILL05=B.ILL05,ILL06=B.ILL06,ILL07=B.ILL07,ILL08=B.ILL08,ILL09=B.ILL09,ILL10=B.ILL10,ILL11=B.ILL11,InfoOK=B.InfoOK, LoanSeries00 = B.LoanSeries00, MonthClosed = B.MonthClosed, Prev_Term = B.Prev_Term, ScTimeClosed = B.ScTimeClosed, RISKTOOL = B.RISKTOOL,RatioDaysLate = b.RatioDaysLate, ScAvgDays6Mo =B.ScAvgDays6Mo,ScRatioDaysLate = B.ScRatioDaysLate,ScMonthsClient = B.ScMonthsClient,ScMaxDPD3Mo =B.ScMaxDPD3Mo,ScNoIllLate =B.ScNoIllLate,TotalScore =B.TotalScore,Strategy =B.Strategy,Process =B.Process, Delinquent =B.Delinquent,Reco_Term =B.Reco_Term,Reco_EMI = B.Reco_EMI,Reco_LoanAmt = B.Reco_LoanAmt,ScoreDate =B.ScoreDate,Score_Monthno =B.score_monthno  From Renewal A,ScoreStability B 
Where A.MonthNo = 10 and b.score_Monthno = 11 and A.ClientID collate database_default= B.ClientID collate database_default
go

Update Renewal set MaxDPD00 = B.MaxDPD00,MaxDPD01= B.MaxDPD01,MaxDPD02= B.MaxDPD02,MaxDPD03= B.MaxDPD03,MaxDPD04= B.MaxDPD04,MaxDPD05= B.MaxDPD05,MaxDPD06= B.MaxDPD06,MaxDPD07= B.MaxDPD07,MaxDPD08= B.MaxDPD08,MaxDPD09= B.MaxDPD09,MaxDPD10= B.MaxDPD10,MaxDPD11= B.MaxDPD11,Is3Mo=B.Is3Mo,Is6Mo=B.Is6Mo,Is12Mo=B.Is12Mo,MonthsClient=B.MonthsClient,AvgDays6Mo=B.AvgDays6Mo,NoIllLate=B.NoIllLate,MaxDPD3Mo=B.MaxDPD3Mo,ILL00=B.ILL00,ILL01=B.ILL01,ILL02=B.ILL02,ILL03=B.ILL03,ILL04=B.ILL04,ILL05=B.ILL05,ILL06=B.ILL06,ILL07=B.ILL07,ILL08=B.ILL08,ILL09=B.ILL09,ILL10=B.ILL10,ILL11=B.ILL11,InfoOK=B.InfoOK, LoanSeries00 = B.LoanSeries00, MonthClosed = B.MonthClosed, Prev_Term = B.Prev_Term, ScTimeClosed = B.ScTimeClosed, RISKTOOL = B.RISKTOOL,RatioDaysLate = b.RatioDaysLate, ScAvgDays6Mo =B.ScAvgDays6Mo,ScRatioDaysLate = B.ScRatioDaysLate,ScMonthsClient = B.ScMonthsClient,ScMaxDPD3Mo =B.ScMaxDPD3Mo,ScNoIllLate =B.ScNoIllLate,TotalScore =B.TotalScore,Strategy =B.Strategy,Process =B.Process, Delinquent =B.Delinquent,Reco_Term =B.Reco_Term,Reco_EMI = B.Reco_EMI,Reco_LoanAmt = B.Reco_LoanAmt,ScoreDate =B.ScoreDate,Score_Monthno =B.score_monthno  From Renewal A,ScoreStability B 
Where A.MonthNo = 11 and b.score_Monthno = 12 and A.ClientID collate database_default= B.ClientID collate database_default
go

Alter table Renewal Add DPD0MOB float null,DPD3MOB float null,DPD6MOB float null,MAXDPD0MOB float null,MAXDPD3MOB float null,MAXDPD6MOB float null,OutsBal0MOB float null, OutsBal3MOB float null,OutsBal6MOB float null
go

select * into temp_mob00 from tempTotal_Financial where MOB = 0 and loancycle >1 and MonthNo <12 order by MonthDisbursed,ClientID 
go

Update Renewal set DPD0MOB = b.dpd,MAXDPD0MOB = b.DPD, outsbal0MOB = b.Balance  from Renewal a, temp_mob00 b
Where A.ClientID collate database_default= B.ClientID collate database_default and a.MonthDisbursed = b.MonthDisbursed 
go

select * into temp_mob02 from tempTotal_Financial where MOB = 2 and loancycle >1 and MonthNo <12 order by MonthDisbursed,ClientID 
go

Update Renewal set DPD3MOB = b.dpd,MAXDPD3MOB = b.DPD, outsbal3MOB = b.Balance  from Renewal a, temp_mob02 b
Where A.ClientID collate database_default= B.ClientID collate database_default and a.MonthDisbursed = b.MonthDisbursed 
go

select * into temp_mob05 from tempTotal_Financial where MOB = 5 and loancycle >1 and MonthNo <12 order by MonthDisbursed,ClientID 
go

Update Renewal set DPD6MOB = b.dpd,MAXDPD6MOB = b.DPD, outsbal6MOB = b.Balance  from Renewal a, temp_mob05 b
Where A.ClientID collate database_default= B.ClientID collate database_default and a.MonthDisbursed = b.MonthDisbursed 
go

Drop table temp_mob00,temp_mob02,temp_mob05 
go

Alter Table Renewal add RangeScore int null, RangeRatio int null
go
	
 Update Renewal set RangeScore = 1 where TotalScore <= -230
 Update Renewal set RangeScore = 2 where TotalScore > -230 and TotalScore <= -200
 Update Renewal set RangeScore = 3 where TotalScore > -200 and TotalScore <=-150
 Update Renewal set RangeScore = 4 where TotalScore > -150 and TotalScore <= -50
 Update Renewal set RangeScore = 5 where TotalScore > -50 and TotalScore <= 80
 Update Renewal set RangeScore = 6 where TotalScore > 80 and TotalScore <= 150
 Update Renewal set RangeScore = 7 where TotalScore > 150 and TotalScore <= 250
 Update Renewal set RangeScore = 8 where TotalScore > 250 and TotalScore <= 300
 Update Renewal set RangeScore = 9 where TotalScore > 300 and TotalScore <= 350
 Update Renewal set RangeScore = 10 where TotalScore > 350
 go
 
 Update Renewal set RangeRatio = 1 where RatioDaysLate <= 0.1
 Update Renewal set RangeRatio = 2 where RatioDaysLate > 0.1 and RatioDaysLate <= 0.17
 Update Renewal set RangeRatio = 3 where RatioDaysLate > 0.17 and RatioDaysLate <= 0.22
 Update Renewal set RangeRatio = 4 where RatioDaysLate > 0.22 and RatioDaysLate <= 0.33
 Update Renewal set RangeRatio = 5 where RatioDaysLate > 0.33 and RatioDaysLate <= 0.45
 Update Renewal set RangeRatio = 6 where RatioDaysLate > 0.45 and RatioDaysLate <= 0.64
 Update Renewal set RangeRatio = 7 where RatioDaysLate > 0.64 and RatioDaysLate <= 0.92
 Update Renewal set RangeRatio = 8 where RatioDaysLate > 0.92 and RatioDaysLate <= 1.36
 Update Renewal set RangeRatio = 9 where RatioDaysLate > 1.36 and RatioDaysLate <= 2.13
 Update Renewal set RangeRatio = 10 where RatioDaysLate > 2.13
 go
 
 If OBJECT_ID('ScoreBackTest') is not null
 Drop table ScoreBackTest

Select * Into ScoreBackTest From Renewal 
 go
 Drop Table Renewal 
 go
 
Execute sp_RENAME 'ScoreBackTest.Scoredate', 'Score_Monthobs' , 'COLUMN'
Execute sp_RENAME 'ScoreStability.Scoredate', 'Score_Monthobs' , 'COLUMN'
go