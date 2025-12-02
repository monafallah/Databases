SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [Pay].[prs_tblCalcDetailSelect]
@fldHeaderId int
as
	SELECT        e.fldFamily+N'_'+e.fldName as fldName , e.fldCodeMeli,
				  prs.fldSh_Personali, ed.fldFatherName, 
				 Com.fn_stringDecode(o.fldName) AS fldOrganName, a.fldTitle as fldEstekhdamName,isnull(c.fldTitle,'')fldCostcenterName
	FROM            tblCalcDetail as d
							 inner join pay.tblCalcHeader as h on h.fldId=d.fldHeaderId
							 INNER JOIN pay.Pay_tblPersonalInfo as p ON d.fldPersonalId = p.fldid 
							 inner join prs.Prs_tblPersonalInfo as prs on prs.fldId=p.fldPrs_PersonalInfoId
							 inner join com.tblEmployee as e on e.fldId=prs.fldEmployeeId
							 inner join com.tblEmployee_Detail as ed on ed.fldEmployeeId=e.fldId
							 INNER JOIN com.tblOrganization as o ON h.fldOrganId = o.fldId 
							 INNER JOIN com.tblAnvaEstekhdam as a ON d.fldTypeEstekhdamId = a.fldId
							 inner join pay.tblCostCenter as c on c.fldId=d.fldCostCenterId
	where fldHeaderId=@fldHeaderId
GO
