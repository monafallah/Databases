SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_GetParamDocumentDesc]
 @DocDesc nvarchar(max)
 as
	declare @t table(fldparam nvarchar(max))
	insert @t
	select * from com.Split(@DocDesc,N'[')
	where Item like N'%]%'

	select '['+SUBSTRING(fldparam,1,CHARINDEX(']',fldparam)) as param,N'' Value from @t

		--select REPLACE(param,']','')param,Value  from (select  SUBSTRING(fldparam,1,CHARINDEX(']',fldparam)) as param,N'' Value from @t)t
GO
