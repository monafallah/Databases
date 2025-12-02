SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblAfradeTahtePoshesheBimeTakmilyCopy] 
@fldGHarardadBimeId_From int,
@fldGHarardadBimeId_To int,
@fldUserId int
as
begin tran
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0) from [Pay].[tblAfradeTahtePoshesheBimeTakmily] 
	INSERT INTO [Pay].[tblAfradeTahtePoshesheBimeTakmily] ([fldId], [fldPersonalId], [fldTedadAsli], [fldTedadTakafol60Sal], [fldTedadTakafol70Sal], [fldGHarardadBimeId], [fldUserId], [fldDesc], [fldDate])
	select @fldID+ROW_NUMBER() over (order by [fldId]), [fldPersonalId], [fldTedadAsli], [fldTedadTakafol60Sal], [fldTedadTakafol70Sal], @fldGHarardadBimeId_To, @fldUserId, '', GETDATE()
	from pay.tblAfradeTahtePoshesheBimeTakmily
	where fldGHarardadBimeId=@fldGHarardadBimeId_From
	if (@@ERROR<>0)
		ROLLBACK
	else
	begin
		declare @fldDetailID int 
		select @fldDetailID =ISNULL(max(fldId),0) from [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] 

		INSERT INTO [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] ([fldId], [fldAfradTahtePoshehsId], [fldBimeTakmiliId], [fldUserId], [fldDesc], [fldDate])
		select @fldDetailID+ROW_NUMBER() over(order by d.[fldId]), [fldAfradTahtePoshehsId],t2.fldId,@fldUserId, '', GETDATE() 
		from [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] as d
		inner join [Pay].[tblAfradeTahtePoshesheBimeTakmily] as t on t.fldId=d.fldBimeTakmiliId
		inner join prs.tblAfradTahtePooshesh as a on a.fldId=d.fldAfradTahtePoshehsId
		inner join pay.Pay_tblPersonalInfo as p on p.fldId=t.fldPersonalId
		cross apply(select t2.fldId from [Pay].[tblAfradeTahtePoshesheBimeTakmily] as t2 where t2.fldPersonalId=t.fldPersonalId and fldGHarardadBimeId=@fldGHarardadBimeId_To)t2
		where fldGHarardadBimeId=@fldGHarardadBimeId_From
		order by [fldBimeTakmiliId]
		if(@@Error<>0)
			rollback   
	end

COMMIT
GO
