SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_ShomareHesabIdForXmlInput](@ShomareHesab NVARCHAR(50),@InfBank NVARCHAR(5),@AshkhasId INT,@UserId int)
AS
BEGIN TRAN
--DECLARE @ShomareHesab nVARCHAR(50)='100789728770',@InfBank NVARCHAR(5)='cty',@AshkhasId INT=13,@UserId INT=1
DECLARE @idbank INT,@IdShomareHesab INT,@fldID INT=0,@idshobe INT
SELECT @idbank=fldId FROM Com.tblBank WHERE fldInfinitiveBank=@InfBank
SELECT TOP(1) @idshobe=fldId FROM Com.tblSHobe WHERE fldBankId=@idbank AND fldName LIKE N'%مرکزی%'
SELECT @fldID=tblShomareHesabeOmoomi.fldId FROM Com.tblShomareHesabeOmoomi WHERE fldShomareHesab=@ShomareHesab AND fldShobeId IN (SELECT tblSHobe.fldid FROM Com.tblSHobe WHERE fldBankId=@idbank)
AND fldAshkhasId=@AshkhasId
--SELECT @fldID
IF(@fldID=0)
BEGIN
	select @fldID =ISNULL(max(fldId),0)+1 from Com.tblShomareHesabeOmoomi
	INSERT INTO Com.tblShomareHesabeOmoomi( fldId ,fldShobeId ,fldAshkhasId ,fldShomareHesab ,fldShomareSheba ,fldUserId ,fldDesc ,fldDate)
	SELECT @fldID,@idshobe,@AshkhasId,@ShomareHesab,Null,@UserId,'',GETDATE()
	IF(@@ERROR<>0)
	ROLLBACK
END
SELECT @fldID AS fldId
COMMIT
GO
