SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_DeleteTaghsit](@elamAvareId INT,@userId INT)
AS
begin try
	BEGIN TRAN
DECLARE @replyid INT,@IdError int

SELECT @replyid=fldId FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId=@elamAvareId 


delete  s 
from chk.tblCheckStatus s inner join 
drd.tblCheck c on c.fldid=s.fldCheckVaredeId
where fldReplyTaghsitId=@replyid


UPDATE Drd.tblCheck 
SET fldUserId=@userId,fldDate=GETDATE()
WHERE fldReplyTaghsitId=@replyid

DELETE FROM Drd.tblCheck 
WHERE fldReplyTaghsitId=@replyid

UPDATE  Drd.tblSafte
SET fldUserId=@userId,fldDate=GETDATE()
WHERE fldReplyTaghsitId=@replyid

DELETE FROM Drd.tblSafte
WHERE fldReplyTaghsitId=@replyid

UPDATE Drd.tblBarat 
SET fldUserId=@userId,fldDate=GETDATE()
WHERE fldReplyTaghsitId=@replyid

DELETE FROM Drd.tblBarat
WHERE fldReplyTaghsitId=@replyid

COMMIT

	end try
	begin catch
	
	rollback

	select @IdError=isnull( max(fldid),0)+1 from com.tblError
	INSERT INTO [Com].[tblError] ([fldId], [fldUserName], [fldMatn], [fldTarikh], [fldIP], [fldUserId], [fldDesc], [fldDate])
	select @IdError,fldUserName,ERROR_MESSAGE(),cast(getdate()as date),'',@userId,'DeleteTaghsit',getdate() from com.tblUser where fldid=@UserId
	--select ERROR_NUMBER()  as ErrorCode,ERROR_MESSAGE() as ErrorMessage
	end catch
GO
