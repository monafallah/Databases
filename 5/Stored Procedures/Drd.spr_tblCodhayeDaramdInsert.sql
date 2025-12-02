SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCodhayeDaramdInsert] 
    @id int,
    @fldDaramadCode varchar(50),
    @fldDaramadTitle nvarchar(250),
    @fldMashmooleArzesheAfzoode bit,
    @fldMashmooleKarmozd bit,
	@fldAmuzeshParvaresh bit,
	@fldUnitId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	set  @fldDaramadCode=com.fn_TextNormalize( @fldDaramadCode)
	set  @fldDaramadTitle=com.fn_TextNormalize(@fldDaramadTitle)
	set  @fldDesc=com.fn_TextNormalize( @fldDesc)
	DECLARE @fldID int ,@Childe HIERARCHYID ,@last HIERARCHYID,@fldDaramadId HIERARCHYID,@detailid int,@sal smallint
	set @sal=substring(dbo.Fn_AssembelyMiladiToShamsi(cast(getdate() as date )),1,4)
	IF (@id=0)
	BEGIN
		SET @Childe=hierarchyid::GetRoot()
	END
	ELSE
	BEGIN
	SELECT @fldDaramadId=fldDaramadId FROM Drd.tblCodhayeDaramd WHERE fldId=@id
	SELECT @last=MAX(fldDaramadId) FROM [tblCodhayeDaramd] WHERE fldDaramadId.GetAncestor(1)=@fldDaramadId--بزرگترین فرزندی که یک جد بالاتر آن  با ورودی  برابر باشد 
	SELECT @Childe=@fldDaramadId.GetDescendant(@last,NULL) --جدیدترین فرزند یک جد را میدهد
	end
	SELECT @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblCodhayeDaramd] 
	INSERT INTO Drd.tblCodhayeDaramd( fldId ,fldDaramadId ,fldDaramadCode ,fldDaramadTitle ,fldMashmooleArzesheAfzoode ,fldMashmooleKarmozd ,fldUnitId ,fldUserId ,fldDesc ,fldDate,fldAmuzeshParvaresh)
	SELECT  @fldId,@Childe, @fldDaramadCode, @fldDaramadTitle, @fldMashmooleArzesheAfzoode, @fldMashmooleKarmozd,@fldUnitId, @fldUserId, @fldDesc,getdate(),@fldAmuzeshParvaresh
	if (@@ERROR<>0)
		ROLLBACK

	else 
	begin
	SELECT @detailid =ISNULL(max(fldId),0)+1 from [Drd].tblShomareHedabCodeDaramd_Detail 
	insert into [Drd].tblShomareHedabCodeDaramd_Detail 
	select @detailid,@sal,@sal,@fldId,getdate(),1
	if (@@ERROR<>0)
		ROLLBACK
	end
	COMMIT
GO
