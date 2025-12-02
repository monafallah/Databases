SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCoding_DetailsInsert] 
    
    @fldPID int,
    @fldPCod VARCHAR(100),
    
    @fldTempCodingId int,
    @fldTitle nvarchar(200),
    @fldCode VARCHAR(100),
	@fldCodeDaramd varchar(15),
    @fldAccountLevelId int,
	@fldTypeHesabId tinyint,
    @fldDesc nvarchar(MAX),
    
    @fldIp varchar(16),
    @fldUserId INT,
    @fldMahiyatId INT,
    @fldHeaderCodId int,
	@fldMahiyat_GardeshId int
AS 
	
	BEGIN TRAN
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldCode=Com.fn_TextNormalize(@fldCode)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int ,@Child HIERARCHYID ,@last HIERARCHYID,@fldCodeId HIERARCHYID
	--IF (@fldPID=0)
	--BEGIN
	--	SET @Child=hierarchyid::GetRoot()
	--END
	--ELSE
	--BEGIN
		SELECT @fldCodeId=fldCodeId FROM [ACC].[tblCoding_Details] WHERE fldId=@fldPID
		SELECT @last=MAX(fldCodeId) FROM [ACC].[tblCoding_Details] WHERE fldCodeId.GetAncestor(1)=@fldCodeId--بزرگترین فرزندی که یک جد بالاتر آن  با ورودی  برابر باشد 
		SELECT @Child=@fldCodeId.GetDescendant(@last,NULL) --جدیدترین فرزند یک جد را میدهد
	--end
	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblCoding_Details] 
	INSERT INTO [ACC].[tblCoding_Details] ([fldId], fldCodeId, [fldPCod], [fldTempCodingId], [fldTitle], [fldCode],[fldAccountLevelId], [fldDesc], [fldDate], [fldIp], [fldUserId],[fldMahiyatId],[fldHeaderCodId],fldTypeHesabId,fldDaramadCode,fldMahiyat_GardeshId)
	SELECT @fldId, @Child, @fldPCod,  @fldTempCodingId, @fldTitle, @fldCode, @fldAccountLevelId, @fldDesc, GETDATE(), @fldIp, @fldUserId,@fldMahiyatId,@fldHeaderCodId,@fldTypeHesabId,@fldCodeDaramd,@fldMahiyat_GardeshId
	if (@@ERROR<>0)
		ROLLBACK
	else
	begin
		declare @id int
		select @id=d.fldId from [ACC].[tblCoding_Details] as d
		cross apply    (select top 1 fldTempNameId from     
						 acc.tblCoding_Details as p   
						inner join acc.tblTemplateCoding as t on t.fldId=p.fldTempCodingId 
						where p.fldHeaderCodId=d.fldHeaderCodId and t.fldItemId=7 and d.fldCodeId.IsDescendantOf(p.fldCodeId) =1   )tempname 
		where d.fldId=@fldId

		if (@id is not null)
		begin
			------------------------------------بدست آوردن آیتم مربوط به درآمد
			declare @ItemId int,@CodeDaramdId HIERARCHYID=Null,@LastCode HIERARCHYID,@ChildDaramad  HIERARCHYID,@daramadId int,@levelid varchar(3)
			,@tempid int,@iddetail int,@sal smallint ,@pidDaramd varchar(15)
			select @sal=fldYear from acc.tblCoding_Header where fldId=@fldHeaderCodId
			--set @sal =substring(dbo.Fn_AssembelyMiladiToShamsi(getdate()),1,4)

			/*select @tempid=parent.fldTempCodingId from  acc.tblCoding_Details child inner join
			 acc.tblCoding_Details parent on child.fldId=@fldPID and child.fldCodeId.IsDescendantOf(parent.fldCodeId)=1
			 and parent.fldLevelId=1 and parent.fldHeaderCodId=@fldHeaderCodId


			select @ItemId= parent.fldid from ACC.tblItemNecessary child inner join
			ACC.tblItemNecessary parent on  child.fldItemId.IsDescendantOf(parent.fldItemId)=1
			inner join acc.tblTemplateCoding t on t.fldItemId=child.fldId
			where t.fldid=@tempid  and parent.fldLevelId=1

			if (@ItemId=7 )
			begin*/
				select @pidDaramd=fldDaramadCode from acc.tblCoding_Details where fldid=@fldPID
				select @CodeDaramdId=fldDaramadId from drd.tblCodhayeDaramd where fldDaramadCode=@pidDaramd

				if(@CodeDaramdId is null)
					select @CodeDaramdId=fldDaramadId from drd.tblCodhayeDaramd where fldid= 1

				SELECT @LastCode=MAX(fldDaramadId) FROM drd.tblCodhayeDaramd WHERE fldDaramadId.GetAncestor(1)=@CodeDaramdId--بزرگترین فرزندی که یک جد بالاتر آن  با ورودی  برابر باشد 
				SELECT @ChildDaramad=@CodeDaramdId.GetDescendant(@LastCode,NULL)
		

			if (@fldCodeDaramd <>'')
			begin
		
				select @daramadId=fldid from drd.tblCodhayeDaramd where fldDaramadCode=@fldCodeDaramd
					if exists (select * from drd.tblShomareHedabCodeDaramd_Detail where fldCodeDaramdId=@daramadId )
						update d
						set fldEndYear=@sal
						from drd.tblShomareHedabCodeDaramd_Detail d
						where fldCodeDaramdId=@daramadId
					else
					begin
						SELECT @daramadId =ISNULL(max(fldId),0)+1 from [Drd].[tblCodhayeDaramd] 
							INSERT INTO Drd.tblCodhayeDaramd( fldId ,fldDaramadId ,fldDaramadCode ,fldDaramadTitle ,fldMashmooleArzesheAfzoode ,fldMashmooleKarmozd ,fldUnitId ,fldUserId ,fldDesc ,fldDate)
							SELECT  @daramadId,@ChildDaramad, @fldCodeDaramd, @fldTitle, 0, 0,8, @fldUserId, @fldDesc,getdate()
							if (@@ERROR<>0)
								ROLLBACK
						else
						begin
							SELECT @iddetail =ISNULL(max(fldId),0)+1 from [Drd].tblShomareHedabCodeDaramd_Detail 
							insert into [Drd].tblShomareHedabCodeDaramd_Detail 
							select @iddetail,@sal,@sal,@daramadId,getdate(),@fldUserId
							if(@@ERROR<>0)
								rollback
						end
					end
			

			end
		end
	end
	


	COMMIT
GO
