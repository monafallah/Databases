SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [dbo].[prs_IsPickDate]
 @Tarikh NVARCHAR(10)
 AS
 BEGIN TRAN
--DECLARE @Tarikh NVARCHAR(10)='1397/01/12'
DECLARE @Value NVARCHAR(4)=SUBSTRING(@Tarikh,1,4)
DECLARE @YearIslamic int='',@Month INT='',@Islamic NVARCHAR(10),@Day NVARCHAR(2)='',@fldTypePick BIT,@Zarib DECIMAL(4,2),@Type TINYINT
SELECT @Islamic=dbo.UDateConvert_Persian2Islamic(@Value+'/01/01','/')
		SELECT @YearIslamic=Item FROM dbo.Split(@Islamic,'/') WHERE Id=1
		SELECT @Month=Item FROM dbo.Split(@Islamic,'/') WHERE Id=2

		SELECT  @fldTypePick=fldTypePick FROM (SELECT  [fldTypePick]
		,CASE WHEN( fldDateType=0) THEN @Value+'/'+CAST( fldMonth AS NVARCHAR(2))+'/'+CAST(fldDay AS NVARCHAR(2))   
		WHEN fldDateType=1 AND @Month<fldMonth THEN  dbo.UDateConvert_Islamic2Persian((CAST(@YearIslamic AS NVARCHAR(4)) +'/'+CAST( fldMonth AS NVARCHAR(2))+'/'+CAST(fldDay AS NVARCHAR(2))),'/' )
		WHEN fldDateType=1 AND @Month>fldMonth THEN dbo.UDateConvert_Islamic2Persian((CAST(@YearIslamic+1 AS NVARCHAR(4)) +'/'+CAST( fldMonth AS NVARCHAR(2))+'/'+CAST(fldDay AS NVARCHAR(2)) ),'/' )
		WHEN fldDateType=1 AND @Month=fldMonth AND @Day<=fldDay THEN dbo.UDateConvert_Islamic2Persian((CAST(@YearIslamic AS NVARCHAR(4)) +'/'+CAST( fldMonth AS NVARCHAR(2))+'/'+CAST(fldDay AS NVARCHAR(2)) ),'/' )
		WHEN fldDateType=1 AND @Month=fldMonth AND @Day>fldDay THEN dbo.UDateConvert_Islamic2Persian((CAST(@YearIslamic+1 AS NVARCHAR(4)) +'/'+CAST( fldMonth AS NVARCHAR(2))+'/'+CAST(fldDay AS NVARCHAR(2)) ),'/' )END AS fldTarikh
		FROM   [dbo].[tblPick] )t
		WHERE t.fldTarikh=@Tarikh
		IF(@fldTypePick IS NULL)
		BEGIN
			SELECT @fldTypePick=fldTypePick FROM dbo.tblHolidaysOther
			WHERE fldTarikh=@Tarikh		
		END 
		IF(@fldTypePick IS NULL)
		BEGIN
			SET @Zarib=1
			SET @Type=0
		END 
		ELSE IF(@fldTypePick=1)
		BEGIN
			SET @Zarib=1.25
			SET @Type=1
		END  
		ELSE IF(@fldTypePick=0)
		BEGIN
			SET @Zarib=1.5
			SET @Type=2
		END
		SELECT @Zarib AS fldZarib,@Type AS fldType
		COMMIT TRAN
GO
