SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_selectAccountingTypeLevel] 
@fldAccountTypeId INT 

AS
 BEGIN TRAN
DECLARE @temp TABLE (fldId INT,fldAccountTypeId INT ,fldArghumNum int,fldName NVARCHAR(100))
INSERT @temp

SELECT fldId ,fldAccountTypeId,fldArghumNum,fldName FROM ACC.tblLevelsAccountingType
WHERE fldAccountTypeId=@fldAccountTypeId

IF EXISTS (SELECT * FROM @temp)
SELECT * FROM @temp

ELSE 
BEGIN 
INSERT @temp
VALUES (0,@fldAccountTypeId,1,N'اصلی'),(0,@fldAccountTypeId,1,N'گروه'),(0,@fldAccountTypeId,1,N'کل'),(0,@fldAccountTypeId,1,N'معین')
SELECT * FROM @temp
end

commit
GO
