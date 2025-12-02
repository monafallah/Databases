SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListGheybat_Karkard](@fieldname NVARCHAR(50),@sal SMALLINT,@OrganId INT)
AS
IF (@fieldname='Karkard')
SELECT  [Name_Family],[fldStatus],ISNULL([1],0)[1],ISNULL([2],0)[2],ISNULL([3],0)[3],ISNULL([4],0)[4],ISNULL([5],0)[5],ISNULL([6],0)[6],
ISNULL([7],0)[7],ISNULL([8],0)[8],ISNULL([9],0)[9],ISNULL([10],0)[10],ISNULL([11],0)[11],ISNULL([12],0)[12] FROM 
(SELECT   Com.fn_NameFamily_Employee(Pay.Pay_tblPersonalInfo.fldid)AS [Name_Family],fldMah,fldKarkard,
Com.fn_MaxPersonalStatus(fldPersonalId,'hoghoghi') AS [fldStatus]
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId 
                      WHERE fldYear=@sal AND Com.fn_organIdWithPayPersonal(Pay.Pay_tblPersonalInfo.fldId)=@OrganId)t
PIVOT( MAX(fldKarkard)
FOR fldMah in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]))AS p


IF (@fieldname='GHeybat')
SELECT  [Name_Family],[fldStatus],ISNULL([1],0)[1],ISNULL([2],0)[2],ISNULL([3],0)[3],ISNULL([4],0)[4],ISNULL([5],0)[5],ISNULL([6],0)[6],
ISNULL([7],0)[7],ISNULL([8],0)[8],ISNULL([9],0)[9],ISNULL([10],0)[10],ISNULL([11],0)[11],ISNULL([12],0)[12] FROM 
(SELECT   Com.fn_NameFamily_Employee(Pay.Pay_tblPersonalInfo.fldid)AS [Name_Family],fldMah,fldGheybat,
 Com.fn_MaxPersonalStatus(fldPersonalId,'hoghoghi') AS [fldStatus]
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId
                       WHERE fldYear=@sal AND Com.fn_organIdWithPayPersonal(Pay.Pay_tblPersonalInfo.fldId)=@OrganId)t
PIVOT( MAX(fldGheybat)
FOR fldMah in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]))AS p
GO
