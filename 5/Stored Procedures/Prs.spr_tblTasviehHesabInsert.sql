SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblTasviehHesabInsert] 
    @fldPrsPersonalInfoId int,
    @fldTarikh char(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 

	
	BEGIN TRAN
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblTasviehHesab] 

	INSERT INTO [Prs].[tblTasviehHesab] ([fldId], [fldPrsPersonalInfoId], [fldTarikh], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldPrsPersonalInfoId, @fldTarikh, @fldUserId, @fldDesc, GETDATE()
	if(@@Error<>0)
        rollback       
	COMMIT
GO
