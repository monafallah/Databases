SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create FUNCTION [Drd].[fn_SumMablaghNaghdiVariz](@fieldName NVARCHAR(50),@fldReplyTaghsitId int,@fldShomareHesabId int,@AzTarikh nvarchar(10),@Tatarikh nvarchar(10))
RETURNS BIGINT
AS
BEGIN
DECLARE @Mablagh BIGINT=0,@s date =com.shamsitomiladi(@AzTarikh),@e date =com.shamsitomiladi(@Tatarikh)
IF(@fieldName=N'Naghdi_Talab')
	--SELECT DISTINCT @Mablagh= SUM(cast (fldMablagh AS BIGINT)) OVER (PARTITION BY tblNaghdi_Talab.fldShomareHesabId)  FROM Drd.tblNaghdi_Talab
	--	WHERE fldReplyTaghsitId=@fldReplyTaghsitId AND fldShomareHesabId=@fldShomareHesabId and
	--	tblNaghdi_Talab.fldFishId in (select tblPardakhtFish.fldFishId from drd.tblPardakhtFish where fldDatePardakht between @s and @e and tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId)
	SELECT DISTINCT @Mablagh= SUM(cast (fldMablagh AS BIGINT)) OVER (PARTITION BY tblNaghdi_Talab.fldShomareHesabId)  FROM Drd.tblNaghdi_Talab
		WHERE fldFishId=@fldReplyTaghsitId AND fldShomareHesabId=@fldShomareHesabId and
		tblNaghdi_Talab.fldFishId in (select tblPardakhtFish.fldFishId from drd.tblPardakhtFish where fldDateVariz between @s and @e and tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId)


IF(@fieldName=N'Check')
	--SELECT DISTINCT @Mablagh= SUM(CAST(fldMablaghSanad AS BIGINT)) OVER (PARTITION BY fldShomareHesabIdOrgan,fldDateStatus)  FROM Drd.tblCheck
	--WHERE fldReplyTaghsitId=@fldReplyTaghsitId AND fldStatus=2 and fldShomareHesabIdOrgan=@fldShomareHesabId and fldDateStatus between @azTarikh and @TaTarikh

	select @Mablagh=fldMablaghSanad   FROM Drd.tblCheck
	WHERE fldid=@fldReplyTaghsitId AND fldStatus=2 and fldShomareHesabIdOrgan=@fldShomareHesabId and fldDateStatus between @azTarikh and @TaTarikh


IF(@fieldName=N'Safte')
	SELECT DISTINCT @Mablagh= SUM(CAST(fldMablaghSanad AS BIGINT))  FROM Drd.tblSafte
	WHERE fldReplyTaghsitId=@fldReplyTaghsitId   and fldStatus=2 and fldDateStatus between @azTarikh and @TaTarikh

IF(@fieldName=N'Barat')
	SELECT DISTINCT @Mablagh= SUM(CAST(fldMablaghSanad AS BIGINT))  FROM Drd.tblBarat
	WHERE fldReplyTaghsitId=@fldReplyTaghsitId   and fldStatus=2 and fldDateStatus between @azTarikh and @TaTarikh
	 

RETURN @Mablagh
END
GO
