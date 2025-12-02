SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblArchiveTreeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId int,
	@value2 nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) a.[fldId], [fldPID], a.[fldTitle], [fldFileUpload], a.[fldUserId],a. [fldDesc],a. [fldDate] ,fldOrganId,fldModuleId
	,isnull(m.fldTitle,'') as fldMaduleName
	FROM   [Arch].[tblArchiveTree] a
	left join com.tblModule m on m.fldid=fldModuleId
	WHERE  a.fldId = @Value

	if (@fieldname=N'fldPID')
	if(@Value=0)
	begin
		SELECT top(@h) a.[fldId], [fldPID], a.[fldTitle], [fldFileUpload], a.[fldUserId],a. [fldDesc],a. [fldDate] ,fldOrganId,fldModuleId
	,isnull(m.fldTitle,'') as fldMaduleName
	FROM   [Arch].[tblArchiveTree] a
	left join com.tblModule m on m.fldid=fldModuleId
		WHERE  fldPID is null and fldOrganId=@OrganId
	end
	else
	begin
		SELECT top(@h) a.[fldId], [fldPID], a.[fldTitle], [fldFileUpload], a.[fldUserId],a. [fldDesc],a. [fldDate] ,fldOrganId,fldModuleId
	,isnull(m.fldTitle,'') as fldMaduleName
	FROM   [Arch].[tblArchiveTree] a
	left join com.tblModule m on m.fldid=fldModuleId
		WHERE  fldPID = @Value and fldOrganId=@OrganId
	end

	if (@fieldname=N'fldPID_Module')
	begin
	if(@Value=0)
	begin
		SELECT top(@h) a.[fldId], [fldPID], a.[fldTitle], [fldFileUpload], a.[fldUserId],a. [fldDesc],a. [fldDate] ,fldOrganId,fldModuleId
	,isnull(m.fldTitle,'') as fldMaduleName
	FROM   [Arch].[tblArchiveTree] a
	left join com.tblModule m on m.fldid=fldModuleId
		WHERE  fldPID is null and fldModuleId=@value2  and fldOrganId=@OrganId
	end
	else
	begin
		SELECT top(@h) a.[fldId], [fldPID], a.[fldTitle], [fldFileUpload], a.[fldUserId],a. [fldDesc],a. [fldDate] ,fldOrganId,fldModuleId
	,isnull(m.fldTitle,'') as fldMaduleName
	FROM   [Arch].[tblArchiveTree] a
	left join com.tblModule m on m.fldid=fldModuleId
		WHERE  fldPID = @Value  and fldModuleId=@value2 and fldOrganId=@OrganId
	end
end
	if (@fieldname=N'fldTitle')
	begin
		SET @Value=Com.fn_TextNormalize(@Value)
		SELECT top(@h) a.[fldId], [fldPID], a.[fldTitle], [fldFileUpload], a.[fldUserId],a. [fldDesc],a. [fldDate] ,fldOrganId,fldModuleId
	,isnull(m.fldTitle,'') as fldMaduleName
	FROM   [Arch].[tblArchiveTree] a
	left join com.tblModule m on m.fldid=fldModuleId
		WHERE a.fldTitle like  @Value
	end
	if (@fieldname=N'fldDesc')
	begin
		SET @Value=Com.fn_TextNormalize(@Value)
		SELECT top(@h) a.[fldId], [fldPID], a.[fldTitle], [fldFileUpload], a.[fldUserId],a. [fldDesc],a. [fldDate] ,fldOrganId,fldModuleId
	,isnull(m.fldTitle,'') as fldMaduleName
	FROM   [Arch].[tblArchiveTree] a
	left join com.tblModule m on m.fldid=fldModuleId
		WHERE a.fldDesc like  @Value  and fldOrganId=@OrganId
	end
	if (@fieldname=N'')
	SELECT top(@h) a.[fldId], [fldPID], a.[fldTitle], [fldFileUpload], a.[fldUserId],a. [fldDesc],a. [fldDate] ,fldOrganId,fldModuleId
	,isnull(m.fldTitle,'') as fldMaduleName
	FROM   [Arch].[tblArchiveTree] a
	left join com.tblModule m on m.fldid=fldModuleId

		if (@fieldname=N'fldOrganId')
	SELECT top(@h) a.[fldId], [fldPID], a.[fldTitle], [fldFileUpload], a.[fldUserId],a. [fldDesc],a. [fldDate] ,fldOrganId,fldModuleId
	,isnull(m.fldTitle,'') as fldMaduleName
	FROM   [Arch].[tblArchiveTree] a
	left join com.tblModule m on m.fldid=fldModuleId
	where fldOrganId=@OrganId
	

	
	if (@fieldname=N'CheckTitle')
	begin
		SET @Value=Com.fn_TextNormalize(@Value)
		SELECT top(@h) a.[fldId], [fldPID], a.[fldTitle], [fldFileUpload], a.[fldUserId],a. [fldDesc],a. [fldDate] ,fldOrganId,fldModuleId
	,isnull(m.fldTitle,'') as fldMaduleName
	FROM   [Arch].[tblArchiveTree] a
	left join com.tblModule m on m.fldid=fldModuleId
		WHERE a.fldTitle like  @Value and fldOrganId=@OrganId
	end


	COMMIT
GO
