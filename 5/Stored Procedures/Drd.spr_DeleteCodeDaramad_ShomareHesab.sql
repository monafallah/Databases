SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_DeleteCodeDaramad_ShomareHesab](@CodeDaramad INT)
AS
BEGIN TRAN
DECLARE @flag BIT=0
delete  f 
from drd.tblShomareHesab_Formula  f 
inner join drd.tblShomareHesabCodeDaramad s on s.fldid=fldShomareHesab_CodeId
where  fldCodeDaramadId=@CodeDaramad 
 IF(@@ERROR<>0)
BEGIN
	SET @flag=1
	ROLLBACK
END
IF(@flag=0)
BEGIN
	DELETE FROM Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=@CodeDaramad 
	IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
end
IF(@flag=0)
BEGIN
	DELETE FROM Drd.tblShomareHedabCodeDaramd_Detail WHERE fldCodeDaramdId=@CodeDaramad 
	IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
end
IF(@flag=0)
BEGIN
DELETE FROM Drd.tblCodhayeDaramd WHERE fldId=@CodeDaramad
IF(@@ERROR<>0)
BEGIN
	
	ROLLBACK
END
end
COMMIT
GO
