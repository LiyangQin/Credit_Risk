-------------change date in line 10 and file names in line 24 and 35-- Last run December 31, 2015 for November 30, 2015 data---------------
Use China_AMC

declare @Mth as datetime
declare @Mth1 as int
declare @Mth0 as datetime
declare @Mth_1 as int

set @Mth='11/30/2015'---->>>> CHANGE THE DATE 

set @Mth1= datepart(yy,@Mth)*100 + datepart(mm,@Mth)
set @Mth0= DATEADD(m,-1,@Mth)
set @Mth_1=datepart(yy,@Mth0)*100 + datepart(mm,@Mth0)

if object_id('tempMth') is not null
drop table tempMth

select @Mth as Mth, @Mth1 as Mth1, @Mth0 as Mth0, @Mth_1  as Mth_1  into tempMth
go
------------------------

/*Use China_AMC
if object_id('tempDPD') is not null
drop table tempDPD

SELECT * INTO tempDPD FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 12.0;IMEX=1;Database=C:\Roma_Vasudevan\China\AMC\Data\Risk_Raw_Data_Upto_31_Dec_2010\Max_DPD_FIles\For_Running_Wang\MAXDPD_historic.xlsx','SELECT * FROM [Sheet1$]')
--------------------------------------------------------
*/

Use China_AMC
if object_id('PQR_AMC') is not null
	drop table PQR_AMC

