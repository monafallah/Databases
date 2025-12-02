SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [Drd].[spr_UpdateStatusSanad]

@type tinyint,
@Id int,
@fldStatus tinyint,
@fldDateStatus nvarchar(10),
@fldUserId int

AS
BEGIN TRAN
declare @fldID int
if(@type=2)
 begin

	select @fldID =ISNULL(max(fldId),0)+1 from [chk].tblCheckStatus 
	INSERT INTO [chk].tblCheckStatus ([fldId], fldSodorCheckId,fldCheckVaredeId,fldAghsatId,fldVaziat,fldTarikh, [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId,NULL , @id, NULL, @fldStatus, isnull(@fldDateStatus,dbo.Fn_AssembelyMiladiToShamsi(getdate())),  @fldUserId,  N'درآمد', GETDATE()
	if (@@ERROR<>0)
		ROLLBACK
 
 UPDATE [Drd].[tblCheck]
	SET    [fldStatus] = @fldStatus , [fldUserId] = @fldUserId,fldDateStatus=@fldDateStatus
	WHERE  [fldId] = @id
 end

else if(@type=3)
begin
UPDATE [Drd].[tblSafte]
	SET    [fldStatus] = @fldStatus , [fldUserId] = @fldUserId,fldDateStatus=@fldDateStatus
	WHERE  [fldId] = @id


end

else if(@type=4)
begin
UPDATE [Drd].[tblBarat]
	SET    [fldStatus] = @fldStatus , [fldUserId] = @fldUserId,fldDateStatus=@fldDateStatus
	WHERE  [fldId] = @id
end

else if(@type=6)
begin

	select @fldID =ISNULL(max(fldId),0)+1 from [chk].tblCheckStatus 
	INSERT INTO [chk].tblCheckStatus ([fldId], fldSodorCheckId,fldCheckVaredeId,fldAghsatId,fldVaziat,fldTarikh, [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId,NULL , @id, NULL, @fldStatus, isnull(@fldDateStatus,dbo.Fn_AssembelyMiladiToShamsi(getdate())),  @fldUserId,  N'درآمد', GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

 UPDATE [Drd].[tblCheck]
	SET    [fldStatus] = @fldStatus , [fldUserId] = @fldUserId,fldDateStatus=@fldDateStatus
	WHERE  [fldId] = @id

end

COMMIT
GO
