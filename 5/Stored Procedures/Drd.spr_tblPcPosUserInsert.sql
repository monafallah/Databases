SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosUserInsert] 
    @fldPosIpId int,
    @fldIdUser int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)

    
AS 
	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblPcPosUser] 
	INSERT INTO [Drd].[tblPcPosUser] ([fldId], [fldPosIpId], [fldIdUser], [fldUserId], [fldDesc], [fldDate])
	SELECT  @fldID,  @fldPosIpId,@fldIdUser, @fldUserId, @fldDesc, getDate()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT TRAN
GO
