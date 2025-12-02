SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Auto].[spr_RptCharkhe](@LetterId int)
as
declare @test table(fldAssignment_Id int,fldCommison_Id int,_type int,_SID int)

insert into @test
SELECT     fldAssignmentID, fldSenderComisionID,0,(select fldSourceAssId from tblAssignment where fldID=fldAssignmentID)
FROM         tblInternalAssignmentSender
WHERE     fldAssignmentID IN (select fldId from tblAssignment where fldLetterID=@LetterId)

union

SELECT     fldAssignmentId, fldReceiverComisionID,1,(select fldSourceAssId from tblAssignment where fldID=fldAssignmentID)
FROM         tblInternalAssignmentReceiver
WHERE     fldAssignmentId IN (select fldId from tblAssignment where fldLetterID=@LetterId)

declare curCharkhe cursor for


 select * from @test 
order by fldAssignment_Id,_type 

declare @from int,@type int,@state int=0,@from1 int,@id int,@pid int,@assId int,@assId1 int,@sender int,@SID int

declare @ch table(id int,sender int,pid int null,AssId int,_SID int)
open curCharkhe
FETCH NEXT FROM curCharkhe INTO @assId,@from,@type,@SID
WHILE @@FETCH_STATUS=0
BEGIN
	if(@state=0)
	begin
		set @id=(select isnull(max(id),0)+1 from @ch)
		insert into @ch select @id,@from,null,@assId,@SID
		set @pid=@id
		set @state=1
		set @assId1=@assId
		set @from1=@from
	end 
	else if(@state<>0)
	begin
			
	
		begin
			set @id=(select isnull(max(id),0)+1 from @ch)
			declare @b as int
			if(@SID is null)
			begin
				set @b=(select fldcommison_id from @test where  fldAssignment_Id=@assid and _type=0) 
				set @pid=(SELECT TOP(1) id from @ch where  assid=@assid and sender=@b)
				insert into @ch select @id,@from,@pid,@assId,@SID
			end
			else if(@type<>0)
			begin
				set @b=(select fldcommison_id from @test where  fldAssignment_Id=@assid and _type=0) 
				set @pid=(SELECT TOP(1) id from @ch where  assid=@SID and sender=@b)
				insert into @ch select @id,@from,@pid,@assId,@SID
			end
			
			
			
		end
		set @assId1=@assId
		set @from1=@from
	
	end
	FETCH NEXT FROM curCharkhe INTO @assId,@from,@type,@SID
end

close curCharkhe;




DEALLOCATE curCharkhe;





	select  id,sender,null pid,AssId,_SID , SenderName,'' fldTypeAss,'' fldNameStatus,'' fldLetterReadDate,'' fldTarikhErja,'' fldDesc
					  from @ch 
					  cross apply (SELECT    tblEmployee.fldName COLLATE Latin1_General_CS_AS + ' ' + tblEmployee.fldFamily COLLATE Latin1_General_CS_AS + '(' + tblOrganizationalPostsEjraee.fldTitle + ')'  AS SenderName
					 from tblCommision INNER JOIN
						  com.tblAshkhas ON tblCommision.fldAshkhasID = tblAshkhas.fldID INNER JOIN
						  com.tblEmployee on fldHaghighiId=tblEmployee.fldid inner join 
						  com.tblOrganizationalPostsEjraee ON tblCommision.fldOrganizPostEjraeeID = tblOrganizationalPostsEjraee.fldID
                      where  tblCommision.fldID=sender)AS SenderName
					  where pid is null
					  
union all
	select id,sender, pid,AssId,_SID ,SenderName,fldType fldTypeAss,statusname fldNameStatus, statusass.LetterReadDate fldLetterReadDate,statusass.fldTarikhErja fldTarikhErja, fldDesc
							 from @ch
						  cross apply (SELECT    tblEmployee.fldName COLLATE Latin1_General_CS_AS + ' ' + tblEmployee.fldFamily COLLATE Latin1_General_CS_AS + '(' + tblOrganizationalPostsEjraee.fldTitle + ')'  AS SenderName
					 from tblCommision INNER JOIN
						  com.tblAshkhas ON tblCommision.fldAshkhasID = tblAshkhas.fldID INNER JOIN
						  com.tblEmployee on fldHaghighiId=tblEmployee.fldid inner join 
						  com.tblOrganizationalPostsEjraee ON tblCommision.fldOrganizPostEjraeeID = tblOrganizationalPostsEjraee.fldID
                      where  tblCommision.fldID=sender) SenderName
					  outer apply (SELECT     TOP (1) tblAssignmentType.fldType
							FROM         tblAssignment INNER JOIN
                      tblInternalAssignmentReceiver ON tblAssignment.fldID = tblInternalAssignmentReceiver.fldAssignmentID INNER JOIN
                      tblAssignmentType ON tblInternalAssignmentReceiver.fldAssignmentTypeID = tblAssignmentType.fldID
					WHERE     (tblInternalAssignmentReceiver.fldAssignmentID = AssId) AND (tblInternalAssignmentReceiver.fldReceiverComisionID = sender))asstype
					outer apply (SELECT  top(1)   tblAssignmentStatus.fldName as statusname,isnull(substring(tblInternalAssignmentReceiver.fldLetterReadDate,11,len(tblInternalAssignmentReceiver.fldLetterReadDate)),'-')+'_'+isnull((tblInternalAssignmentReceiver.fldLetterReadDate),'-')LetterReadDate
					  ,tblAssignment.fldAssignmentDate fldTarikhErja,tblInternalAssignmentReceiver.fldDesc
						FROM         tblAssignment INNER JOIN
                      tblInternalAssignmentReceiver ON tblAssignment.fldID = tblInternalAssignmentReceiver.fldAssignmentID INNER JOIN
                      tblAssignmentStatus ON tblInternalAssignmentReceiver.fldAssignmentStatusID = tblAssignmentStatus.fldID
						 where fldAssignmentID=AssId and fldReceiverComisionID=sender)statusass
						   where pid is not null
						  
GO
