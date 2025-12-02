SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblArtiklMapInsert] 

    @fldBankBillId int,
	@fldDocument_HedearId int,
	@fldType	tinyint,
	@fldSourceId	varchar(MAX)	,
    @fldDesc nvarchar(MAX),
	@fldIP varchar(16),
    @fldUserId int
AS	 
BEGIN TRAN
begin try	
	
	declare @id int


			declare @fldDetailID int 
		

		select @fldDetailID= d.fldId from [ACC].[tblDocumentRecord_Details] as d
		inner join acc.tblCoding_Details as c on c.fldId=d.fldCodingId
		inner join acc.tblTemplateCoding as t on t.fldId=c.fldTempCodingId
		inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId		
		inner join acc.tblDocumentRecord_Header1 as h1 on h.fldId=h1.fldDocument_HedearId
		where h1.fldid=@fldDocument_HedearId and fldItemId=19

		select @id=isnull(max(fldId),0)+1  FROM   [ACC].[tblArtiklMap] 
		INSERT INTO [ACC].[tblArtiklMap] ([fldId], [fldBankBillId], [fldDocumentRecord_DetailsId],fldType,fldSourceId, [fldDate], [fldIP], [fldUserId])
		SELECT @Id, @fldBankBillId, @fldDetailID,@fldType,@fldSourceId, getdate(), @fldIP, @fldUserId
		--SELECT ROW_NUMBER() over (order by id)+@Id, @fldBankBillId, id, getdate(), @fldIP, @fldUserId
		--from @t

		select 0 as ErrorCode,'' as ErrorMessage
	
end try
begin catch
	select ERROR_NUMBER()  as ErrorCode,ERROR_MESSAGE() as ErrorMessage
end catch
commit tran
GO
