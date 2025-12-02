SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [Drd].[fn_TitleAvarezAcc](@title varchar(200),@year smallint ,@organId int)
returns  table
as
return
(select case when @title='Avarez' then isnull(avarez,N'عوارض') when @title='Maliyat' then isnull(maliyat,N'مالیات') end as title
 from (select
(select d.fldTitle from acc.tblCoding_Header h
inner join acc.tblCoding_Details d  on h.fldid=d.fldHeaderCodId
inner join acc.tblTemplateCoding t on t.fldid=d.fldTempCodingId
inner join acc.tblItemNecessary i on i.fldId=t.fldItemId
where fldYear=@year and fldOrganId=@organId and t.fldItemId=22)avarez/*عوارض*/ 

,(select d.fldTitle from acc.tblCoding_Header h
inner join acc.tblCoding_Details d  on h.fldid=d.fldHeaderCodId
inner join acc.tblTemplateCoding t on t.fldid=d.fldTempCodingId
inner join acc.tblItemNecessary i on i.fldId=t.fldItemId
where fldYear=@year and fldOrganId=@organId and t.fldItemId=21)Maliyat/*مالیات*/ 

)t
)


GO
