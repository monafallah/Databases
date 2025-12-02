SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblContractsDelete] 
@fldID int,
@fldUserID int
AS 
begin try
	BEGIN TRAN
	declare @ErrorId int
	delete from [cntr].tblContract_CodingBudje
	where fldContractId=@fldID


	UPDATE [cntr].[tblContracts]
	SET    fldUserId=@fldUserId,flddate=getdate()
	WHERE  fldId=@fldId
	

	  DELETE
	  FROM   [cntr].[tblContracts]
	  where  fldId =@fldId
	 
	COMMIT
end try
begin catch
rollback 
 select @ErrorId= max(fldid)+1 from com.tblError
 insert into com.tblError(fldid,fldMatn,fldTarikh,fldUserName,fldUserId,fldIP,fldDesc,fldDate)
 select @ErrorId,ERROR_MESSAGE(),cast(getdate() as date ) ,fldUserName,@fldUserId,'','',getdate() from com.tblUser where fldid=@fldUserId

end catch
GO
