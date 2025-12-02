SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblGHarardadBimeInsert] 
  
    @fldNameBime nvarchar(50),
    @fldTarikhSHoro nvarchar(10),
    @fldTarikhPayan nvarchar(10),
    @fldMablagheBimeSHodeAsli int,
    @fldMablaghe60Sal int,
    @fldMablaghe70Sal int,
    @fldMablagheBimeOmr int,
    @fldMaxBimeAsli tinyint,
    @fldDarsadBimeOmr int,
    @fldDarsadBimeTakmily int,
    @fldDarsadBime60Sal int,
    @fldDarsadBime70Sal int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldMablagheBedonePoshesh	int	,
@fldDarsadBimeBedonePoshesh	int	
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblGHarardadBime] 
	INSERT INTO [Pay].[tblGHarardadBime] ([fldId], [fldNameBime], [fldTarikhSHoro], [fldTarikhPayan], [fldMablagheBimeSHodeAsli], [fldMablaghe60Sal], [fldMablaghe70Sal], [fldMablagheBimeOmr], [fldMaxBimeAsli], [fldDarsadBimeOmr], [fldDarsadBimeTakmily], [fldDarsadBime60Sal], [fldDarsadBime70Sal], [fldUserId], [fldDesc], [fldDate],fldMablagheBedonePoshesh,fldDarsadBimeBedonePoshesh)
	SELECT @fldId, @fldNameBime, @fldTarikhSHoro, @fldTarikhPayan, @fldMablagheBimeSHodeAsli, @fldMablaghe60Sal, @fldMablaghe70Sal, @fldMablagheBimeOmr, @fldMaxBimeAsli, @fldDarsadBimeOmr, @fldDarsadBimeTakmily, @fldDarsadBime60Sal, @fldDarsadBime70Sal, @fldUserId, @fldDesc, GETDATE(),@fldMablagheBedonePoshesh,@fldDarsadBimeBedonePoshesh
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
