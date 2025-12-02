SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_selectAccountingLevel]
@fldYear smallint,
@fldOrganId int 

AS 
BEGIN tran
DECLARE @temp TABLE(fldId int,fldOrganId INT,fldYear SMALLINT,fldArghamNum int,fldName nvarchar(100))

INSERT @temp 
SELECT fldId,fldOrganId,fldYear,fldArghamNum,fldName FROM ACC.tblAccountingLevel WHERE fldYear=@fldYear AND fldOrganId=@fldOrganId



IF EXISTS(select * from @temp)
SELECT  * FROM @temp

ELSE 
  BEGIN 
INSERT  INTO @temp 
VALUES (0,@fldOrganId,@fldYear,1,N'اصلی'),(0,@fldOrganId,@fldYear,1,N'گروه'),(0,@fldOrganId,@fldYear,1,N'کل'),(0,@fldOrganId,@fldYear,1,N'معین')--,(@fldOrganId,@fldYear,1,N'تفصیلی 1')
SELECT * FROM @temp
end


COMMIT
GO
