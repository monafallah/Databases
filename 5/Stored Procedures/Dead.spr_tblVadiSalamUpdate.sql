SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblVadiSalamUpdate] 
    @fldId int,
    @fldName nvarchar(100),
    @fldStateId int,
    @fldCityId int,
	@fldOrganId int,
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
	UPDATE [Dead].[tblVadiSalam]
	SET    [fldName] = @fldName, [fldStateId] = @fldStateId,fldorganid=@fldOrganId, [fldCityId] = @fldCityId, [fldAddress] = @fldAddress, [fldLatitude] = @fldLatitude, [fldLongitude] = @fldLongitude, [fldDate] = GETDATE(), [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
