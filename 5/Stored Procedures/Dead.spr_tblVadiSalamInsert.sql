SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblVadiSalamInsert] 
    @fldName nvarchar(100),
    @fldStateId int,
    @fldCityId int,
	@fldOrganId  int,
    @fldAddress nvarchar(200),
    @fldLatitude varchar(50),
    @fldLongitude varchar(50),
    @fldUserID int,
    @fldDesc nvarchar(100),
    @fldIP varchar(15)
AS 

	
	BEGIN TRAN
	set @fldName=com.fn_TextNormalize(@fldName)
	set @fldAddress=com.fn_TextNormalize(@fldAddress)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Dead].[tblVadiSalam] 

	INSERT INTO [Dead].[tblVadiSalam] ([fldId], [fldName], [fldStateId], [fldCityId],fldOrganId, [fldAddress], [fldLatitude], [fldLongitude], [fldDate], [fldUserID], [fldDesc], [fldIP])
	SELECT @fldId, @fldName, @fldStateId, @fldCityId,@fldOrganId, @fldAddress, @fldLatitude, @fldLongitude, GETDATE(), @fldUserID, @fldDesc, @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
