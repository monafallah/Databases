SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_CheckDocStatus]
 @DocumentRecord_HeaderId int
 as
 begin tran
	declare @DocStatus bit=0,@id int=0,@MaxId int=0


	select @MaxId=max(fldid) from acc.tblDocumentRecord_Header1
		where fldPId=@DocumentRecord_HeaderId

	SELECT        @id=max(h.fldId)
	FROM            ACC.tblDocumentRecord_Header1 as h
	cross apply(select d.fldTypeSanadId FROM ACC.tblDocumentRecord_Header1 as d where d.fldId=h.fldId and fldTypeSanadId=3/*اصلاحیه*/)as d
	where fldPId=@DocumentRecord_HeaderId

	if(@id=@MaxId or @MaxId is null)
	begin 
		set @DocStatus=1
	end
	select @DocStatus as DocStatus,@MaxId as Id
  commit tran
GO
