SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[CopyFromTemplateCodingToCoding] 
    @fldHeaderId int,
    @fldTempNameId int,
	@TempCode  acc.TemplateCode readonly,
    @fldIp varchar(16),
    @fldUserId int
as
begin tran
declare @fldID int , @fldOrganId int=0,  @fldYear smallint=0
	select @fldID =ISNULL(max(fldId),0) from [ACC].tblCoding_Details 
select @fldOrganId=fldOrganId,@fldYear=fldYear from acc.tblCoding_Header where fldId=@fldHeaderId

DECLARE @NewIds TABLE(ID INT)
insert ACC.tblCoding_Details ([fldId], fldCodeId, [fldPCod], [fldTempCodingId], [fldTitle], [fldCode],[fldAccountLevelId], [fldDesc], [fldDate], [fldIp], [fldUserId],[fldMahiyatId],[fldHeaderCodId],fldTypeHesabId,fldDaramadCode)
OUTPUT Inserted.fldId INTO @NewIds
select  @fldID+ROW_NUMBER() over (order by t.fldid),fldTempCodeId
,fldPCod,t.fldId,t.fldName, fldCode,(select a.fldId from ACC.tblAccountingLevel as a where a.fldOrganId=@fldOrganId and a.fldYear=@fldYear and a.fldName=l.fldName)levelid
 ,t.fldDesc,GETDATE() date,@fldIp,@fldUserId,fldMahiyatId,@fldHeaderId,fldTypeHesabId,te.[fldDaramadCode]
  from Acc.tblTemplateCoding as t inner join
  Acc.tblLevelsAccountingType as l on l.fldId=t.fldLevelsAccountTypId
  left join @tempcode  te on te.fldid=t.fldid
  where fldTempNameId=@fldTempNameId 
order by fldCode


if (@@ERROR<>0)
		ROLLBACK
	else------------------------------------بدست آوردن آیتم مربوط به درآمد
	begin
		
		declare @ItemId int,@CodeDaramdId HIERARCHYID=Null,@LastCode HIERARCHYID,@ChildDaramad  HIERARCHYID,@daramadId int,@levelid varchar(3)
		,@tempid int,@id int ,@fldTitle Nvarchar(300),@fldHeaderCodId int ,@fldCode varchar(300),@P_Daramd varchar(15),@C_Daramd varchar(15)
		,@sal smallint ,@iddetail int
		set @sal =substring(dbo.Fn_AssembelyMiladiToShamsi(getdate()),1,4)
		
		DECLARE db_cursor CURSOR FOR 
select child.fldid,child.fldTitle,child.fldHeaderCodId,child.fldCode
,parent.fldDaramadCode PDaramdCode,child.fldDaramadCode CDaramdCode
from  ACC.tblCoding_Details as child  inner join
		 acc.tblCoding_Details parent on  child.fldCodeId.GetAncestor(1)=parent.fldCodeId
		 
--inner join Acc.tblTemplateCoding as t on t.fldId=d.fldTempCodingId
--where --child.fldId in (select ID from @NewIds) and parent.fldid  in (select ID from @NewIds)
where child.fldHeaderCodId =@fldHeaderId and parent.fldHeaderCodId=@fldHeaderId
/*and parent.fldDaramadCode  is not null */and child.fldDaramadCode is not null

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @id,@fldTitle,@fldHeaderCodId,@fldCode,@P_Daramd,@C_Daramd

WHILE @@FETCH_STATUS = 0  
BEGIN  
			select @daramadId=fldid from drd.tblCodhayeDaramd where fldDaramadCode=@C_Daramd
			if exists (select * from drd.tblShomareHedabCodeDaramd_Detail where fldCodeDaramdId=@daramadId)
					update d
					set fldEndYear=@sal,fldDate=getdate()
					from drd.tblShomareHedabCodeDaramd_Detail d
					where fldCodeDaramdId=@daramadId
				else
				begin
					select @CodeDaramdId=fldDaramadId from drd.tblCodhayeDaramd where fldDaramadCode=@P_Daramd

					if(@CodeDaramdId is null)
						select @CodeDaramdId=fldDaramadId from drd.tblCodhayeDaramd where fldid= 1
			

							SELECT @LastCode=MAX(fldDaramadId) FROM drd.tblCodhayeDaramd WHERE fldDaramadId.GetAncestor(1)=@CodeDaramdId--بزرگترین فرزندی که یک جد بالاتر آن  با ورودی  برابر باشد 
							SELECT @ChildDaramad=@CodeDaramdId.GetDescendant(@LastCode,NULL)
					
							SELECT @daramadId =ISNULL(max(fldId),0)+1 from [Drd].[tblCodhayeDaramd] 
							INSERT INTO Drd.tblCodhayeDaramd( fldId ,fldDaramadId ,fldDaramadCode ,fldDaramadTitle ,fldMashmooleArzesheAfzoode ,fldMashmooleKarmozd ,fldUnitId ,fldUserId ,fldDesc ,fldDate)
							SELECT  @daramadId,@ChildDaramad, @fldCode, @fldTitle, 0, 0,8, @fldUserId, '',getdate()
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
			

      FETCH NEXT FROM db_cursor INTO @id,@fldTitle,@fldHeaderCodId,@fldCode,@P_Daramd,@C_Daramd
END 

CLOSE db_cursor  
DEALLOCATE db_cursor
		

				
		end

	commit tran
GO
