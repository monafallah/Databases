SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMotalebateParametri_PersonalGroupInsert] 

    @fldPersonalId varchar(max),
    @fldParametrId int,
    @fldNoePardakht bit,
    @fldMablagh int,
    @fldTedad int,
    @fldTarikhPardakht nvarchar(10),
    @fldMashmoleBime bit,
	@fldMazayaMashmool bit,
    @fldMashmoleMaliyat bit,
    @fldStatus bit,
    @fldDateDeactive int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int ,@Name Nvarchar(max)=''

	select @Name=@Name+Com.fn_FamilyEmployee(Prs.fldEmployeeId)+N'، '  from 
	[Pay].[tblMotalebateParametri_Personal] as k INNER JOIN
    Pay.Pay_tblPersonalInfo as p ON k.fldPersonalId = p.fldId INNER JOIN
    Prs.Prs_tblPersonalInfo as prs ON p.fldPrs_PersonalInfoId = Prs.fldId
		where   k.fldParametrId=@fldParametrId AND k.fldMablagh=@fldMablagh AND k.fldTarikhPardakht=@fldTarikhPardakht
		and exists (select * from Com.Split(@fldPersonalId,';') where k.fldPersonalId=Item )

	select @fldID =ISNULL(max(fldId),0) from [Pay].[tblMotalebateParametri_Personal] 
	INSERT INTO [Pay].[tblMotalebateParametri_Personal] ([fldId], [fldPersonalId], [fldParametrId], [fldNoePardakht], [fldMablagh], [fldTedad], [fldTarikhPardakht], [fldMashmoleBime], [fldMashmoleMaliyat], [fldStatus], [fldDateDeactive], [fldUserId], [fldDesc], [fldDate],fldMazayaMashmool)
	SELECT @fldId+ROW_NUMBER() over (order by Item), Item, @fldParametrId, @fldNoePardakht, @fldMablagh, @fldTedad, @fldTarikhPardakht, @fldMashmoleBime, @fldMashmoleMaliyat, @fldStatus, @fldDateDeactive, @fldUserId, @fldDesc, GETDATE(),@fldMazayaMashmool
	from Com.Split(@fldPersonalId,';')
		where Item<>'' and not exists(select * from [Pay].[tblMotalebateParametri_Personal] as k 
		where k.fldPersonalId=Item and  k.fldParametrId=@fldParametrId AND k.fldMablagh=@fldMablagh AND fldTarikhPardakht=@fldTarikhPardakht )
		if (@@ERROR<>0)
			ROLLBACK
		select @Name as fldName

	COMMIT
GO
