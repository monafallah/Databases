SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblBoxSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganID INT,
	@value2 nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldID], [fldName], [fldComisionID], [fldBoxTypeID], [fldPID], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	,'' as chidId,'' childName,''tedad
	FROM   [Auto].[tblBox] 
	WHERE  fldId = @Value AND fldOrganID=@fldOrganID

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldID], [fldName], [fldComisionID], [fldBoxTypeID], [fldPID], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	,'' as chidId,'' childName,''tedad
	FROM   [Auto].[tblBox] 
	WHERE fldDesc like  @Value AND fldOrganID=@fldOrganID

	if (@fieldname=N'fldOrganID')
	SELECT top(@h) [fldID], [fldName], [fldComisionID], [fldBoxTypeID], [fldPID], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	,'' as chidId,'' childName,''tedad
	FROM   [Auto].[tblBox] 
	WHERE fldOrganID=@fldOrganID

	if (@fieldname=N'')
	SELECT top(@h) [fldID], [fldName], [fldComisionID], [fldBoxTypeID], [fldPID], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	,'' as chidId,'' childName,''tedad
	FROM   [Auto].[tblBox] 
	where fldPID is null and fldOrganID=@fldOrganID
		
	if (@fieldname=N'fldComisionID_Type')
	SELECT top(@h) [fldID], [fldName], [fldComisionID], [fldBoxTypeID], [fldPID], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	,'' as chidId,'' childName,''tedad
	FROM   [Auto].[tblBox] 
	WHERE fldComisionID=@value and fldBoxTypeID=@value2 and fldOrganID=@fldOrganID
	
	if (@fieldname=N'fldComisionID')
	begin
	;with child as  
	(	SELECT  [fldID],fldPID,[fldBoxTypeID],[fldName]
		FROM   [Auto].[tblBox] 
		where fldPID is null and fldComisionID=@Value and fldOrganID=@fldOrganID
		union all
		select  b.[fldID],b.fldPID,b.[fldBoxTypeID],b.[fldName]from  [Auto].[tblBox] b
		inner join child on b.fldpid=child.fldid
		where fldComisionID=@Value and fldOrganID=@fldOrganID
		
	)


	SELECT top(@h) [fldID], [fldName], [fldComisionID], [fldBoxTypeID], [fldPID], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP]
	,isnull(childId,'')chidId,isnull(childName,'')childName,case when [fldBoxTypeID]=1 then [fldName] +'('+cast(isnull(tedad,0) as varchar(50))+')'
	else fldName end tedad
	FROM   [Auto].[tblBox] 
	outer apply (select (select cast(c.fldid as varchar(10))+';' from child c where c.[fldBoxTypeID]=6 and c.fldpid=[tblBox].fldid for xml path (''))childId )child
	outer apply (select (select c.[fldName]+';' from child c where c.[fldBoxTypeID]=6 and c.fldpid=[tblBox].fldid for xml path (''))childName )childN
	outer apply (select count(i.fldId)tedad from auto.tblInternalAssignmentReceiver i 
				 where fldReceiverComisionId=@Value and fldAssignmentStatusId=1 and fldOrganId=@fldOrganID and fldBoxId=[Auto].[tblBox].fldid)tedad
	where fldPID is null and fldComisionID=@Value and fldOrganID=@fldOrganID

	end
	if (@fieldname=N'fldPID')
	begin
		if (@Value='0')
			SELECT top(@h) [fldID], [fldName], [fldComisionID], [fldBoxTypeID], [fldPID], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
			,'' as chidId,'' childName,''tedad
			FROM   [Auto].[tblBox] 
			where fldPID is null and fldOrganID=@fldOrganID
		else if (@Value<>'0')
			SELECT top(@h) [fldID], [fldName], [fldComisionID], [fldBoxTypeID], [fldPID], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
			,'' as chidId,'' childName,''tedad
			FROM   [Auto].[tblBox] 
			where fldPID =@Value  and fldOrganID=@fldOrganID

	end
	COMMIT
GO
