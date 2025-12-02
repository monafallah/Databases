SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCodhayeDaramdUpdate] 
  
    @fldId int,
    @fldDaramadCode varchar(50),
    @fldDaramadTitle nvarchar(250),
    @fldMashmooleArzesheAfzoode bit,
    @fldMashmooleKarmozd bit,
   @fldAmuzeshParvaresh bit,
	@fldUnitId int ,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
   
AS 
	BEGIN TRAN
	set  @fldDaramadCode=com.fn_TextNormalize( @fldDaramadCode)
	set  @fldDaramadTitle=com.fn_TextNormalize(@fldDaramadTitle)
	set  @fldDesc=com.fn_TextNormalize( @fldDesc)
	UPDATE [Drd].[tblCodhayeDaramd]
	SET   [fldDaramadCode] = @fldDaramadCode, [fldDaramadTitle] = @fldDaramadTitle, [fldMashmooleArzesheAfzoode] = @fldMashmooleArzesheAfzoode, [fldMashmooleKarmozd] = @fldMashmooleKarmozd, [fldUnitId]=@fldUnitId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	,fldAmuzeshParvaresh=@fldAmuzeshParvaresh
	WHERE   [fldId] = @fldId
	COMMIT TRAN
GO
