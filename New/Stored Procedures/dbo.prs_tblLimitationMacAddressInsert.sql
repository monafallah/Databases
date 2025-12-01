SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblLimitationMacAddressInsert] 

    @fldUserLimId int,
    @fldMacValid varchar(100),
    @fldDesc nvarchar(100),
	@inputId int
AS 

	
	BEGIN TRAN
	set @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblLimitationMacAddress] 

	INSERT INTO [dbo].[tblLimitationMacAddress] ([fldId], [fldUserLimId], [fldMacValid], [fldDesc])
	SELECT @fldId, @fldUserLimId, @fldMacValid, @fldDesc
	if(@@Error<>0)
     begin 
	    rollback   
		end
	
	COMMIT
GO
