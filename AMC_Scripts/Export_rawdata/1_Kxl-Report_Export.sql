SELECT
	loan.ID AS LoanID,
	a.ID AS ClientID,
	CONCAT(a.FIRSTNAME, a.LASTNAME) AS ClientName,
	concat(u.FIRSTNAME, u.LASTNAME) AS LnOfcrName,
	loan.DISBURSEMENTDATE AS ActDisbDate,
	'' ActCloseDate,
	loan.LOANAMOUNT AS ApprvdDisb,
	loan.LOANAMOUNT - (
		SELECT
			SUM(loantrans.PRINCIPALAMOUNT)
		FROM
			loanaccount loan1
		LEFT JOIN loantransaction loantrans ON loan1.ENCODEDKEY = loantrans.PARENTACCOUNTKEY
		WHERE
			loan.id = loan1.id
		AND loantrans.TYPE NOT IN (
			'DISBURSMENT',
			'IMPORT',
			'DISBURSMENT_ADJUSTMENT',
			'REPAYMENT_ADJUSTMENT'
		)
		AND loantrans.REVERSALTRANSACTIONKEY IS NULL
		AND loantrans.ENTRYDATE <= '2015-12-31-24'
		AND (
			loan.DISBURSEMENTDATE <= '2015-12-31-24'
			OR loan.CLOSEDDATE >= '2015-12-31-24'
		)
		AND (
			(
				loan.DISBURSEMENTDATE <= '2015-12-31-24'
			)
			OR (
				loan.ACCOUNTSTATE IN ('CLOSED')
				AND loan.CLOSEDDATE > '2015-12-31-24'
			)
		)
		GROUP BY
			loan.ID
		HAVING
			COUNT(loan.ID) >= 1
	) AS OutsPrin,
	'' LastPmtDt,
	loan.REPAYMENTINSTALLMENTS AS NrTerms,
	'303,402,007.00' AS MethID,
	'0.0533%' AS IntRate,
	'0.0750%' AS PenRate,
	'0' AS PenGrace,
	'0' AS PenMax,
	'CNY' AS IdxCur,
	'CNY' AS PmtCur,
	'False' AS Rschd,
	ROUND(
		(
			loan.LOANAMOUNT + loan.INTERESTPAID
		) / loan.REPAYMENTINSTALLMENTS
	) AS SchdPmtAmt,
	'DecBalEqPmts' AS SchdType,
	'ACCION' AS Fund,
	'财务-中国银行' AS Bank,
	a.loanCycle AS PrevLns,
	'' BusName,
	'' BusType,
	'' BusSubType,
	'' BusDesc,
	cfv1.`VALUE` BusNew,
	'' BusReg,
	'' MthSales,
	'' BusEquity,
	'' FamIncom,
	loan.CREATIONDATE AS SiteVisitDt,
	loan.APPROVEDDATE AS CrdtComDt,
	loan.DISBURSEMENTDATE AS DisbDt,
	cfv2.`VALUE` AS EmpB4Ln,
	'' EmpExpNew,
	'' EmpAftLn,
	'' EmpB4LnF,
	'' EmpAftLnF,
	loan.INTERESTRATE AS IntRateQt,
	'' LnCharLkp1,
	'' LnCharLkp2,
	cfv3.`VALUE` AS LnCharLkp3,
	cfv4.`VALUE` AS LnCharLkp4,
	cfv5.`VALUE` AS LnCharLkp5,
	'' LnCharLkp6,
	'' LnCharStr1,
	'' LnCharStr2,
	'' LnCharStr3,
	loan.REPAYMENTPERIODUNIT AS TrmLth,
	'Never Sat or Sun 2' PmtWkDy,
	'Unit' Rnd,
	loan.FEESPAID / loan.LOANAMOUNT AS DisbFee,
	cfv6.`VALUE` AS Street,
	cfv7.`VALUE` AS City,
	cfv8.`VALUE` AS PostCode,
	cfv9.`VALUE` AS StMun,
	cfv10.`VALUE` AS Region,
	'cn' Country,
	bran. NAME AS Branch,
	cfv11.`VALUE` AS UrbRur,
	a.LASTNAME AS GivName,
	a.MIDDLENAME AS SecName,
	a.FIRSTNAME AS SurName,
	a.BIRTHDATE AS BirthDt,
	a.GENDER AS Gender
FROM
	client a
