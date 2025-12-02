SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblSignerSelect] 
    @fieldname as nvarchar(50),
	@Value nvarchar(50),
	@organId int,
	@h as int
AS 
BEGIN
       if(@h=0) set @h=2147483647
       if (@fieldname=N'fldId')
	SELECT   TOP (@h)  tblSigner.fldId, tblSigner.fldLetterId, tblSigner.fldSignerComisionId, tblSigner.fldIndexerId, tblSigner.fldFirstSigner, tblSigner.fldDate, tblSigner.fldUserId, 
						  tblSigner.fldDesc,tblSigner.fldOrganId ,tblSigner.fldIP,case when fldFirstSigner is NULL  then NULL 
						  else fldFileId end fldFileSignId
	,fldTitle as fldTitlePost
	FROM         tblSigner INNER JOIN
						  tblLetter ON tblSigner.fldLetterID = tblLetter.fldID INNER JOIN
						  tblCommision ON tblSigner.fldSignerComisionID = tblCommision.fldID INNER JOIN
						 com.tblOrganizationalPostsEjraee o on fldOrganizPostEjraeeID=o.fldid
						 outer apply (select top(1)  fldFileId  from 
										 prs.tblPersonalSign p inner join tblCommision c
										 on c.fldid=p.fldCommitionId 
										where c.fldid=tblCommision.fldid and p.fldDate<=tblSigner.fldDate
										order by p.fldid desc)p

       where tblSigner.fldId like @Value  and tblSigner.fldorganId =@organId
       
       
       if (@fieldname=N'fldLetterId')
	SELECT   TOP (@h)  tblSigner.fldId, tblSigner.fldLetterId, tblSigner.fldSignerComisionId, tblSigner.fldIndexerId, tblSigner.fldFirstSigner, tblSigner.fldDate, tblSigner.fldUserId, 
						  tblSigner.fldDesc,tblSigner.fldOrganId ,tblSigner.fldIP,case when fldFirstSigner is NULL  then NULL 
						  else fldFileId end fldFileSignId
	,fldTitle as fldTitlePost
	FROM         tblSigner INNER JOIN
						  tblLetter ON tblSigner.fldLetterID = tblLetter.fldID INNER JOIN
						  tblCommision ON tblSigner.fldSignerComisionID = tblCommision.fldID INNER JOIN
						 com.tblOrganizationalPostsEjraee o on fldOrganizPostEjraeeID=o.fldid
						  outer apply (select top(1)  fldFileId  from 
										 prs.tblPersonalSign p inner join tblCommision c
										 on c.fldid=p.fldCommitionId 
										where c.fldid=tblCommision.fldid and p.fldDate<=tblSigner.fldDate
										order by p.fldid desc)p
       where tblSigner.fldLetterID like @value        and tblSigner.fldorganId =@organId 
	   
	         
       if (@fieldname=N'fldLetterId_Assigment')/*farghdare*/
	SELECT   TOP (@h)  tblSigner.fldId, tblSigner.fldLetterId, tblSigner.fldSignerComisionId, tblSigner.fldIndexerId, tblSigner.fldFirstSigner, tblSigner.fldDate, tblSigner.fldUserId, 
						  tblSigner.fldDesc,tblSigner.fldOrganId ,tblSigner.fldIP,case when fldFirstSigner is NULL  then NULL 
						  else fldFileId end fldFileSignId
	,fldTitle as fldTitlePost
	FROM         tblSigner INNER JOIN
						  tblLetter ON tblSigner.fldLetterID = tblLetter.fldID INNER JOIN
						  tblCommision ON tblSigner.fldSignerComisionID = tblCommision.fldID INNER JOIN
						 com.tblOrganizationalPostsEjraee o on fldOrganizPostEjraeeID=o.fldid
						  outer apply (select top(1)  fldFileId  from 
										 prs.tblPersonalSign p inner join tblCommision c
										 on c.fldid=p.fldCommitionId 
										where c.fldid=tblCommision.fldid and p.fldDate<=tblSigner.fldDate
										order by p.fldid desc)p
						outer apply (select max(i.fldDate)flddate,fldReceiverComisionId from auto.tblAssignment a
											inner join auto.tblInternalAssignmentReceiver i
											on a.fldid=fldAssignmentID
											where fldLetterID=@Value and fldReceiverComisionId=fldFirstSigner
											group by fldReceiverComisionId
										)inter
       where tblSigner.fldLetterID like @value        and tblSigner.fldorganId =@organId   
	   order by flddate       
           
		       if (@fieldname=N'fldLetterId_HaveEmza')
	SELECT   TOP (@h)  tblSigner.fldId, tblSigner.fldLetterId, tblSigner.fldSignerComisionId, tblSigner.fldIndexerId, tblSigner.fldFirstSigner, tblSigner.fldDate, tblSigner.fldUserId, 
						  tblSigner.fldDesc,tblSigner.fldOrganId ,tblSigner.fldIP,case when fldFirstSigner is NULL  then NULL 
						  else fldFileId end fldFileSignId
	,fldTitle as fldTitlePost
	FROM         tblSigner INNER JOIN
						  tblLetter ON tblSigner.fldLetterID = tblLetter.fldID INNER JOIN
						  tblCommision ON tblSigner.fldSignerComisionID = tblCommision.fldID INNER JOIN
						 com.tblOrganizationalPostsEjraee o on fldOrganizPostEjraeeID=o.fldid
						  outer apply (select top(1)  fldFileId  from 
										 prs.tblPersonalSign p inner join tblCommision c
										 on c.fldid=p.fldCommitionId 
										where c.fldid=tblCommision.fldid and p.fldDate<=tblSigner.fldDate
										order by p.fldid desc)p
       where tblSigner.fldLetterID like @value        and tblSigner.fldorganId =@organId     and     fldFirstSigner is not null      
   
   if (@fieldname=N'fldSignerComisionId')