--Creates the tables with the standard fields

	CREATE TABLE [dbo].[PQR_AMC](
		[LoanID] [nvarchar](255) NULL,
		[ClientID] [nvarchar](255) NULL,
		[ClientName] [nvarchar](255) NULL,
		[LnOfcrName] [nvarchar](255) NULL,
		[ActDisbDate] [datetime] NULL,
		[ActCloseDate] [nvarchar](255) NULL,
		[ApprvdDisb] [float] NULL,
		[OutsPrin] [money] NULL,
		[LastPmtDt] [datetime] NULL,
		[NrTerms] [float] NULL,
		[MethID] [float] NULL,
		[IntRate] [nvarchar](255) NULL,
		[PenRate] [nvarchar](255) NULL,
		[PenGrace] [float] NULL,
		[PenMax] [float] NULL,
		[IdxCur] [nvarchar](255) NULL,
		[PmtCur] [nvarchar](255) NULL,
		[Rschd] [nvarchar](255) NULL,
		[SchdPmtAmt] [float] NULL,
		[SchdType] [nvarchar](255) NULL,
		[Fund] [nvarchar](255) NULL,
		[Bank] [nvarchar](255) NULL,
		[PrevLns] [float] NULL,
		[BusName] [nvarchar](255) NULL,
		[BusType] [nvarchar](255) NULL,
		[BusSubType] [nvarchar](255) NULL,
		[BusDesc] [nvarchar](255) NULL,
		[BusNew] [nvarchar](255) NULL,
		[BusReg] [nvarchar](255) NULL,
		[MthSales] [nvarchar](255) NULL,
		[BusEquity] [nvarchar](255) NULL,
		[FamIncom] [nvarchar](255) NULL,
		[SiteVisitDt] [datetime] NULL,
		[CrdtComDt] [datetime] NULL,
		[DisbDt] [datetime] NULL,
		[EmpB4Ln] [float] NULL,
		[EmpExpNew] [nvarchar](255) NULL,
		[EmpAftLn] [nvarchar](255) NULL,
		[EmpB4LnF] [nvarchar](255) NULL,
		[EmpAftLnF] [nvarchar](255) NULL,
		[IntRateQt] [float] NULL,
		[LnCharLkp1] [nvarchar](255) NULL,
		[LnCharLkp2] [nvarchar](255) NULL,
		[LnCharLkp3] [nvarchar](255) NULL,
		[LnCharLkp4] [nvarchar](255) NULL,
		[LnCharLkp5] [nvarchar](255) NULL,
		[LnCharLkp6] [nvarchar](255) NULL,
		[LnCharStr1] [nvarchar](255) NULL,
		[LnCharStr2] [nvarchar](255) NULL,
		[LnCharStr3] [nvarchar](255) NULL,
		[TrmLth] [nvarchar](255) NULL,
		[PmtWkDy] [nvarchar](255) NULL,
		[Rnd] [nvarchar](255) NULL,
		[DisbFee] [float] NULL,
		[Street] [nvarchar](255) NULL,
		[City] [nvarchar](255) NULL,
		[StMun] [nvarchar](255) NULL,
		[Region] [nvarchar](255) NULL,
		[Country] [nvarchar](255) NULL,
		[Branch] [nvarchar](255) NULL,
		[UrbRur] [nvarchar](255) NULL,
		[GivName] [nvarchar](255) NULL,
		[SecName] [nvarchar](255) NULL,
		[SurName] [nvarchar](255) NULL,
		[BirthDt] [datetime] NULL,
		[Gender] [nvarchar](255) NULL,
		[Ethn] [nvarchar](255) NULL,
		[MarStat] [nvarchar](255) NULL,
		[PartName] [nvarchar](255) NULL,
		[NrTotalDep] [float] NULL,
		[NrHouseDep] [float] NULL,
		[CtryOrig] [nvarchar](255) NULL,
		[Citizen] [nvarchar](255) NULL,
		[ID1Type] [nvarchar](255) NULL,
		[ID2Type] [nvarchar](255) NULL,
		[ID2Nr] [nvarchar](255) NULL,
		[Fon1Type] [nvarchar](255) NULL,
		[Fon2Type] [nvarchar](255) NULL,
		[IndivLkp1] [nvarchar](255) NULL,
		[IndivLkp2] [nvarchar](255) NULL,
		[IndivLkp3] [nvarchar](255) NULL,
		[IndivStr2] [nvarchar](255) NULL,
		[LnCharDt1] [nvarchar](255) NULL,
		[ClientType] [nvarchar](255) NULL,
		[LoanType] [nvarchar](255) NULL,
		[GroupID] [nvarchar](255) NULL,
		[Pres] [nvarchar](255) NULL,
		[Secrty] [nvarchar](255) NULL,
		[Treas] [nvarchar](255) NULL,
		[RecPmts] [nvarchar](255) NULL,
		[Archived] [nvarchar](255) NULL,
		[LnProd] [nvarchar](255) NULL,
		[GrpLnID] [nvarchar](255) NULL,
		[LastSchdDt] [datetime] NULL,
		[Rschd2] [nvarchar](255) NULL,
		[OpsRegion] [varchar](50) NOT NULL
	)
	Go

	insert into PQR_AMC 
	SELECT *, 'AMC' as OpsRegion FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 12.0;IMEX=1;Database=D:\OwnCloud\Grassland\Credit and Risk\Reports\Rawdata\KxlRpt20151130_Cycle_Corrected.xlsx','SELECT 
	[LoanID],
	[ClientID],
	[ClientName],
	[LnOfcrName],
	[ActDisbDate],
	[ActCloseDate],
	[ApprvdDisb],
	[OutsPrin],
	[LastPmtDt],
	[NrTerms],
	[MethID],
	[IntRate],
	[PenRate],
	[PenGrace],
	[PenMax],
	[IdxCur],
	[PmtCur],
	[Rschd],
	[SchdPmtAmt],
	[SchdType],
	[Fund],
	[Bank],
	[PrevLns],
	[BusName],
	[BusType],
	[BusSubType],
	[BusDesc],
	[BusNew],
	[BusReg],
	[MthSales],
	[BusEquity],
	[FamIncom],
	[SiteVisitDt],
	[CrdtComDt],
	[DisbDt],
	[EmpB4Ln],
	[EmpExpNew],
	[EmpAftLn],
	[EmpB4LnF],
	[EmpAftLnF],
	[IntRateQt],
	[LnCharLkp1],
	[LnCharLkp2],
	[LnCharLkp3],
	[LnCharLkp4],
	[LnCharLkp5],
	[LnCharLkp6],
	[LnCharStr1],
	[LnCharStr2],
	[LnCharStr3],
	[TrmLth],
	[PmtWkDy],
	[Rnd],
	[DisbFee],
	[Street],
	[City],
	[StMun],
	[Region],
	[Country],
	[Branch],
	[UrbRur],
	[GivName],
	[SecName],
	[SurName],
	[BirthDt],
	[Gender],
	[Ethn],
	[MarStat],
	[PartName],
	[NrTotalDep],
	[NrHouseDep],
	[CtryOrig],
	[Citizen],
	[ID1Type],
	[ID2Type],
	[ID2Nr],
	[Fon1Type],
	[Fon2Type],
	[IndivLkp1],
	[IndivLkp2],
	[IndivLkp3],
	[IndivStr2],
	[LnCharDt1],
	[ClientType],
	[LoanType],
	[GroupID],
	[Pres],
	[Secrty],
	[Treas],
	[RecPmts],
	[Archived],
	[LnProd],
	[GrpLnID],
	[LastSchdDt],
	[Rschd2]
	FROM [20151130$]')
