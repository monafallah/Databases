SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblFactorDetailInsert] 
  
    @fldHeaderId int,
    @fldMablagh bigint,
    @fldMablaghMaliyat bigint,
    @fldCodingDetailId int,
	@fldSharhArtikl nvarchar(max),
	@fldTax bit,
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(200),
    @fldIP varchar(16)
AS 
	 
	
	BEGIN TRAN
declare @fldid int
set @fldDesc=com.fn_TextNormalize(@fldDesc)
set @fldSharhArtikl=com.fn_TextNormalize(@fldSharhArtikl)
	select @fldid=isnull(max(fldId),0)+1  FROM   [Cntr].[tblFactorDetail] 
	INSERT INTO [Cntr].[tblFactorDetail] ([fldId], [fldHeaderId], [fldMablagh], [fldMablaghMaliyat], [fldCodingDetailId],fldSharhArtikl,fldTax, [fldOrganId], [fldUserId], [fldDesc], [fldIP], [fldDate])
	SELECT @fldId, @fldHeaderId, @fldMablagh, @fldMablaghMaliyat, @fldCodingDetailId,@fldSharhArtikl,@fldTax, @fldOrganId, @fldUserId, @fldDesc, @fldIP, getdate()
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
