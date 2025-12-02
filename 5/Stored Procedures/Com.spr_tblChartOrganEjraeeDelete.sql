SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblChartOrganEjraeeDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	declare @flag bit=0

	/*delete from auto.tblSecretariat
	where fldChartOrganEjraeeId=@fldid
	if (@@ERROR<>0)
	begin
		rollback
		set @flag=1
	end*/
	if (@flag=0)
	begin
		UPDATE    [Com].[tblChartOrganEjraee]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldid=@fldID 
		if (@@ERROR<>0)
		begin
			rollback
			set @flag=1
		end
	
		DELETE
		FROM   [Com].[tblChartOrganEjraee]
		WHERE  fldId = @fldId
		if (@@ERROR<>0)
		begin
			rollback
			set @flag=1
		end
	end
	COMMIT
GO