SELECT   TOP (@h)  tblSigner.fldId, tblSigner.fldLetterId, tblSigner.fldSignerComisionId, tblSigner.fldIndexerId, tblSigner.fldFirstSigner, tblSigner.fldDate, tblSigner.fldUserId, 
						  tblSigner.fldDesc,tblSigner.fldOrganId ,tblSigner.fldIP,case when fldFirstSigner is NULL  then NULL 
						  else fldFileId end fldFileSignId
	,fldTitle as fldTitlePost
	FROM         tblSigner INNER JOIN
						  tblLetter ON tblSigner.fldLetterID = tblLetter.fldID INNER JOIN
						  tblCommision ON tblSigner.fldSignerComisionID = tblCommision.fldID INNER JOIN
						 com.tblOrganizationalPostsEjraee o on fldOrganizPostEjraeeID=o.fldid
						  outer apply (select top(1)  fldFileId  from 
										 prs.tblPersonalSign p inner join tblCommision c
										 on c.fldid=p.fldCommitionId 
										where c.fldid=tblCommision.fldid and p.fldDate<=tblSigner.fldDate
										order by p.fldid desc)p
       where tblSigner.fldSignerComisionID like @Value  and tblSigner.fldorganId =@organId
   
       if (@fieldname=N'')
SELECT   TOP (@h)  tblSigner.fldId, tblSigner.fldLetterId, tblSigner.fldSignerComisionId, tblSigner.fldIndexerId, tblSigner.fldFirstSigner, tblSigner.fldDate, tblSigner.fldUserId, 
						  tblSigner.fldDesc,tblSigner.fldOrganId ,tblSigner.fldIP,case when fldFirstSigner is NULL  then NULL 
						  else fldFileId end fldFileSignId
	,fldTitle as fldTitlePost
	FROM         tblSigner INNER JOIN
						  tblLetter ON tblSigner.fldLetterID = tblLetter.fldID INNER JOIN
						  tblCommision ON tblSigner.fldSignerComisionID = tblCommision.fldID INNER JOIN
						 com.tblOrganizationalPostsEjraee o on fldOrganizPostEjraeeID=o.fldid
						   outer apply (select top(1)  fldFileId  from 
										 prs.tblPersonalSign p inner join tblCommision c
										 on c.fldid=p.fldCommitionId 
										where c.fldid=tblCommision.fldid and p.fldDate<=tblSigner.fldDate
										order by p.fldid desc)p
						 where  tblSigner.fldorganId =@organId

 if (@fieldname=N'fldOrganId')
SELECT   TOP (@h)  tblSigner.fldId, tblSigner.fldLetterId, tblSigner.fldSignerComisionId, tblSigner.fldIndexerId, tblSigner.fldFirstSigner, tblSigner.fldDate, tblSigner.fldUserId, 
						  tblSigner.fldDesc,tblSigner.fldOrganId ,tblSigner.fldIP,case when fldFirstSigner is NULL  then NULL 
						  else fldFileId end fldFileSignId
	,fldTitle as fldTitlePost
	FROM         tblSigner INNER JOIN
						  tblLetter ON tblSigner.fldLetterID = tblLetter.fldID INNER JOIN
						  tblCommision ON tblSigner.fldSignerComisionID = tblCommision.fldID INNER JOIN
						 com.tblOrganizationalPostsEjraee o on fldOrganizPostEjraeeID=o.fldid
						  outer apply (select top(1)  fldFileId  from 
										 prs.tblPersonalSign p inner join tblCommision c
										 on c.fldid=p.fldCommitionId 
										where c.fldid=tblCommision.fldid and p.fldDate<=tblSigner.fldDate
										order by p.fldid desc)p
						 where  tblSigner.fldorganId =@organId
END

GO
