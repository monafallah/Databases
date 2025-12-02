SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Pay].[spr_tblKosorateParametri_PersonalGroupInsert] 

    @fldPersonalId varchar(max),
    @fldParametrId int,
    @fldNoePardakht bit,
    @fldMablagh int,
    @fldTedad int,
    @fldTarikhePardakht nvarchar(10),
    @fldSumFish bit,
    @fldMondeFish bit,
    @fldSumPardakhtiGHabl int,
    @fldMondeGHabl int,
    @fldStatus bit,
    @fldDateDeactive int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	DECLARE @fldID int ,@Name Nvarchar(max)=''

	select @Name=@Name+Com.fn_FamilyEmployee(Prs.fldEmployeeId)+N'، '  from 
	[Pay].[tblKosorateParametri_Personal] as k INNER JOIN
    Pay.Pay_tblPersonalInfo as p ON k.fldPersonalId = p.fldId INNER JOIN
    Prs.Prs_tblPersonalInfo as prs ON p.fldPrs_PersonalInfoId = Prs.fldId
		where   k.fldParametrId=@fldParametrId AND k.fldMablagh=@fldMablagh AND k.fldTarikhePardakht=@fldTarikhePardakht
		and exists (select * from Com.Split(@fldPersonalId,';') where k.fldPersonalId=Item )

	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
		select @fldID =ISNULL(max(fldId),0) from [Pay].[tblKosorateParametri_Personal] 
		INSERT INTO [Pay].[tblKosorateParametri_Personal] ([fldId], [fldPersonalId], [fldParametrId], [fldNoePardakht], [fldMablagh], [fldTedad], [fldTarikhePardakht], [fldSumFish], [fldMondeFish], [fldSumPardakhtiGHabl], [fldMondeGHabl], [fldStatus], [fldDateDeactive], [fldUserId], [fldDesc], [fldDate])
		SELECT @fldId+ROW_NUMBER() over (order by Item), Item, @fldParametrId, @fldNoePardakht, @fldMablagh, @fldTedad, @fldTarikhePardakht, @fldSumFish, @fldMondeFish, @fldSumPardakhtiGHabl, @fldMondeGHabl, @fldStatus, @fldDateDeactive, @fldUserId, @fldDesc, GETDATE()
		from Com.Split(@fldPersonalId,';')
		where Item<>'' and not exists(select * from [Pay].[tblKosorateParametri_Personal] as k 
		where k.fldPersonalId=Item and  k.fldParametrId=@fldParametrId AND k.fldMablagh=@fldMablagh AND fldTarikhePardakht=@fldTarikhePardakht )
		if (@@ERROR<>0)
			ROLLBACK
		select @Name as fldName
	COMMIT
GO
