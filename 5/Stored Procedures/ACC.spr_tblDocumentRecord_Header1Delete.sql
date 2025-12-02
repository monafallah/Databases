SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [ACC].[spr_tblDocumentRecord_Header1Delete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	declare @Setting varchar(10)='false',@Document_HedearId int=0,@Organ int=0

	select @Document_HedearId=h1.fldDocument_HedearId from acc.tblDocumentRecord_Header1  as h1
	where h1.fldId=@fldID

	update [ACC].[tblDocumentRecord_Header1]
	set fldUserId=@fldUserId,fldDate=getdate() where fldId=@fldID

	DELETE a 
				FROM   [ACC].[tblDocumentRecord_Details] as d 
				inner join [ACC].[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
				WHERE  fldDocument_HedearId1 = @fldId
				if (@@Error<>0)
				rollback
	else
	DELETE
				FROM   [ACC].[tblDocumentRecord_Details]
				WHERE  fldDocument_HedearId1 = @fldId
				if (@@Error<>0)
				rollback
	else
	begin
	
		DELETE FROM   [ACC].[tblDocumentRecord_Header1]
			WHERE  fldId = @fldId
			if (@@error<>0)
				rollback
				else if not exists(select * from [ACC].[tblDocumentRecord_Header1] where fldDocument_HedearId=@Document_HedearId)
				begin
					declare @file varchar(max)=''
					select @file=@file+cast(b.fldFileId as varchar(10))+',' from [ACC].[tblDocumentRecorde_File] as b
						where fldDocumentHeaderId = @Document_HedearId
					DELETE b
					FROM   [ACC].[tblDocumentBookMark] as b
					inner join acc.tblDocumentRecorde_File as f on f.fldId=b.fldDocumentRecordeId
					WHERE  f.fldDocumentHeaderId = @Document_HedearId
					if (@@Error<>0)
					rollback
					else
					begin
						DELETE
						FROM   [ACC].[tblDocumentRecorde_File]
						WHERE  fldDocumentHeaderId = @Document_HedearId
						if (@@Error<>0)
						rollback
						else
						begin
			
							delete com.tblFile
							where fldId in (select Item from com.Split(@file,','))
							if (@@Error<>0)
							rollback
							else
							begin
								DELETE a 
								FROM   [ACC].[tblDocumentRecord_Details] as d 
								inner join [ACC].[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
								WHERE  fldDocument_HedearId = @Document_HedearId
								if (@@Error<>0)
								rollback
								else
								DELETE
								FROM   [ACC].[tblDocumentRecord_Details]
								WHERE  fldDocument_HedearId = @Document_HedearId
								if (@@Error<>0)
								rollback
								else
								begin
										DELETE
									FROM   [ACC].[tblDocument_HeaderLog]
									WHERE  fldHeaderId = @fldID
									if (@@Error<>0)
									rollback
									else
									begin
										DELETE
											FROM   [ACC].[tblDocumentRecord_Header]
											WHERE  fldId = @Document_HedearId
											if (@@error<>0)
												rollback
												else
													begin
														delete c from acc.tblCase as c
														left join [ACC].[tblDocumentRecord_Details] d   on  d.fldCaseId=c.fldid
														where d.fldCaseId is null
														if (@@error<>0)
														begin
															rollback
															
														end
														else 
														begin 
														update drd.tblCheck
														set fldReceive=0 ,fldUserId=@fldUserID ,fldDate=getdate()
														where fldDocumentHeader1Id=@fldid
														if (@@error<>0)
															rollback
														end

													end
									end
								end
							end
						end
					end
				end
	end
	

	COMMIT
GO