--union
/*
if object_id('PQR_w') is not null
drop table PQR_W
*/
insert into PQR_AMC 
SELECT *, 'wanzhou' as OpsRegion FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 12.0;IMEX=1;Database=D:\OwnCloud\Grassland\Credit and Risk\Reports\Rawdata\wanzhou_KxlRpt.xlsx','SELECT [LoanID]
      ,[ClientID]
      ,[ClientName]
      ,[LnOfcrName]
      ,[ActDisbDate]
      ,[ActCloseDate]
      ,[ApprvdDisb]
      ,[OutsPrin]
      ,[LastPmtDt]
      ,[NrTerms]
      ,[MethID]
      ,[IntRate]
      ,[PenRate]
      ,[PenGrace]
      ,[PenMax]
      ,[IdxCur]
      ,[PmtCur]
      ,[Rschd]
      ,[SchdPmtAmt]
      ,[SchdType]
      ,[Fund]
      ,[Bank]
      ,[PrevLns]
      ,[BusName]
      ,[BusType]
      ,[BusSubType]
      ,[BusDesc]
      ,[BusNew]
      ,[BusReg]
      ,[MthSales]
      ,[BusEquity]
      ,[FamIncom]
      ,[SiteVisitDt]
      ,[CrdtComDt]
      ,[DisbDt]
      ,[EmpB4Ln]
      ,[EmpExpNew]
      ,[EmpAftLn]
      ,[EmpB4LnF]
      ,[EmpAftLnF]
      ,[IntRateQt]
      ,[LnCharLkp1]
      ,[LnCharLkp2]
      ,[LnCharLkp3]
      ,[LnCharLkp4]
      ,[LnCharLkp5]
      ,[LnCharLkp6]
      ,[LnCharStr1]
      ,[LnCharStr2]
      ,[LnCharStr3]
      ,[TrmLth]
      ,[PmtWkDy]
      ,[Rnd]
      ,[DisbFee]
      ,[Street]
      ,[City]
      ,[StMun]
      ,[Region]
      ,[Country]
      ,[Branch]
      ,[UrbRur]
      ,[GivName]
      ,[SecName]
      ,[SurName]
      ,[BirthDt]
      ,[Gender]
      ,[Ethn]
      ,[MarStat]
      ,[PartName]
      ,[NrTotalDep]
      ,[NrHouseDep]
      ,[CtryOrig]
      ,[Citizen]
      ,[ID1Type] 
	  ,[ID2Type]
      ,[ID2Nr]
      ,[Fon1Type]
      ,[Fon2Type]
      ,[IndivLkp1]
      ,[IndivLkp2]
      ,[IndivLkp3]
      ,[IndivStr2]
      ,[LnCharDt1]
      ,[ClientType]
      ,[LoanType]
      ,[GroupID]
      ,[Pres]
      ,[Secrty]
      ,[Treas]
      ,[RecPmts]
      ,[Archived]
      ,[LnProd]
      ,[GrpLnID]
      ,[LastSchdDt]
      ,[Rschd2] FROM [20151130$]')

go

Alter table PQR_AMC add 
	[Observation Date] datetime,
	DPD float,
	OvduPrinciple int 
GO

Alter table PQR_AMC alter column ActCloseDate datetime
GO

Delete from PQR_AMC where LoanID is NULL