LEFT JOIN loanaccount loan ON a.ENCODEDKEY = loan.ACCOUNTHOLDERKEY
LEFT JOIN loantransaction loantrans ON loan.ENCODEDKEY = loantrans.PARENTACCOUNTKEY
LEFT JOIN USER u ON loan.ASSIGNEDUSERKEY = u.ENCODEDKEY
LEFT JOIN branch bran ON a.ASSIGNEDBRANCHKEY = bran.ENCODEDKEY
LEFT JOIN customfieldvalue cfv1 ON cfv1.PARENTKEY = loan.ENCODEDKEY AND cfv1.CUSTOMFIELDKEY = '8a10d7be4aa2d47a014abdbb50a75c7a'
LEFT JOIN customfieldvalue cfv2 ON cfv2.PARENTKEY = loan.ENCODEDKEY AND cfv2.CUSTOMFIELDKEY = '8a10d7be4aa2d47a014abdbc91945c85'
LEFT JOIN customfieldvalue cfv3 ON cfv3.PARENTKEY = loan.ENCODEDKEY AND cfv3.CUSTOMFIELDKEY = '8a1b154a4a2224e4014a28c4e20370c8'
LEFT JOIN customfieldvalue cfv4 ON cfv4.PARENTKEY = loan.ENCODEDKEY AND cfv4.CUSTOMFIELDKEY = '8a1b154a4a2224e4014a28c66c2b70e1'
LEFT JOIN customfieldvalue cfv5 ON cfv5.PARENTKEY = loan.ENCODEDKEY AND cfv5.CUSTOMFIELDKEY = '8a1b154a4a2224e4014a28d1238c72ff'
LEFT JOIN customfieldvalue cfv6 ON cfv6.PARENTKEY = a.ENCODEDKEY AND cfv6.CUSTOMFIELDKEY = '8a131ecf4a0332c1014a099ce5f90216'
LEFT JOIN customfieldvalue cfv7 ON cfv7.PARENTKEY = a.ENCODEDKEY AND cfv7.CUSTOMFIELDKEY = '8a131ecf4a0332c1014a09a74ad502dc'
LEFT JOIN customfieldvalue cfv8 ON cfv8.PARENTKEY = a.ENCODEDKEY AND cfv8.CUSTOMFIELDKEY = '2c9f80724d4c85bf014d4fd6775e000c'
LEFT JOIN customfieldvalue cfv9 ON cfv9.PARENTKEY = a.ENCODEDKEY AND cfv9.CUSTOMFIELDKEY = '8a131ecf4a0332c1014a09a515b9028c'
LEFT JOIN customfieldvalue cfv10 ON cfv10.PARENTKEY = a.ENCODEDKEY AND cfv10.CUSTOMFIELDKEY = '8a131ecf4a0332c1014a09a5b0680290'
LEFT JOIN customfieldvalue cfv11 ON cfv11.PARENTKEY = a.ENCODEDKEY AND cfv11.CUSTOMFIELDKEY = '8a131ecf4a0332c1014a09baffbe075a'
LEFT JOIN customfieldvalue cfv12 ON cfv12.PARENTKEY = a.ENCODEDKEY AND cfv12.CUSTOMFIELDKEY = '8a131ecf4a0332c1014a09f0484d1297'
WHERE
	loan.LOANAMOUNT - (
		SELECT
			SUM(loantrans.PRINCIPALAMOUNT)
		FROM
			loanaccount loan1
		LEFT JOIN loantransaction loantrans ON loan1.ENCODEDKEY = loantrans.PARENTACCOUNTKEY
		WHERE
			loan.id = loan1.id
		AND loantrans.TYPE NOT IN (
			'DISBURSMENT',
			'IMPORT',
			'DISBURSMENT_ADJUSTMENT',
			'REPAYMENT_ADJUSTMENT'
		)
		AND loantrans.REVERSALTRANSACTIONKEY IS NULL
		AND loantrans.ENTRYDATE <= '2015-12-31-24'
		AND (
			loan.DISBURSEMENTDATE <= '2015-12-31-24'
			OR loan.CLOSEDDATE >= '2015-12-31-24'
		)
		AND (
			(
				loan.DISBURSEMENTDATE <= '2015-12-31-24'
			)
			OR (
				loan.ACCOUNTSTATE IN ('CLOSED')
				AND loan.CLOSEDDATE > '2015-12-31-24'
			)
		)
		GROUP BY
			loan.ID
		HAVING
			COUNT(loan.ID) >= 1
	) > 0
AND (
	loan.DISBURSEMENTDATE <= '2015-12-31-24'
	OR loan.CLOSEDDATE >= '2015-12-31-24'
)
AND (
	(
		loan.DISBURSEMENTDATE <= '2015-12-31-24'
	)
	OR (
		loan.ACCOUNTSTATE IN ('CLOSED')
		AND loan.CLOSEDDATE >= '2015-12-31-24'
	)
)
GROUP BY
	loan.ID
HAVING
	COUNT(loan.ID) >= 1
ORDER BY
	bran. NAME,
	LnOfcrName
