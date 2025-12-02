SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblFactorDelete] 
    @fldId int,
	@fldUserId int
AS 
	
	begin try
	BEGIN TRAN
	declare @er int
	UPDATE [Cntr].[tblFactor]
	SET    fldUserId=@fldUserId,fldDate=getdate()
	WHERE  [fldId] = @fldId
	
	DELETE
	FROM   [Cntr].[tblFactorDetail]
	WHERE  fldHeaderId = @fldId


	DELETE
	FROM   [Cntr].tblFactorMostaghel
	WHERE  fldFactorId = @fldId


	DELETE
	FROM   [Cntr].tblContract_Factor
	WHERE  fldFactorId = @fldId
	

	DELETE
	FROM   [Cntr].[tblFactor]
	WHERE  [fldId] = @fldId
	
	COMMIT
	end try

begin catch
 rollback
select @er=max(fldid)+1 from com.tblError
insert into com. tblError([fldId], [fldUserName], [fldMatn], [fldTarikh], [fldIP], [fldUserId], [fldDesc], [fldDate])
	SELECT @er, fldUserName, ERROR_MESSAGE(), cast(GETDATE() as date), '', @fldUserId, 'deletefactor', GETDATE()
	from com.tblUser where fldid=@fldUserId

end catch
GO