Update PQR_AMC set [Observation Date]=(select Mth from tempMth) 
GO

if object_id('DEL_TEMP') is not null
	drop table DEL_TEMP

SELECT * INTO DEL_TEMP FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 12.0;IMEX=1;Database=D:\OwnCloud\Grassland\Credit and Risk\Reports\Rawdata\rptAtRisk20151130.xlsx','SELECT txtLoanID,txtOvduPrin, txtDaysOvdu FROM [20151130$]')
union
SELECT *  FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 12.0;IMEX=1;Database=D:\OwnCloud\Grassland\Credit and Risk\Reports\Rawdata\wanzhou_rptAtRisk.xlsx','SELECT txtLoanID,txtOvduPrin,txtDaysOvdu FROM [20151130$]')
GO

Update PQR_AMC set DPD=a.txtDaysOvdu from DEL_TEMP a where LoanID collate SQL_Latin1_General_CP1_CI_AS =a.txtLoanID
go

Update PQR_AMC set OvduPrinciple=a.txtOvduPrin from DEL_TEMP a where LoanID collate SQL_Latin1_General_CP1_CI_AS=a.txtLoanID
GO

Drop table DEL_TEMP

Alter table PQR_AMC add 
	Balance money,
	Current1 money,
	P1_5 money,
	P6_15 money,
	P16_30 money,
	P31_60 money,
	P61_90 money,
	P91_120 money,
	P121_150 money,
	P151_180 money,
	P180 money,
	[PAR>0] money,
	[PAR>5] money,
	[PAR>15] money,
	[PAR>30] money,
	[PAR>60] money,
	PAR1to30 money,
	MOB int,
	MonthDisbursed int,
	MatExp int,
	MaturityExp datetime,
	loancycle varchar(5),
	Monthterm int,
	Monthobs int,
	NewRenew varchar(10),
	Client int,
	MonthDisbNo int,
	MonthNo int
go

Update PQR_AMC set DPD=0 where DPD is NULL
Update PQR_AMC set Balance=OutsPrin
Update PQR_AMC set Current1=OutsPrin where DPD=0
Update PQR_AMC set P1_5=OutsPrin where (DPD>0 and DPD<=5)
Update PQR_AMC set P6_15=OutsPrin where (DPD>5 and DPD<=15)
Update PQR_AMC set P16_30=OutsPrin where (DPD>15 and DPD<=30)
Update PQR_AMC set P31_60=OutsPrin where (DPD>30 and DPD<=60)
Update PQR_AMC set P61_90=OutsPrin where (DPD>60 and DPD<=90)
Update PQR_AMC set P91_120=OutsPrin where (DPD>90 and DPD<=120)
Update PQR_AMC set P121_150=OutsPrin where (DPD>120 and DPD<=150)
Update PQR_AMC set P151_180=OutsPrin where (DPD>150 and DPD<=180)
Update PQR_AMC set P180=OutsPrin where (DPD>180)

Update PQR_AMC set Balance=0 where Balance is NULL
Update PQR_AMC set Current1=0 where Current1 is NULL
Update PQR_AMC set P1_5=0 where P1_5 is NULL
Update PQR_AMC set P6_15=0 where P6_15 is NULL
Update PQR_AMC set P16_30=0 where P16_30 is NULL
Update PQR_AMC set P31_60=0 where P31_60 is NULL
Update PQR_AMC set P61_90=0 where P61_90 is NULL
Update PQR_AMC set P91_120=0 where P91_120 is NULL
Update PQR_AMC set P121_150=0 where P121_150 is NULL
Update PQR_AMC set P151_180=0 where P151_180 is NULL
Update PQR_AMC set P180=0 where P180 is NULL

update PQR_AMC set [PAR>0]= (P1_5+P6_15+P16_30+P31_60+P61_90+P91_120+P121_150+P151_180+P180) where DPD>0
update PQR_AMC set [PAR>5]= (P6_15+P16_30+P31_60+P61_90+P91_120+P121_150+P151_180+P180) where DPD>5
update PQR_AMC set [PAR>15]= (P16_30+P31_60+P61_90+P91_120+P121_150+P151_180+P180) where DPD>15
update PQR_AMC set [PAR>30]= (P31_60+P61_90+P91_120+P121_150+P151_180+P180) where DPD>30
update PQR_AMC set [PAR>60]= (P61_90+P91_120+P121_150+P151_180+P180) where DPD>60
update PQR_AMC set PAR1to30= (P1_5+P6_15+P16_30) where (DPD>0 and DPD<=30)

