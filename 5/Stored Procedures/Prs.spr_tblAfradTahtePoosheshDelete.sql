SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblAfradTahtePoosheshDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	declare @Sen int,@BimeTakmiliId int

	select @Sen= datediff(year,t.flddate,getdate()) from [Prs].[tblAfradTahtePooshesh]  as a
	inner join com.tblDateDim as t on t.fldTarikh=a.fldBirthDate
	WHERE  fldId = @fldId

	select @BimeTakmiliId=fldBimeTakmiliId from pay.tblAfradeTahtePoshesheBimeTakmily_Details
	where fldAfradTahtePoshehsId=@fldID

	UPDATE  [Prs].[tblAfradTahtePooshesh]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldId = @fldId

	delete pay.tblAfradeTahtePoshesheBimeTakmily_Details
	where fldAfradTahtePoshehsId=@fldID

	if(@@ERROR<>0)
		rollback
	else
	begin
		update pay.tblAfradeTahtePoshesheBimeTakmily set fldTedadAsli=case when @sen<60 then fldTedadAsli-1  
		when @sen>=60 and @sen<70 then fldTedadTakafol60Sal-1
		when @sen>=70 then fldTedadTakafol60Sal-1 end
		where fldId=@BimeTakmiliId

		DELETE
		FROM   [Prs].[tblAfradTahtePooshesh]
		WHERE  fldId = @fldId
		if(@@ERROR<>0)
			rollback
	end
	COMMIT
GO
