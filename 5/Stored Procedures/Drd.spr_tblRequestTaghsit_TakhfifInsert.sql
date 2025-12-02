SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblRequestTaghsit_TakhfifInsert] 
  
	@fldID INT OUT,
    @fldElamAvarezId int,
    @fldRequestType tinyint,
    @fldEmployeeId int,
    @fldAddress nvarchar(MAX),
    @fldEmail nvarchar(150),
    @fldCodePosti nvarchar(10),
    @fldMobile nvarchar(11),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	set  @fldAddress=com.fn_TextNormalize(@fldAddress)
	set  @fldEmail=com.fn_TextNormalize(@fldEmail)
	set  @fldCodePosti=com.fn_TextNormalize(@fldCodePosti)
	set  @fldMobile=com.fn_TextNormalize(@fldMobile)
	set  @fldDesc=com.fn_TextNormalize(@fldDesc)
	--declare  
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblRequestTaghsit_Takhfif] 
	INSERT INTO [Drd].[tblRequestTaghsit_Takhfif] ([fldId], [fldElamAvarezId], [fldRequestType], [fldEmployeeId], [fldAddress], [fldEmail], [fldCodePosti], [fldMobile], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldElamAvarezId, @fldRequestType, @fldEmployeeId, @fldAddress, @fldEmail, @fldCodePosti, @fldMobile, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