Update PQR_AMC set Monthobs =datepart(yy,[Observation Date])*100 + datepart(mm,[Observation Date])
Update PQR_AMC set MonthDisbursed =datepart(yy,DisbDt)*100 + datepart(mm,DisbDt)
Update PQR_AMC set Mob=((Monthobs/100)-(MonthDisbursed/100))*12+((Monthobs-(Monthobs/100)*100)-(MonthDisbursed-(MonthDisbursed/100)*100))

Update PQR_AMC set Monthterm=Nrterms
Update PQR_AMC set MaturityExp =DATEADD(m,cast(Nrterms as int),cast(DisbDt as date))
Update PQR_AMC set MatExp= datepart(yy,[MaturityExp])*100 + datepart(mm,[MaturityExp])

/*
update PQR_AMC set loancycle=substring(LoanID, 13,3)
*/

Alter table PQR_AMC alter column loancycle int
update PQR_AMC set loancycle=PrevLns+1

Update PQR_AMC set NewRenew='New' where loancycle=1
Update PQR_AMC set NewRenew='Renew' where loancycle<>1

Update PQR_AMC set Client=1

Delete from tempTotal_Financial where Monthobs=(select Mth1 from tempMth )

Update PQR_AMC set MthSales=NULL
Update PQR_AMC set BusEquity=NULL
Update PQR_AMC set FamIncom=NULL

/*alter table tempTotal_Financial add OpsRegion nvarchar(50)
	update tempTotal_Financial set OpsRegion = 'AMC'
*/

Insert into tempTotal_Financial select 
	LoanID as Lnnote, 
	ClientID, 
	LnOfcrName as LO, 
	ActDisbDate as Disbursement_date, 
	ApprvdDisb as LoanAmt,
	LastPmtDt,
	NrTerms as LoanTerm,
	Rschd,
	SchdPmtAmt as EMI,
	SchdType,
	Fund,
	Bank,
	PrevLns,
	MthSales,
	BusEquity,
	FamIncom,
	SiteVisitDt,
	CrdtComDt,
	DisbDt,
	EmpB4Ln,
	IntRateQt,
	LnCharLkp4 as Prod,
	TrmLth,
	Rnd,
	DisbFee,
	Street,
	City,
	'' as PostCode,
	StMun,
	Region,
	Country,
	Branch,
	UrbRur,
	BirthDt,
	Gender,
	Ethn,
	MarStat,
	NrTotalDep,
	NrHouseDep,
	CtryOrig,
	Citizen,
	ID1Type,
	ID2Type,
	IndivLkp1,
	IndivLkp2,
	IndivLkp3,
	'' as IndivStr1,
	IndivStr2,
	ClientType,
	LoanType,
	LnProd,
	LastSchdDt,
	Rschd2,
	[Observation Date],
	DPD,
	Balance,
	Current1,P1_5,P6_15,P16_30,P31_60,P61_90,P91_120,P121_150,P151_180,P180,
	[PAR>0],[PAR>5],[PAR>15],[PAR>30],[PAR>60],PAR1to30,
	MOB,
	MonthDisbursed,
	MatExp,
	loancycle,
	Monthterm,
	Monthobs,
	MaturityExp,
	NewRenew,
	Client,
	MonthDisbNo,
	MonthNo,
	ClientName,
	null as MaxDPD,
	OpsRegion from PQR_AMC

Drop Table PQR_AMC

select Monthobs,
	Active_Client=count(lnnote),
	OutBalance=sum(Balance),
	"PaR1+"=sum(P1_5+P6_15+P16_30+P31_60+P61_90+P91_120+P121_150+P151_180+P180),
	"PaR5+"=sum(P6_15+P16_30+P31_60+P61_90+P91_120+P121_150+P151_180+P180),
	"PaR30+"=sum(P31_60+P61_90+P91_120+P121_150+P151_180+P180)
	from tempTotal_Financial 
	group by Monthobs 
	order by Monthobs desc

