SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblGHarardadBimeUpdate] 
    @fldId int,
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
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblGHarardadBime]
	SET    [fldId] = @fldId, [fldNameBime] = @fldNameBime, [fldTarikhSHoro] = @fldTarikhSHoro, [fldTarikhPayan] = @fldTarikhPayan, [fldMablagheBimeSHodeAsli] = @fldMablagheBimeSHodeAsli, [fldMablaghe60Sal] = @fldMablaghe60Sal, [fldMablaghe70Sal] = @fldMablaghe70Sal, [fldMablagheBimeOmr] = @fldMablagheBimeOmr, [fldMaxBimeAsli] = @fldMaxBimeAsli, [fldDarsadBimeOmr] = @fldDarsadBimeOmr, [fldDarsadBimeTakmily] = @fldDarsadBimeTakmily, [fldDarsadBime60Sal] = @fldDarsadBime60Sal, [fldDarsadBime70Sal] = @fldDarsadBime70Sal, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	,fldMablagheBedonePoshesh=@fldMablagheBedonePoshesh,fldDarsadBimeBedonePoshesh=@fldDarsadBimeBedonePoshesh
	    WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
