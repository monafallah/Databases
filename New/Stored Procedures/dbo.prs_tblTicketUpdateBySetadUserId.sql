SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblTicketUpdateBySetadUserId] 
    @Value int,
	@value2 INT,
	--@UserId Int,
    @fieldName NVARCHAR(50) 
AS 
	BEGIN TRAN
	IF(@fieldName='User')
	begin
		UPDATE [dbo].[tblTicket]
		SET    fldSeen=1,fldSeenDate=GETDATE()
		WHERE   fldAshkhasId = @Value AND fldUserId IS NOT NULL AND fldTicketCategoryId=@value2 and fldSeen=0
	 if (@@ERROR<>0)
		ROLLBACK
		end
	IF(@fieldName='Admin')
	begin
		--if(@Value=@UserId)
		--	begin
				UPDATE [dbo].[tblTicket]
				SET    fldSeen=1,fldSeenDate=GETDATE()
				WHERE   fldAshkhasId = @Value AND fldUserId IS NULL AND fldTicketCategoryId=@value2 and fldSeen=0
		 if (@@ERROR<>0)
		ROLLBACK
		end
		--	end
		--else
		--	begin
		--		UPDATE [dbo].[tblTicket]
		--		SET    fldSeen=@fldSeen,fldSeenDate=GETDATE()
		--		WHERE   fldSetadUserId = @Value AND fldTicketCategoryId=@value2 and (fldUserId is null or fldSetadUserId=fldUserId)
		--	end
		--if(@UserId=0)
		--	begin
		--		UPDATE [dbo].[tblTicket]
		--		SET    fldSeen=@fldSeen,fldSeenDate=GETDATE()
		--		WHERE   fldSetadUserId = @Value AND fldUserId IS NULL AND fldTicketCategoryId=@value2
		--	end
		--else
		--	begin
		--		UPDATE [dbo].[tblTicket]
		--		SET    fldSeen=@fldSeen,fldSeenDate=GETDATE()
		--		WHERE   fldSetadUserId = @Value AND fldUserId IS not NULL AND fldTicketCategoryId=@value2
		--	end
	
	COMMIT TRAN

GO