-----ISWAS PROCESS----

SELECT lnnote,
	loancycle,
	prod,
	disbursement_date,
	Prod as Product,
	balance,
	dpd,
	Branch,
	[observation date] as  transactiondate,
	MonthDisbursed,
	LO as officier,
	Monthobs,
	NewRenew,
	Monthterm,
	MaturityExp,
	OpsRegion  
	into IsFile_D from tempTotal_Financial 
	where Monthobs=(select Mth1 from tempMth) 
	order by lnnote asc

Alter table IsFile_D add Bal1 int, Del1 int

Update IsFile_D set Bal1=balance
Update IsFile_D set Del1=Dpd

Update IsFile_D set balance=NULL
Update IsFile_D set Dpd=NULL

Execute sp_RENAME 'IsFile_D.balance', 'Bal0' , 'COLUMN'
Execute sp_RENAME 'IsFile_D.Dpd', 'Del0' , 'COLUMN'

SELECT lnnote,
	loancycle,
	prod,
	disbursement_date,
	Prod as Product,
	balance,
	dpd,
	Branch,
	[observation date] as  transactiondate,
	MonthDisbursed,
	LO as officier,
	Monthobs,
	NewRenew,
	Monthterm,
	MaturityExp,
	OpsRegion 
	into WasFile_D from tempTotal_Financial 
	where Monthobs=(select Mth_1 from tempMth) 
	order by lnnote asc


Alter table WasFile_D add Bal0 int, Del0 int

Update WasFile_D set Bal0=Balance
Update WasFile_D set Del0=Dpd

Update WasFile_D set Balance=NULL
Update WasFile_D set Dpd=NULL

Execute sp_RENAME 'WasFile_D.Balance', 'Bal1' , 'COLUMN'
 
Execute sp_RENAME 'WasFile_D.Dpd', 'Del1' , 'COLUMN'
 
Execute sp_RENAME 'IsFile_D.MonthDisbursed', 'Newvintage1' , 'COLUMN'
 
Execute sp_RENAME 'WasFile_D.MonthDisbursed', 'Newvintage1' , 'COLUMN'

Insert into WasFile_D select * from IsFile_D where Newvintage1=(select Mth1 from tempMth) 

update WasFile_D set Del1= A.Del1
From IsFile_D A, WasFile_D B
where (B.lnnote=A.lnnote and B.Branch=A.Branch)

update WasFile_D set Bal1= A.Bal1
From IsFile_D A, WasFile_D B
where (B.lnnote=A.lnnote and B.Branch=A.Branch)


Update WasFile_D set Del1=-99 where Del1 is Null
Update WasFile_D set Bal1=0 where Bal1 is Null

Update WasFile_D set Del0=-99 where Newvintage1=(select Mth1 from tempMth) 
Update WasFile_D set Bal0=0 where Newvintage1=(select Mth1 from tempMth)


Update IsFile_D 
	set Monthobs= case 
				when ((Monthobs-(Monthobs/100)*100)<>12) then Monthobs+1
				else Monthobs+89
				end
Update WasFile_D 
	set Monthobs= case 
				when ((Monthobs-(Monthobs/100)*100)<>12) then Monthobs+1
				else Monthobs+89
				end


Alter table WasFile_D add Range0 varchar(10),Range1 varchar(10), Range0In varchar(10), Range1In varchar(10), Renewal Int, OriginalLO Varchar(50), BranchZone varchar(50), duedate datetime, Pastduedate datetime, Branch1 varchar(35) null, WriteOff varchar(5) null


--Update WasFile_D set WriteOff='NO' from RapportJournalier..Writeoffs, WasFile_D where lnnote<>lnnote

--Update WasFile_D set WriteOff='YES' from RapportJournalier..Writeoffs, WasFile_D where lnnote=lnnote 

