--This Script updates the MaxDPD using the DPD at the month end. 
--it is just temporal until the MAXDPD can be obtained from the System

Use China_AMC
go

update [tempTotal_Financial] set [MAXDPD]=dpd
where monthNo=0

go
