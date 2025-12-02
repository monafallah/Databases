SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblGHarardadBimeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldNameBime], [fldTarikhSHoro], [fldTarikhPayan] , [fldMablagheBimeSHodeAsli], [fldMablaghe60Sal], [fldMablaghe70Sal], [fldMablagheBimeOmr],[fldMaxBimeAsli], [fldDarsadBimeOmr], [fldDarsadBimeTakmily], [fldDarsadBime60Sal], [fldDarsadBime70Sal], [fldUserId], [fldDesc], [fldDate],Com.fn_maxbime ([fldMaxBimeAsli])as fldMaxBimeAsliName
	,fldMablagheBedonePoshesh,fldDarsadBimeBedonePoshesh
	FROM   [Pay].[tblGHarardadBime] 
	WHERE  fldId = @Value

		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldNameBime], [fldTarikhSHoro], [fldTarikhPayan] , [fldMablagheBimeSHodeAsli], [fldMablaghe60Sal], [fldMablaghe70Sal], [fldMablagheBimeOmr],[fldMaxBimeAsli], [fldDarsadBimeOmr], [fldDarsadBimeTakmily], [fldDarsadBime60Sal], [fldDarsadBime70Sal], [fldUserId], [fldDesc], [fldDate],Com.fn_maxbime ([fldMaxBimeAsli])as fldMaxBimeAsliName
	,fldMablagheBedonePoshesh,fldDarsadBimeBedonePoshesh
	FROM   [Pay].[tblGHarardadBime] 
	WHERE  fldDesc LIKE @Value
	
		if (@fieldname=N'fldNameBime')
	SELECT top(@h) [fldId], [fldNameBime], [fldTarikhSHoro], [fldTarikhPayan] , [fldMablagheBimeSHodeAsli], [fldMablaghe60Sal], [fldMablaghe70Sal], [fldMablagheBimeOmr],[fldMaxBimeAsli], [fldDarsadBimeOmr], [fldDarsadBimeTakmily], [fldDarsadBime60Sal], [fldDarsadBime70Sal], [fldUserId], [fldDesc], [fldDate],Com.fn_maxbime ([fldMaxBimeAsli])as fldMaxBimeAsliName
	,fldMablagheBedonePoshesh,fldDarsadBimeBedonePoshesh
	FROM   [Pay].[tblGHarardadBime] 
	WHERE  fldNameBime LIKE @Value
	order by fldid desc

		if (@fieldname=N'fldTarikhSHoro')
	SELECT top(@h) [fldId], [fldNameBime], [fldTarikhSHoro], [fldTarikhPayan] , [fldMablagheBimeSHodeAsli], [fldMablaghe60Sal], [fldMablaghe70Sal], [fldMablagheBimeOmr],[fldMaxBimeAsli], [fldDarsadBimeOmr], [fldDarsadBimeTakmily], [fldDarsadBime60Sal], [fldDarsadBime70Sal], [fldUserId], [fldDesc], [fldDate],Com.fn_maxbime ([fldMaxBimeAsli])as fldMaxBimeAsliName
	,fldMablagheBedonePoshesh,fldDarsadBimeBedonePoshesh
	FROM   [Pay].[tblGHarardadBime] 
	WHERE  fldTarikhSHoro LIKE @Value
	order by fldid desc
	
		if (@fieldname=N'fldTarikhPayan')
	SELECT top(@h) [fldId], [fldNameBime], [fldTarikhSHoro], [fldTarikhPayan] , [fldMablagheBimeSHodeAsli], [fldMablaghe60Sal], [fldMablaghe70Sal], [fldMablagheBimeOmr],[fldMaxBimeAsli], [fldDarsadBimeOmr], [fldDarsadBimeTakmily], [fldDarsadBime60Sal], [fldDarsadBime70Sal], [fldUserId], [fldDesc], [fldDate],Com.fn_maxbime ([fldMaxBimeAsli])as fldMaxBimeAsliName
	,fldMablagheBedonePoshesh,fldDarsadBimeBedonePoshesh
	FROM   [Pay].[tblGHarardadBime] 
	WHERE  fldTarikhPayan LIKE @Value
	order by fldid desc
	
		if (@fieldname=N'fldMablagheBimeSHodeAsli')
	SELECT top(@h) [fldId], [fldNameBime], [fldTarikhSHoro], [fldTarikhPayan] , [fldMablagheBimeSHodeAsli], [fldMablaghe60Sal], [fldMablaghe70Sal], [fldMablagheBimeOmr],[fldMaxBimeAsli], [fldDarsadBimeOmr], [fldDarsadBimeTakmily], [fldDarsadBime60Sal], [fldDarsadBime70Sal], [fldUserId], [fldDesc], [fldDate],Com.fn_maxbime ([fldMaxBimeAsli])as fldMaxBimeAsliName
	,fldMablagheBedonePoshesh,fldDarsadBimeBedonePoshesh
	FROM   [Pay].[tblGHarardadBime] 
	WHERE  fldMablagheBimeSHodeAsli LIKE @Value
	order by fldid desc

	if (@fieldname=N'fldMablagheBimeOmr')
	SELECT top(@h) [fldId], [fldNameBime], [fldTarikhSHoro], [fldTarikhPayan] , [fldMablagheBimeSHodeAsli], [fldMablaghe60Sal], [fldMablaghe70Sal], [fldMablagheBimeOmr],[fldMaxBimeAsli], [fldDarsadBimeOmr], [fldDarsadBimeTakmily], [fldDarsadBime60Sal], [fldDarsadBime70Sal], [fldUserId], [fldDesc], [fldDate],Com.fn_maxbime ([fldMaxBimeAsli])as fldMaxBimeAsliName
	,fldMablagheBedonePoshesh,fldDarsadBimeBedonePoshesh
	FROM   [Pay].[tblGHarardadBime] 
	WHERE  fldMablagheBimeOmr LIKE @Value
	order by fldid desc


	if (@fieldname=N'fldNotId')
	SELECT top(@h) [fldId], [fldNameBime], [fldTarikhSHoro], [fldTarikhPayan], [fldMablagheBimeSHodeAsli], [fldMablaghe60Sal], [fldMablaghe70Sal], [fldMablagheBimeOmr],[fldMaxBimeAsli], [fldDarsadBimeOmr], [fldDarsadBimeTakmily], [fldDarsadBime60Sal], [fldDarsadBime70Sal], [fldUserId], [fldDesc], [fldDate],Com.fn_maxbime ([fldMaxBimeAsli])as fldMaxBimeAsliName
	,fldMablagheBedonePoshesh,fldDarsadBimeBedonePoshesh
	FROM   [Pay].[tblGHarardadBime]  
	WHERE  fldId <> @Value
	order by fldid desc
    
	if (@fieldname=N'FromCopy')
	SELECT top(@h) [fldId], [fldNameBime], [fldTarikhSHoro], [fldTarikhPayan], [fldMablagheBimeSHodeAsli], [fldMablaghe60Sal], [fldMablaghe70Sal], [fldMablagheBimeOmr],[fldMaxBimeAsli], [fldDarsadBimeOmr], [fldDarsadBimeTakmily], [fldDarsadBime60Sal], [fldDarsadBime70Sal], [fldUserId], [fldDesc], [fldDate],Com.fn_maxbime ([fldMaxBimeAsli])as fldMaxBimeAsliName
	,fldMablagheBedonePoshesh,fldDarsadBimeBedonePoshesh
	FROM   [Pay].[tblGHarardadBime]  
	WHERE  exists (select * from pay.tblAfradeTahtePoshesheBimeTakmily where fldGHarardadBimeId=tblGHarardadBime.fldId)
	order by fldId desc

	if (@fieldname=N'ToCopy')
	SELECT top(@h) [fldId], [fldNameBime], [fldTarikhSHoro], [fldTarikhPayan], [fldMablagheBimeSHodeAsli], [fldMablaghe60Sal], [fldMablaghe70Sal], [fldMablagheBimeOmr],[fldMaxBimeAsli], [fldDarsadBimeOmr], [fldDarsadBimeTakmily], [fldDarsadBime60Sal], [fldDarsadBime70Sal], [fldUserId], [fldDesc], [fldDate],Com.fn_maxbime ([fldMaxBimeAsli])as fldMaxBimeAsliName
	,fldMablagheBedonePoshesh,fldDarsadBimeBedonePoshesh
	FROM   [Pay].[tblGHarardadBime]  
	WHERE not exists  (select * from pay.tblAfradeTahtePoshesheBimeTakmily where fldGHarardadBimeId=tblGHarardadBime.fldId)
	order by fldId desc


	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldNameBime], [fldTarikhSHoro], [fldTarikhPayan], [fldMablagheBimeSHodeAsli], [fldMablaghe60Sal], [fldMablaghe70Sal], [fldMablagheBimeOmr],[fldMaxBimeAsli], [fldDarsadBimeOmr], [fldDarsadBimeTakmily], [fldDarsadBime60Sal], [fldDarsadBime70Sal], [fldUserId], [fldDesc], [fldDate],Com.fn_maxbime ([fldMaxBimeAsli])as fldMaxBimeAsliName
	,fldMablagheBedonePoshesh,fldDarsadBimeBedonePoshesh
	FROM   [Pay].[tblGHarardadBime] 
	order by fldid desc

	COMMIT
GO
