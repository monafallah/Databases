SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Pay].[prs_tblCalcDetailDelete] 
	@Year smallint,
	@Month tinyint,
	@NobatPardakhtId int,
	@fldPersonalId int
AS 
	BEGIN TRAN
	declare @fldHeaderId int
	select @fldHeaderId=fldHeaderId from  pay.[tblCalcDetail] as c
	inner join	pay.[tblCalcHeader] as h on c.fldHeaderId=h.fldId
	where fldYear=@Year and fldMonth=@Month and fldNobatPardakhtId=@NobatPardakhtId  and fldPersonalId=@fldPersonalId

	DELETE c	FROM   pay.[tblCalcDetail] as c
	where fldHeaderId=@fldHeaderId and fldPersonalId=fldPersonalId
	if(@@ERROR<>0)
		rollback
	else
	begin
		if not exists(select fldHeaderId from  pay.[tblCalcDetail] as c
					  inner join pay.[tblCalcHeader] as h on c.fldHeaderId=h.fldId where h.fldId=@fldHeaderId)
		begin
			DELETE	FROM   pay.[tblCalcHeader]
			where fldId=@fldHeaderId
		end
	end
	COMMIT
GO
