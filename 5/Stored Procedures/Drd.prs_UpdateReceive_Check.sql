SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Drd].[prs_UpdateReceive_Check](@idcheck int ,@fldUserId int,@DocumentHeader1Id int)
as

	BEGIN TRAN

update drd.tblCheck
set fldReceive=1,fldDate=getdate(),fldUserId=@fldUserId,fldDocumentHeader1Id=@DocumentHeader1Id
where fldid=@idcheck
if (@@ERROR<>0)
rollback
	

commit
GO
