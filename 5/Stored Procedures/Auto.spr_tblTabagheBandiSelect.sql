SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblTabagheBandiSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@value2 nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldID], [fldName], [fldPID], [fldComisionID], [fldUserID], [fldOrganID], [fldDesc], [fldIP], [fldDate] 
	,'' as chidId,'' childName
	FROM   [Auto].[tblTabagheBandi] 
	WHERE  fldId=@Value and fldOrganID=@organId

	if (@FieldName='fldComisionID')
	begin
	;with child as  
	(	SELECT  [fldID],fldPID,[fldName]
		FROM   [Auto].[tblTabagheBandi] 
		where fldPID is null and fldComisionID=@Value and fldOrganID=@organId
		union all
		select  b.[fldID],b.fldPID,b.[fldName]from  [Auto].[tblTabagheBandi] b
		inner join child on b.fldpid=child.fldid
		where fldComisionID=@Value and fldOrganID=@organId
		
	)
	SELECT top(@h) [fldID], [fldName], [fldPID], [fldComisionID], [fldUserID], [fldOrganID], [fldDesc], [fldIP], [fldDate] 
	,isnull(childId,'')chidId,isnull(childName,'')childName 
	FROM   [Auto].[tblTabagheBandi] 
	outer apply (select (select cast(c.fldid as varchar(10))+';' from child c where  c.fldpid=[tblTabagheBandi].fldid for xml path (''))childId )child
	outer apply (select (select c.[fldName]+';' from child c where c.fldpid=[tblTabagheBandi].fldid for xml path (''))childName )childN
	WHERE  fldComisionID=@Value and fldOrganID=@organId and fldPID is null

	end

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldID], [fldName], [fldPID], [fldComisionID], [fldUserID], [fldOrganID], [fldDesc], [fldIP], [fldDate] 
	,'' as chidId,'' childName
	FROM   [Auto].[tblTabagheBandi] 
	WHERE  fldDesc like @Value and fldOrganID=@organId

	if (@FieldName='fldPID')
	begin
	if (@value2<>'')
	begin
		if (@Value='0')
		SELECT top(@h) [fldID], [fldName], [fldPID], [fldComisionID], [fldUserID], [fldOrganID], [fldDesc], [fldIP], [fldDate] 
	,'' as chidId,'' childName
		FROM   [Auto].[tblTabagheBandi] 
		WHERE  fldPID is null and fldComisionID=@value2 and fldOrganID=@organId

		else 
		SELECT top(@h) [fldID], [fldName], [fldPID], [fldComisionID], [fldUserID], [fldOrganID], [fldDesc], [fldIP], [fldDate] 
	,'' as chidId,'' childName
		FROM   [Auto].[tblTabagheBandi] 
		WHERE  fldPID=@value    and fldComisionID=@value2  and fldOrganID=@organId
	end
	else 
		begin
			if (@Value='0')
				SELECT top(@h) [fldID], [fldName], [fldPID], [fldComisionID], [fldUserID], [fldOrganID], [fldDesc], [fldIP], [fldDate] 
			,'' as chidId,'' childName
				FROM   [Auto].[tblTabagheBandi] 
				WHERE  fldPID is null  and fldOrganID=@organId

				else 
				SELECT top(@h) [fldID], [fldName], [fldPID], [fldComisionID], [fldUserID], [fldOrganID], [fldDesc], [fldIP], [fldDate] 
			,'' as chidId,'' childName
				FROM   [Auto].[tblTabagheBandi] 
				WHERE  fldPID=@value      and fldOrganID=@organId
		end
	end
	if (@FieldName='')
	SELECT top(@h) [fldID], [fldName], [fldPID], [fldComisionID], [fldUserID], [fldOrganID], [fldDesc], [fldIP], [fldDate] 
	,'' as chidId,'' childName
	FROM   [Auto].[tblTabagheBandi] 
	where  fldOrganID=@organId

	if (@FieldName='fldOrganID')
	SELECT top(@h) [fldID], [fldName], [fldPID], [fldComisionID], [fldUserID], [fldOrganID], [fldDesc], [fldIP], [fldDate] 
	,'' as chidId,'' childName
	FROM   [Auto].[tblTabagheBandi] 
	where  fldOrganID=@organId
	COMMIT
GO
