SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Auto].[spr_selectCountUnReadLetter](@BoxID int,@ComisionID int,@organId int)
AS
;with box as 
(	select tblBox.fldid,tblBox.fldpid from auto.tblBox
	where fldid=@BoxID and fldOrganID=@organId
	union all
	select tblBox.fldid,tblBox.fldpid from auto.tblBox
	inner join box  on tblbox.fldPID=box.fldid

)
select count(i.fldId)tedad from auto.tblInternalAssignmentReceiver i
inner join box on fldBoxId=box.fldid
where fldReceiverComisionId=@ComisionID and fldAssignmentStatusId=1 and fldOrganId=@organId
GO
