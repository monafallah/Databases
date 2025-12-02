SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblContractSignersSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) s.[fldId], [fldContractId], [fldCompanyPostId], [fldEmpolyId], [fldPostEjraeeId], s.[fldUserId], s.[fldOrganId], s.[fldIP], s.[fldDesc], s.[fldDate] 
	,fldName+' '+fldfamily as fldName_family ,Post.fldTitle as fldPost 
	FROM   [Cntr].[tblContractSigners] s
	inner join com.tblEmployee e on e.fldid=s.fldEmpolyId
	cross apply (
					select o.fldTitle from com.tblOrganizationalPostsEjraee o
					where o.fldid=fldPostEjraeeId
					union all
					select c.fldTitle from com.tblCompanyPost c
					where  c.fldid=fldCompanyPostId
				)Post
	WHERE  s.fldId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) s.[fldId], [fldContractId], [fldCompanyPostId], [fldEmpolyId], [fldPostEjraeeId], s.[fldUserId], s.[fldOrganId], s.[fldIP], s.[fldDesc], s.[fldDate] 
	,fldName+' '+fldfamily as fldName_family ,Post.fldTitle as fldPost 
	FROM   [Cntr].[tblContractSigners] s
	inner join com.tblEmployee e on e.fldid=s.fldEmpolyId
	cross apply (
					select o.fldTitle from com.tblOrganizationalPostsEjraee o
					where o.fldid=fldPostEjraeeId
					union all
					select c.fldTitle from com.tblCompanyPost c
					where  c.fldid=fldCompanyPostId
				)Post
	WHERE  s.fldDesc like @Value and  s.[fldOrganId]=@organId

	if (@FieldName='fldContractId')
	SELECT top(@h) s.[fldId], [fldContractId], [fldCompanyPostId], [fldEmpolyId], [fldPostEjraeeId], s.[fldUserId], s.[fldOrganId], s.[fldIP], s.[fldDesc], s.[fldDate] 
	,fldName+' '+fldfamily as fldName_family ,Post.fldTitle as fldPost 
	FROM   [Cntr].[tblContractSigners] s
	inner join com.tblEmployee e on e.fldid=s.fldEmpolyId
	cross apply (
					select o.fldTitle from com.tblOrganizationalPostsEjraee o
					where o.fldid=fldPostEjraeeId
					union all
					select c.fldTitle from com.tblCompanyPost c
					where  c.fldid=fldCompanyPostId
				)Post
	WHERE  fldContractId like @Value and  s.[fldOrganId]=@organId

	if (@FieldName='fldCompanyPostId')
	SELECT top(@h) s.[fldId], [fldContractId], [fldCompanyPostId], [fldEmpolyId], [fldPostEjraeeId], s.[fldUserId], s.[fldOrganId], s.[fldIP], s.[fldDesc], s.[fldDate] 
	,fldName+' '+fldfamily as fldName_family ,Post.fldTitle as fldPost 
	FROM   [Cntr].[tblContractSigners] s
	inner join com.tblEmployee e on e.fldid=s.fldEmpolyId
	cross apply (
					select o.fldTitle from com.tblOrganizationalPostsEjraee o
					where o.fldid=fldPostEjraeeId
					union all
					select c.fldTitle from com.tblCompanyPost c
					where  c.fldid=fldCompanyPostId
				)Post
	WHERE  fldCompanyPostId like @Value and  s.[fldOrganId]=@organId


	if (@FieldName='fldEmpolyId')
	SELECT top(@h) s.[fldId], [fldContractId], [fldCompanyPostId], [fldEmpolyId], [fldPostEjraeeId], s.[fldUserId], s.[fldOrganId], s.[fldIP], s.[fldDesc], s.[fldDate] 
	,fldName+' '+fldfamily as fldName_family ,Post.fldTitle as fldPost 
	FROM   [Cntr].[tblContractSigners] s
	inner join com.tblEmployee e on e.fldid=s.fldEmpolyId
	cross apply (
					select o.fldTitle from com.tblOrganizationalPostsEjraee o
					where o.fldid=fldPostEjraeeId
					union all
					select c.fldTitle from com.tblCompanyPost c
					where  c.fldid=fldCompanyPostId
				)Post
	WHERE  fldEmpolyId like @Value and  s.[fldOrganId]=@organId

	if (@FieldName='fldPostEjraeeId')
	SELECT top(@h) s.[fldId], [fldContractId], [fldCompanyPostId], [fldEmpolyId], [fldPostEjraeeId], s.[fldUserId], s.[fldOrganId], s.[fldIP], s.[fldDesc], s.[fldDate] 
	,fldName+' '+fldfamily as fldName_family ,Post.fldTitle as fldPost 
	FROM   [Cntr].[tblContractSigners] s
	inner join com.tblEmployee e on e.fldid=s.fldEmpolyId
	cross apply (
					select o.fldTitle from com.tblOrganizationalPostsEjraee o
					where o.fldid=fldPostEjraeeId
					union all
					select c.fldTitle from com.tblCompanyPost c
					where  c.fldid=fldCompanyPostId
				)Post
	WHERE  fldPostEjraeeId like @Value and  s.[fldOrganId]=@organId

	if (@FieldName='fldOrganId')
	SELECT top(@h) s.[fldId], [fldContractId], [fldCompanyPostId], [fldEmpolyId], [fldPostEjraeeId], s.[fldUserId], s.[fldOrganId], s.[fldIP], s.[fldDesc], s.[fldDate] 
	,fldName+' '+fldfamily as fldName_family ,Post.fldTitle as fldPost 
	FROM   [Cntr].[tblContractSigners] s
	inner join com.tblEmployee e on e.fldid=s.fldEmpolyId
	cross apply (
					select o.fldTitle from com.tblOrganizationalPostsEjraee o
					where o.fldid=fldPostEjraeeId
					union all
					select c.fldTitle from com.tblCompanyPost c
					where  c.fldid=fldCompanyPostId
				)Post
	where   s.[fldOrganId]=@organId

	if (@FieldName='')
	SELECT top(@h) s.[fldId], [fldContractId], [fldCompanyPostId], [fldEmpolyId], [fldPostEjraeeId], s.[fldUserId], s.[fldOrganId], s.[fldIP], s.[fldDesc], s.[fldDate] 
	,fldName+' '+fldfamily as fldName_family ,Post.fldTitle as fldPost 
	FROM   [Cntr].[tblContractSigners] s
	inner join com.tblEmployee e on e.fldid=s.fldEmpolyId
	cross apply (
					select o.fldTitle from com.tblOrganizationalPostsEjraee o
					where o.fldid=fldPostEjraeeId
					union all
					select c.fldTitle from com.tblCompanyPost c
					where  c.fldid=fldCompanyPostId
				)Post
	
	COMMIT
GO
