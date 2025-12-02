SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Com].[spr_MaxPersonalEstekhdamType](@FieldName NVARCHAR(50),@prs_fldPersonalId INT,@Tarikh NVARCHAR(10))
as
BEGIN TRAN
IF(@FieldName='')
SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId, ISNULL(Com.tblAnvaEstekhdam.fldTitle, '') AS fldTitle, 
                      ISNULL(Com.tblAnvaEstekhdam.fldNoeEstekhdamId, 0) AS fldNoeEstekhdamId, ISNULL(Prs.tblHistoryNoeEstekhdam.fldTarikh, '') AS fldTarikh
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = @prs_fldPersonalId)
ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
IF(@FieldName='Tarikh')
SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId, ISNULL(Com.tblAnvaEstekhdam.fldTitle, '') AS fldTitle, 
                      ISNULL(Com.tblAnvaEstekhdam.fldNoeEstekhdamId, 0) AS fldNoeEstekhdamId, ISNULL(Prs.tblHistoryNoeEstekhdam.fldTarikh, '') AS fldTarikh
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = @prs_fldPersonalId) AND fldTarikh<=@Tarikh
ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
COMMIT
GO