Update WasFile_D set Range0= 'New' where Del0 =-99
Update WasFile_D set Range0= 'Current' where Del0= 0
Update WasFile_D set Range0= '1-30' where (Del0>= 1 and Del0<=30)
Update WasFile_D set Range0= '31-60' where (Del0> 30 and Del0<=60)
Update WasFile_D set Range0= '61-90' where (Del0> 60 and Del0<=90)
Update WasFile_D set Range0= '91-120' where (Del0> 90 and Del0<=120)
Update WasFile_D set Range0= '121-150' where (Del0> 120 and Del0<=150)
Update WasFile_D set Range0= '151-180' where (Del0> 150 and Del0<=180)
Update WasFile_D set Range0= '>180' where Del0> 180 

Update WasFile_D set Range0In= 'New' where Del0 =-99
Update WasFile_D set Range0In= 'Current' where Del0= 0
Update WasFile_D set Range0In= '1-5' where (Del0>= 1 and Del0<=5)
Update WasFile_D set Range0In= '6-30' where (Del0> 5 and Del0<=30)
Update WasFile_D set Range0In= '31-60' where (Del0> 30 and Del0<=60)
Update WasFile_D set Range0In= '61-90' where (Del0> 60 and Del0<=90)
Update WasFile_D set Range0In= '91-120' where (Del0> 90 and Del0<=120)
Update WasFile_D set Range0In= '121-150' where (Del0> 120 and Del0<=150)
Update WasFile_D set Range0In= '151-180' where (Del0> 150 and Del0<=180)
Update WasFile_D set Range0In= '>180' where Del0> 180 

Update WasFile_D set Range1= 'Close' where Del1 =-99
Update WasFile_D set Range1= 'Current' where Del1= 0
Update WasFile_D set Range1= '1-30' where (Del1>= 1 and Del1<=30)
Update WasFile_D set Range1= '31-60' where (Del1> 30 and Del1<=60)
Update WasFile_D set Range1= '61-90' where (Del1> 60 and Del1<=90)
Update WasFile_D set Range1= '91-120' where (Del1> 90 and Del1<=120)
Update WasFile_D set Range1= '121-150' where (Del1> 120 and Del1<=150)
Update WasFile_D set Range1= '151-180' where (Del1> 150 and Del1<=180)
Update WasFile_D set Range1= '>180' where Del1> 180 

Update WasFile_D set Range1In= 'CLOSED' where Del1 =-99
Update WasFile_D set Range1In= 'Current' where Del1= 0
Update WasFile_D set Range1In= '1-5' where (Del1>= 1 and Del1<=5)
Update WasFile_D set Range1In= '6-30' where (Del1> 5 and Del1<=30)
Update WasFile_D set Range1In= '31-60' where (Del1> 30 and Del1<=60)
Update WasFile_D set Range1In= '61-90' where (Del1> 60 and Del1<=90)
Update WasFile_D set Range1In= '91-120' where (Del1> 90 and Del1<=120)
Update WasFile_D set Range1In= '121-150' where (Del1> 120 and Del1<=150)
Update WasFile_D set Range1In= '151-180' where (Del1> 150 and Del1<=180)
Update WasFile_D set Range1In= '>180' where Del1> 180 

Update WasFile_D set Renewal=1 where Loancycle>1
Update WasFile_D set Renewal=0 where Loancycle=1

Alter table WasFile_D alter column officier Varchar(50)
Alter table WasFile_D alter column Branch Varchar(50)

Update WasFile_D set OriginalLO=(Branch+' - '+officier)
Update WasFile_D set BranchZone= officier

update WasFile_D set Branch1 ='CNAA' where Branch ='CNAA'
update WasFile_D set Branch1 ='CNAB' where Branch ='CNAB'
update WasFile_D set Branch1 ='CNAC' where Branch ='CNAC'

