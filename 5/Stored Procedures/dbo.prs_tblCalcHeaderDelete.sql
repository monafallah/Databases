SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblCalcHeaderDelete] 
@Year smallint,
@Month tinyint,
@NobatPardakhtId int,
@fldOrganId int,
@TypeEstekhdam varchar(500),
@CostCenerId varchar(500)
AS 
	BEGIN TRAN

	DELETE c	FROM   [dbo].[tblCalcDetail] as c
	inner join	[dbo].[tblCalcHeader] as h on c.fldHeaderId=h.fldId
	where fldYear=@Year and fldMonth=@Month and fldNobatPardakhtId=@NobatPardakhtId  and fldOrganId=@fldOrganId
	and (@TypeEstekhdam='' or c.fldTypeEstekhdamId in (select Item from dbo.Split_CTE( @TypeEstekhdam,',')))
	and (@CostCenerId='' or c.fldCoscenterId in (select Item from dbo.Split_CTE( @CostCenerId,',')))
	if(@@ERROR<>0)
		rollback
	else
	begin
		DELETE c	FROM   [dbo].[tblCalcDetail] as c
		inner join	[dbo].[tblCalcHeader] as h on c.fldHeaderId=h.fldId
		where fldYear=@Year and fldMonth=@Month and fldNobatPardakhtId=@NobatPardakhtId  and fldOrganId=@fldOrganId
		and (@TypeEstekhdam='' or c.fldTypeEstekhdamId in (select Item from dbo.Split_CTE( @TypeEstekhdam,',')))
	and (@CostCenerId='' or c.fldCoscenterId in (select Item from dbo.Split_CTE( @CostCenerId,',')))
		if(@@ERROR<>0)
			rollback
		else if not exists (select * from [dbo].[tblCalcDetail] as c
							inner join	[dbo].[tblCalcHeader] as h on c.fldHeaderId=h.fldId
							where fldYear=@Year and fldMonth=@Month and fldNobatPardakhtId=@NobatPardakhtId  and fldOrganId=@fldOrganId)
			DELETE	FROM   [dbo].[tblCalcHeader]
			where fldYear=@Year and fldMonth=@Month and fldNobatPardakhtId=@NobatPardakhtId  and fldOrganId=@fldOrganId
	end
	COMMIT
GO
