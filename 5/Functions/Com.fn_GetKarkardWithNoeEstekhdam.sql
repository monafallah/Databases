SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_GetKarkardWithNoeEstekhdam](@PersonalId INT,@sal SMALLINT,@mah TINYINT)
RETURNS TINYINT
AS 
BEGIN
--DECLARE @PersonalId INT=14,@sal SMALLINT =1397,@mah TINYINT=6,@prs INT,@NoeEstekhdamId  INT,@k TINYINT=0
DECLARE @prs INT,@NoeEstekhdamId  INT,@k TINYINT=0
SELECT @prs=fldPrs_PersonalInfoId FROM Pay.Pay_tblPersonalInfo WHERE fldId=@PersonalId
SELECT     TOP (1) @NoeEstekhdamId=Com.tblAnvaEstekhdam.fldNoeEstekhdamId 
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
WHERE fldPrsPersonalInfoId=@prs
 ORDER BY tblHistoryNoeEstekhdam.fldDate DESC
 --select 
 IF(@NoeEstekhdamId=1)
 BEGIN
 	IF (@mah<=6)
 	SET @k=31
 	ELSE IF (@mah<=11)
 	SET @k=30
	ELSE 
	BEGIN
		IF(com.fn_IsKabise(@sal)=1)
		SET @k=30
		ELSE
		SET @k=29
		
	END
  END
   else
   begin
 SET @k=30
 end
  --SELECT @k
 RETURN @k
 end
GO
