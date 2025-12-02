SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_UpdateKosurat_Motalebat](@fieldname NVARCHAR(50),@status BIT ,@Id int,@DateActive INT,@userid INT)
as
--DECLARE @status BIT ,@Id int,@DateActive int
IF(@fieldname='Motalebat')
UPDATE Pay.tblMotalebateParametri_Personal
SET fldStatus=@status,fldDateDeactive=@DateActive,fldUserId=@userid ,fldDate=GETDATE()
WHERE fldId=@Id

IF(@fieldname='Kosurat')
UPDATE Pay.tblKosorateParametri_Personal
SET fldStatus=@status,fldDateDeactive=@DateActive,fldUserId=@userid ,fldDate=GETDATE()
WHERE fldId=@Id

IF(@fieldname='Kosurat_DateActive')
UPDATE Pay.tblKosorateParametri_Personal
SET fldDateDeactive=@DateActive,fldUserId=@userid ,fldDate=GETDATE()
WHERE fldId=@Id
GO
