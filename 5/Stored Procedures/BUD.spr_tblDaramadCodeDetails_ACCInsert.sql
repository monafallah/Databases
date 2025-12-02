SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblDaramadCodeDetails_ACCInsert] 
    @fldCodingAcc_DetailsId int,
    @fldTypeID varchar(max),
    @fldPercentHazine decimal(5, 2),
    @fldPercentTamallok decimal(5, 2),
    @fldUserId int,
    @fldIp varchar(15)
AS 
	
	BEGIN TRAN
	delete  from [BUD].[tblDaramadCodeDetails_ACC] where fldCodingAcc_DetailsId=@fldCodingAcc_DetailsId
	if (@@ERROR<>0)
		ROLLBACK

	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [BUD].[tblDaramadCodeDetails_ACC] 
	INSERT INTO [BUD].[tblDaramadCodeDetails_ACC] ([fldId], [fldCodingAcc_DetailsId], [fldType], [fldTypeID],  [fldUserId], [fldIp], [fldDate])
	SELECT @fldId+ROW_NUMBER() over(order by id), @fldCodingAcc_DetailsId, type, id, @fldUserId, @fldIp, GETDATE()  from(
	select s.value,s2.value as id,lead(s2.value) over (partition by s.value order by s.value) type from string_split(@fldTypeID,',') as s 
	cross apply(select *  from string_split(s.value,';') as s2 )s2
	where s2.value<>''
	)t
	where type is not null
	if (@@ERROR<>0)
		ROLLBACK
	else
	BEGIN
		declare @ID int 
		select @ID =ISNULL(max(fldId),0)+1 from [BUD].tblCodingAccPercent 

		merge [BUD].tblCodingAccPercent as t
		using (select @fldCodingAcc_DetailsId, @fldPercentHazine, @fldPercentTamallok) as s ( fldCodingAcc_DetailsId, fldPercentHazine, fldPercentTamallok)
		on t.fldCodingAcc_DetailsId=s.fldCodingAcc_DetailsId
		when matched then
		update  set fldPercentHazine=s.fldPercentHazine,t.fldPercentTamallok=s.fldPercentTamallok
		when not matched then
		INSERT  ([fldId], [fldCodingAcc_DetailsId], [fldPercentHazine], [fldPercentTamallok], [fldUserId], [fldIp], [fldDate])
		values( @ID, fldCodingAcc_DetailsId, fldPercentHazine, fldPercentTamallok, @fldUserId, @fldIp, GETDATE());

	end

	COMMIT
GO
