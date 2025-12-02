SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Drd].[spr_InsertHesabdariToDaramad](@fldorganId int,@fldYear smallint, @userid int)
as
begin tran
declare @headerId int
select @headerId=fldid from acc.tblCoding_Header where fldOrganId=@fldorganId and fldYear=@fldYear

--declare @daramadId int 
--SELECT @daramadId =ISNULL(max(fldId),0) from [Drd].[tblCodhayeDaramd] 
--INSERT INTO Drd.tblCodhayeDaramd( fldId ,fldDaramadId ,fldDaramadCode ,fldDaramadTitle ,fldMashmooleArzesheAfzoode ,fldMashmooleKarmozd ,fldUnitId ,fldUserId ,fldDesc ,fldDate,fldAcc_CodingDetailId)
--select row_number()over (order by d.fldid)+@daramadId,fldCodeId,fldCode,fldTitle,0,0,1,@userid,fldDesc,getdate(),d.fldid from 
--	(
--		select child.fldid--,child.fldItemId, parent.fldItemId,child.*
--		from  acc.tblTemplateCoding child inner join
--		 acc.tblTemplateCoding parent on  child.fldTempCodeId.IsDescendantOf(parent.fldTempCodeId)=1
--		 cross apply (select  child.fldid from ACC.tblItemNecessary child inner join
--						ACC.tblItemNecessary parent on  child.fldItemId.IsDescendantOf(parent.fldItemId)=1
--						where parent.fldid=7
--						group by child.fldid,parent.fldid )item

--		 where  parent.fldItemId =item.fldid and parent.fldTempNameId=child.fldTempNameId
--		 )t
--		 inner join  acc.tblCoding_Details d on d.fldTempCodingId=t.fldid-- and child.fldLevelId>1
--		where fldHeaderCodId=@headerId and fldLevelId>1


declare @ItemId int,@CodeDaramdId HIERARCHYID=Null,@LastCode HIERARCHYID,@ChildDaramad  HIERARCHYID,@daramadId int=0,@levelid varchar(3)
		,@tempid int,@id int ,@fldTitle Nvarchar(300),@fldHeaderCodId int ,@fldCode varchar(300),@P_Daramd varchar(15),@C_Daramd varchar(15)
		,@sal smallint ,@iddetail int,@Iddaramad int
		set @sal =substring(dbo.Fn_AssembelyMiladiToShamsi(getdate()),1,4)
		
DECLARE db_cursor CURSOR FOR 
select  child.fldid,child.fldTitle,child.fldHeaderCodId,child.fldCode
,parent.fldDaramadCode PDaramdCode,child.fldDaramadCode CDaramdCode
from  ACC.tblCoding_Details as child  inner join
		 acc.tblCoding_Details parent on  child.fldCodeId.GetAncestor(1)=parent.fldCodeId
		cross apply( select  chi1.fldid--,child.fldItemId, parent.fldItemId,child.*
		from  acc.tblTemplateCoding chi1 inner join
		 acc.tblTemplateCoding p1 on  chi1.fldTempCodeId.IsDescendantOf(p1.fldTempCodeId)=1
		 cross apply (select child2.fldid from ACC.tblItemNecessary child2 inner join
						ACC.tblItemNecessary parent2 on  child2.fldItemId.IsDescendantOf(parent2.fldItemId)=1
						where parent2.fldid=7
						group by child2.fldid,parent2.fldid )item

		 where  p1.fldItemId =item.fldid and p1.fldTempNameId=chi1.fldTempNameId
		 group by  chi1.fldid )t
		 where child.fldHeaderCodId=@headerId and parent.fldHeaderCodId=@headerId
		 and child.fldDaramadCode is not null and t.fldid=child.fldTempCodingId
		 order by child.fldStrhid



OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @id,@fldTitle,@fldHeaderCodId,@fldCode,@P_Daramd,@C_Daramd

WHILE @@FETCH_STATUS = 0  
BEGIN  

			/*select @daramadId=fldid from drd.tblCodhayeDaramd where fldDaramadCode=@C_Daramd and fldDaramadTitle=@fldTitle
			if exists (select * from drd.tblShomareHedabCodeDaramd_Detail where fldCodeDaramdId=@daramadId)
			begin
					update d
					set fldEndYear=@sal,fldDate=getdate()
					from drd.tblShomareHedabCodeDaramd_Detail d
					where fldCodeDaramdId=@daramadId
						if (@@ERROR<>0)
							ROLLBACK
			end
				else
				begin*/
				set @CodeDaramdId=NULL
					select @CodeDaramdId=fldDaramadId from drd.tblCodhayeDaramd where fldDaramadCode=@P_Daramd

					if(@CodeDaramdId is null)
					begin
						select @CodeDaramdId=fldDaramadId from drd.tblCodhayeDaramd where fldid= 1
					end

							SELECT @LastCode=MAX(fldDaramadId) FROM drd.tblCodhayeDaramd WHERE fldDaramadId.GetAncestor(1)=@CodeDaramdId--بزرگترین فرزندی که یک جد بالاتر آن  با ورودی  برابر باشد 
							SELECT @ChildDaramad=@CodeDaramdId.GetDescendant(@LastCode,NULL)
					
							SELECT @Iddaramad =ISNULL(max(fldId),0)+1 from [Drd].[tblCodhayeDaramd] 
							INSERT INTO Drd.tblCodhayeDaramd( fldId ,fldDaramadId ,fldDaramadCode ,fldDaramadTitle ,fldMashmooleArzesheAfzoode ,fldMashmooleKarmozd ,fldUnitId ,fldUserId ,fldDesc ,fldDate)
							SELECT  @Iddaramad,@ChildDaramad, @C_Daramd/*@fldCode*/, @fldTitle, 0, 0,8, @userid, '',getdate()
							if (@@ERROR<>0)
								ROLLBACK
						else
							begin
								SELECT @iddetail =ISNULL(max(fldId),0)+1 from [Drd].tblShomareHedabCodeDaramd_Detail 
								insert into [Drd].tblShomareHedabCodeDaramd_Detail 
								select @iddetail,@sal,@sal,@Iddaramad,getdate(),@userid
								if(@@ERROR<>0)
									rollback
							end
			/*	end
			set @daramadId=0*/

      FETCH NEXT FROM db_cursor INTO @id,@fldTitle,@fldHeaderCodId,@fldCode,@P_Daramd,@C_Daramd
END 

CLOSE db_cursor  
DEALLOCATE db_cursor
		

				
	commit
GO
