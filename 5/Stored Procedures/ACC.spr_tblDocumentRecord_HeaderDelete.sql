SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentRecord_HeaderDelete] 
	@fldID int,
	@fldUserID int
AS 
begin try
	BEGIN TRAN
	declare @Setting varchar(10)='false',@Document_HedearId int=0,@Organ int=0,@iderror int

	select @Document_HedearId=h1.fldDocument_HedearId from acc.tblDocumentRecord_Header1  as h1
	where h1.fldId=@fldID

	update [ACC].[tblDocumentRecord_Header1]
	set fldUserId=@fldUserId,fldDate=getdate() where fldId=@fldID

	DELETE a 
	FROM   [ACC].[tblDocumentRecord_Details] as d 
	inner join [ACC].[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
	WHERE  fldDocument_HedearId1 = @fldId
				
	
	DELETE
	FROM   [ACC].[tblDocumentRecord_Details]
	WHERE  fldDocument_HedearId1 = @fldId
			
	
															 
	update drd.tblCheck
	set fldReceive=0, fldDocumentHeader1Id= null ,fldUserId=@fldUserID ,fldDate=getdate()
	where fldDocumentHeader1Id=@fldid

	update drd.tblPardakhtFish
	set  fldDocumentHeaderId1= null ,fldUserId=@fldUserID ,fldDate=getdate()
	where fldDocumentHeaderId1=@fldid

	update cntr.tblFactor
	set fldStatus=0, fldDocumentHeaderId1= null ,fldUserId=@fldUserID ,fldDate=getdate()
	where fldDocumentHeaderId1=@fldid
	
	DELETE FROM   [ACC].[tblDocumentRecord_Header1]
	WHERE  fldId = @fldId
			
	 if not exists(select * from [ACC].[tblDocumentRecord_Header1] where fldDocument_HedearId=@Document_HedearId)
				begin
					declare @file varchar(max)=''
					select @file=@file+cast(b.fldFileId as varchar(10))+',' from [ACC].[tblDocumentRecorde_File] as b
						where fldDocumentHeaderId = @Document_HedearId
					
					DELETE b
					FROM   [ACC].[tblDocumentBookMark] as b
					inner join acc.tblDocumentRecorde_File as f on f.fldId=b.fldDocumentRecordeId
					WHERE  f.fldDocumentHeaderId = @Document_HedearId
					
					
					
						DELETE
						FROM   [ACC].[tblDocumentRecorde_File]
						WHERE  fldDocumentHeaderId = @Document_HedearId
						
						
			
							delete com.tblFile
							where fldId in (select Item from com.Split(@file,','))
							
								DELETE a 
								FROM   [ACC].[tblDocumentRecord_Details] as d 
								inner join [ACC].[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
								WHERE  fldDocument_HedearId = @Document_HedearId
								
								DELETE
								FROM   [ACC].[tblDocumentRecord_Details]
								WHERE  fldDocument_HedearId = @Document_HedearId
								
								
										DELETE
									FROM   [ACC].[tblDocument_HeaderLog]
									WHERE  fldHeaderId = @fldID
									
									
	DELETE
		FROM   [ACC].[tblDocumentRecord_Header]
		WHERE  fldId = @Document_HedearId
											
	delete c from acc.tblCase as c
	left join [ACC].[tblDocumentRecord_Details] d   on  d.fldCaseId=c.fldid
	where d.fldCaseId is null


														
				
	end
	

	COMMIT
end try
begin catch
	
	rollback
	
	select @iderror =ISNULL(max(fldId),0)+1 from [Com].[tblError] 
	INSERT INTO [Com].[tblError] ([fldId], [fldUserName], [fldMatn], [fldTarikh], [fldIP], [fldUserId], [fldDesc], [fldDate])
	SELECT @iderror, fldUserName, ERROR_MESSAGE(), cast(getdate() as date), '', @fldUserId, '', GETDATE()
	from com.tblUser where fldid=@fldUserID



end catch
GO
