SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [chk].[spr_tblCheckStatusInsert] 

    @fldSodorCheckId int,
    @fldCheckVaredeId int,
    @fldAghsatId int,
    @fldStatus tinyint,
    @fldTarikh nvarchar(50),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [chk].tblCheckStatus 
	INSERT INTO [chk].tblCheckStatus ([fldId], fldSodorCheckId,fldCheckVaredeId,fldAghsatId,fldVaziat,fldTarikh, [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldSodorCheckId, @fldCheckVaredeId, @fldAghsatId, @fldStatus, @fldTarikh,  @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	if (@fldCheckVaredeId is not null)
	begin
	update drd.tblCheck
	set fldStatus=@fldStatus ,fldDateStatus=@fldTarikh
	where fldid=@fldCheckVaredeId
	if (@@ERROR<>0)
		ROLLBACK
	end
	COMMIT
GO
