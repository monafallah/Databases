SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Auto].[spr_DeleteErjaatLetter](@LetterId bigint,@fldUserId int)

as 
declare @errorid int
begin try
begin tran
declare @idass int,@idsender int
select top(1) @idass=a.fldid,@idsender=i.fldid from auto.tblAssignment a
inner join auto.tblInternalAssignmentSender i
on a.fldid=i.fldAssignmentID
where fldLetterID=@LetterId

delete i
from auto.tblInternalAssignmentReceiver i
inner join auto.tblAssignment a on a.fldid=i.fldAssignmentID
where fldLetterID=@LetterId

delete i
from auto.tblInternalAssignmentSender i
inner join auto.tblAssignment a on a.fldid=i.fldAssignmentID
where fldLetterID=@LetterId and i.fldid<>@idsender





delete from auto.tblAssignment
where fldLetterID=@LetterId and fldid<>@idass

delete lb
from auto.tblLetterBox lb 
inner join auto.tblbox b on b.fldid=lb.fldBoxID
where fldLetterID=@LetterId and fldBoxTypeID<>2



--update lb
--set fldBoxID=box.fldID
--from auto.tblLetterBox lb
--inner join auto.tblbox b1 on b1.fldid=fldBoxID
--cross apply (select fldid from auto.tblbox b where  fldBoxTypeID=3 and b.fldComisionID=b1.fldComisionID)box
--where fldLetterID=@LetterId and fldBoxTypeID=2

select 0 as Error_Code,''ErrorMsg
commit 
end try

begin catch
rollback
select @errorid= max(fldid)+1 from com.tblError
	insert into com.tblError(fldid,fldMatn,fldTarikh,fldUserId,fldUserName,fldIP,fldDesc,fldDate)
	select @errorid,ERROR_MESSAGE() ,(select fldTarikh from com.tblDateDim where fldDate=cast(getdate() as date)),@fldUserId,
	(select fldUserName  from com.tblUser where fldid=@fldUserId),'','',GETDATE()
	select @errorid as ErrorCode ,N'خطایی با شماره '+cast(@errorid as varchar(10)) +N' رخ داده است.'as ErrorMsg


end catch

GO
