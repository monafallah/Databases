SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCoding_DetailsUpdate] 
    @fldId int,
    
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
    @fldHeaderCodId INT,
	@fldMahiyat_GardeshId int
AS 
	BEGIN TRAN
	declare @flag bit=1
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldCode=Com.fn_TextNormalize(@fldCode)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [ACC].[tblCoding_Details]
	SET    [fldId] = @fldId, [fldTempCodingId] = @fldTempCodingId,fldTypeHesabId=@fldTypeHesabId, [fldTitle] = @fldTitle, [fldCode] = @fldCode, [fldAccountLevelId] = @fldAccountLevelId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIp] = @fldIp, [fldUserId] = @fldUserId,[fldMahiyatId]=@fldMahiyatId,[fldHeaderCodId]=@fldHeaderCodId
	,fldDaramadCode=@fldCodeDaramd,fldMahiyat_GardeshId=@fldMahiyat_GardeshId
	WHERE  [fldId] = @fldId
	if (@@ERROR<>0)
		rollback
	else
	begin
		declare @id int
		select @id=d.fldId from [ACC].[tblCoding_Details] as d
		cross apply    (select top 1 fldTempNameId from     
						 acc.tblCoding_Details as p   
						inner join acc.tblTemplateCoding as t on t.fldId=p.fldTempCodingId 
						where p.fldHeaderCodId=d.fldHeaderCodId and t.fldItemId=7 and d.fldCodeId.IsDescendantOf(p.fldCodeId) =1   )tempname 
		where d.fldId=@fldId

		if (@fldCodeDaramd is not null and @id is not null)
		begin
			declare @sal smallint 
			select @sal=fldYear from acc.tblCoding_Header where fldId=@fldHeaderCodId
			if not exists (select * from drd.tblCodhayeDaramd where fldDaramadCode=@fldCodeDaramd)
			begin
				declare @ItemId int,@CodeDaramdId HIERARCHYID=Null,@LastCode HIERARCHYID,@ChildDaramad  HIERARCHYID,@daramadId int,@levelid varchar(3)
				,@tempid int,@iddetail int,@pidDaramd varchar(15),@fldPID int
				
			
				select @fldPID=p.fldid  from ACC.tblCoding_Details s inner join
				ACC.tblCoding_Details as p  on s.fldHeaderCodId=@fldHeaderCodId and s.fldCodeId.GetAncestor(1)=p.fldCodeId
				where s.fldid=@fldId

				select @pidDaramd=fldDaramadCode from acc.tblCoding_Details where fldid=@fldPID
				select @CodeDaramdId=fldDaramadId from drd.tblCodhayeDaramd where fldDaramadCode=@pidDaramd

				if(@CodeDaramdId is null)
				begin 
					set @flag=0
				end
				--	select @CodeDaramdId=fldDaramadId from drd.tblCodhayeDaramd where fldid= 1
				else
					begin
					SELECT @LastCode=MAX(fldDaramadId) FROM drd.tblCodhayeDaramd WHERE fldDaramadId.GetAncestor(1)=@CodeDaramdId--بزرگترین فرزندی که یک جد بالاتر آن  با ورودی  برابر باشد 
					SELECT @ChildDaramad=@CodeDaramdId.GetDescendant(@LastCode,NULL)
				
					SELECT @daramadId =ISNULL(max(fldId),0)+1 from [Drd].[tblCodhayeDaramd] 
					INSERT INTO Drd.tblCodhayeDaramd( fldId ,fldDaramadId ,fldDaramadCode ,fldDaramadTitle ,fldMashmooleArzesheAfzoode ,fldMashmooleKarmozd ,fldUnitId ,fldUserId ,fldDesc ,fldDate)
					SELECT  @daramadId,@ChildDaramad, @fldCodeDaramd, @fldTitle, 0, 0,8, @fldUserId, @fldDesc,getdate()
					if (@@ERROR<>0)
						ROLLBACK
					SELECT @iddetail =ISNULL(max(fldId),0)+1 from [Drd].tblShomareHedabCodeDaramd_Detail 
						insert into [Drd].tblShomareHedabCodeDaramd_Detail 
						select @iddetail,@sal,@sal,@daramadId,getdate(),@fldUserId
						if(@@ERROR<>0)
							rollback
				end
				

			end
		else begin
		
					select @daramadId=fldid from drd.tblCodhayeDaramd where fldDaramadCode=@fldCodeDaramd
					if exists (select * from drd.tblShomareHedabCodeDaramd_Detail where fldCodeDaramdId=@daramadId)
						begin
							update d
							set fldEndYear=@sal
							from drd.tblShomareHedabCodeDaramd_Detail d
							where fldCodeDaramdId=@daramadId
							if(@@ERROR<>0)
								rollback
						end
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
	select @flag as flag

	COMMIT TRAN
GO
