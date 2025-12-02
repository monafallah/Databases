SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblAfradTahtePoosheshUpdate_Mohasel] 
    @fldId int,   
    @fldStatus tinyint,    
	@fldTarikhTalagh	varchar(10)	,
	@fldUserId int

AS 
	BEGIN TRAN
		declare @year char(4)=substring(@fldTarikhTalagh,1,4)

		UPDATE [Prs].[tblAfradTahtePooshesh]
		SET     [fldStatus] = @fldStatus ,fldUserId=@fldUserId,fldDate=GETDATE()
		WHERE  [fldId] = @fldId

		UPDATE [Prs].[tblAfradTahtePooshesh]
		SET     fldTarikhTalagh=@fldTarikhTalagh
		WHERE  [fldId] = @fldId and fldTarikhTalagh<@fldTarikhTalagh

		if exists(select * from [Prs].[tblMohaseleen] where fldAfradTahtePoosheshId=@fldId and SUBSTRING(cast(fldTarikh as varchar(10)),1,4)=@year)
			UPDATE [Prs].[tblMohaseleen]
			SET     fldTarikh=cast( REPLACE(@fldTarikhTalagh,'/','') as int),fldUserId=@fldUserId,fldDate=GETDATE()
			WHERE  fldAfradTahtePoosheshId=@fldId and SUBSTRING(cast(fldTarikh as varchar(10)),1,4)=@year
		else
		begin
			declare @fldMid int
			select @fldMid=isnull(max(fldId),0)+1  FROM   [Prs].[tblMohaseleen] 
			INSERT INTO [Prs].[tblMohaseleen] ([fldId], [fldAfradTahtePoosheshId], [fldTarikh], [fldUserId], [fldDate])
			SELECT @fldMId, @fldId, cast( REPLACE(@fldTarikhTalagh,'/','') as int), @fldUserId, GETDATE()
			if (@@error<>0)
				rollback
		end
	COMMIT TRAN
GO