CREATE TABLE dbo.temp_IsWasFile_D(
	lnnote varchar(55) NULL,
	[Loan Series] int NULL,
	Product varchar(55) NULL,
	disbursdate datetime NULL,
	Branch varchar(50) NULL,
	Bal0 int NULL,
	Del0 int NULL,
	Bal1 int NULL,
	Del1 int NULL,
	[Loan Officer] varchar(100) NULL,
	BranchZone varchar (50) NULL,
	Range0 varchar(50) NULL,
	Range1 varchar(50) NULL,
	Range0In varchar(50) NULL,
	Range1In varchar(50) NULL,
	RENEWAL varchar(50) NULL,
	transactiondate datetime NULL,
	Branch1 varchar(55) null,
	Monthobs int null,
	WriteOff varchar(5) null,
	MaturityDate datetime NULL,
	MonthTerm int NULL,
	OpsRegion nvarchar(50) NULL
)

Insert into temp_IsWasFile_D 
	select lnnote,
	loancycle,
	prod,
	disbursement_date,
	Branch,
	Bal0,
	Del0,
	Bal1,
	Del1,
	OriginalLO,
	BranchZone,
	Range0,
	Range1,
	Range0In,
	Range1In,
	NewRenew,
	transactiondate,
	Branch1,
	Monthobs,
	WriteOff,
	MaturityExp,
	MonthTerm,
	OpsRegion from WasFile_D 

/*alter table IsWasFile_D add OpsRegion nvarchar(50)
Update IsWasFile_D set OpsRegion = 'AMC'
*/

drop table IsWasFile_D

select * into IsWasFile_D from temp_IsWasFile_D order by lnnote

drop table IsFile_D, WasFile_D , temp_IsWasFile_D

Delete from China_AMC..Total_IsWas where Monthobs>=(select Mth1 from tempMth) 
 
/*alter table Total_IsWas add OpsRegion nvarchar(50)
Update Total_IsWas set OpsRegion = 'AMC'
*/
Insert into China_AMC..Total_IsWas select * from IsWasFile_D
--use China_AMC 
go

declare @count as int
declare @Rowc as int
declare @min as int
declare @max as int
declare @Monthobs as int
declare @counter as int
declare @intCount as int

select @Rowc = count(monthobs) from tempTotal_Financial where Monthobs is not null
select @count = COUNT(distinct(monthobs)) from tempTotal_Financial where Monthobs is not null
select @min = Min(monthobs) from tempTotal_Financial 
select @max = Max(monthobs) from tempTotal_Financial 
 
set @intCount = 1
set @counter = @count -1
set @Monthobs = @min

while (@intCount <= @Rowc) and (@max >= @Monthobs) 
 begin
  update tempTotal_Financial set MonthNo = @counter  where Monthobs = @Monthobs 
  
  if RIGHT(@monthobs,2) <> 12
   begin
    set @Monthobs = (@Monthobs + 1)
   end
  else
   begin
    set @Monthobs = (@Monthobs + 89)  
   end   
   set @intCount = @intCount +1
   set @counter = @counter - 1 
 end
 go 
 
declare @count as int
declare @Rowc as int
declare @min as int
declare @max as int
declare @MonthDisbursed as int
declare @counter as int
declare @intCount as int

select @Rowc = count(MonthDisbursed) from tempTotal_Financial where MonthDisbursed is not null
select @count = COUNT(distinct(MonthDisbursed)) from tempTotal_Financial where MonthDisbursed is not null
select @min = Min(MonthDisbursed) from tempTotal_Financial 
select @max = Max(MonthDisbursed) from tempTotal_Financial 
 
set @intCount = 1
set @counter = @count -1
set @MonthDisbursed = @min

while (@intCount <= @Rowc) and (@max >= @MonthDisbursed) 
 begin
  update tempTotal_Financial set MonthDisbNo = @counter  where MonthDisbursed = @MonthDisbursed 
  
  if RIGHT(@MonthDisbursed,2) <> 12
   begin
    set @MonthDisbursed = (@MonthDisbursed + 1)
   end
  else
   begin
    set @MonthDisbursed = (@MonthDisbursed + 89)  
   end   
   set @intCount = @intCount +1
   set @counter = @counter - 1 
 
 end
 
 go
 /*update [tempTotal_Financial] set MaxDPD=d.maxdpd
 from tempdpd d
 where d.clientid=[tempTotal_Financial].ClientID 
 and d.monthobs=[tempTotal_Financial].Monthobs 
 go*/

 update [tempTotal_Financial] set MaxDPD=dpd
 where maxdpd is null
 go
 
