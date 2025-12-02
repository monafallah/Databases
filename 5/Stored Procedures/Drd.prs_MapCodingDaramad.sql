SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Drd].[prs_MapCodingDaramad](@OldCode varchar(20),@NewCode varchar(20),@Title nvarchar(200),@userId int,@pcode varchar(20))
/*اول داده های حسابداری باید در جدول های حسابداری اینزرت شود
سپس داده های جدول tblShomareHedabCodeDaramd_Detail بجز آیدی 1 فیلد تاتاریخ به سال قبل آپدیت شود بعد
با این پروسیجر کدینگ جدید از  حسابداری در درامد باید اینزرت شود [Drd].[spr_InsertHesabdariToDaramad] */
--declare @OldCode varchar(20)='320200',@NewCode varchar(20)='9200',@Title nvarchar(200)=N'انواع صکوک',@userId int=1,@pcode varchar(20)='9000'
as
begin try 
begin tran

declare @idCode int,@idOldCode int,@idhesabNew int,@idHesabOld int,@idFormul int,@errorId int,
@parametrSabetid int,@idMahdodiyat int,@idTakhfif int,@idLetter int,@idRoonevesht int,@pid int,@Nerkhid int


---------------------[tblCodhayeDaramd]

DECLARE @fldID int ,@Childe HIERARCHYID ,@last HIERARCHYID,@fldDaramadId HIERARCHYID,@detailid int,@sal smallint
set @sal=substring(dbo.Fn_AssembelyMiladiToShamsi(cast(getdate() as date )),1,4)
--SELECT @pid=fldid FROM Drd.tblCodhayeDaramd WHERE fldDaramadCode=@pcode /*کددرامدپدر*/
if not exists (select * from drd.tblCodhayeDaramd c inner join drd.tblShomareHedabCodeDaramd_Detail d
				on c.fldid=d.fldCodeDaramdId where fldStartYear=@sal and fldEndYear=@sal and fldDaramadCode=@NewCode)
begin
	SELECT top(1) @fldDaramadId=fldDaramadId FROM Drd.tblCodhayeDaramd c  inner join drd.tblShomareHedabCodeDaramd_Detail d
					on c.fldid=d.fldCodeDaramdId where fldStartYear=@sal and fldEndYear=@sal
					and  fldDaramadCode=@pcode order by c.flddate desc--fldId=@pid
	SELECT @last=MAX(fldDaramadId) FROM drd.[tblCodhayeDaramd] WHERE fldDaramadId.GetAncestor(1)=@fldDaramadId--بزرگترین فرزندی که یک جد بالاتر آن  با ورودی  برابر باشد 
	SELECT @Childe=@fldDaramadId.GetDescendant(@last,NULL)

	SELECT @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblCodhayeDaramd] 
	INSERT INTO Drd.tblCodhayeDaramd( fldId ,fldDaramadId ,fldDaramadCode ,fldDaramadTitle ,fldMashmooleArzesheAfzoode ,fldMashmooleKarmozd ,fldUnitId ,fldUserId ,fldDesc ,fldDate)
	select top(1) @fldID,@Childe,@NewCode,@Title,fldMashmooleArzesheAfzoode,fldMashmooleKarmozd,fldUnitId,@userId,fldDesc,getdate() from drd.tblCodhayeDaramd c
	inner join drd.tblShomareHedabCodeDaramd_Detail d
					on c.fldid=d.fldCodeDaramdId
					 where  fldDaramadCode=@OldCode  and fldStartYear<>@sal and fldEndYear<>@sal
	order by c.fldDate desc

	-------------tblShomareHedabCodeDaramd_Detail

	SELECT @detailid =ISNULL(max(fldId),0)+1 from [Drd].tblShomareHedabCodeDaramd_Detail 
	insert into [Drd].tblShomareHedabCodeDaramd_Detail 
	select @detailid,@sal,@sal,@fldId,getdate(),1
end
else 
	begin 
			select @fldID= c.fldId from drd.tblCodhayeDaramd c inner join drd.tblShomareHedabCodeDaramd_Detail d
				on c.fldid=d.fldCodeDaramdId
				where fldStartYear=@sal and fldEndYear=@sal and fldDaramadCode=@NewCode
	end
----------------------------------------------------------------[tblShomareHesabCodeDaramad]

select top(1) @idOldCode=c.fldid,@idHesabOld=s.fldid from drd.tblCodhayeDaramd c inner join 
drd.tblShomareHesabCodeDaramad s on s.fldCodeDaramadId=c.fldid
inner join drd.tblShomareHedabCodeDaramd_Detail d on c.fldid=d.fldCodeDaramdId
 where fldDaramadCode=@OldCode and fldStartYear<>@sal and fldEndYear<>@sal
 order by c.fldDate desc
-- if not exists (select * from drd.tblShomareHesabCodeDaramad  s inner join drd.tblCodhayeDaramd c
--						on c.fldid=s.fldCodeDaramadId
--				inner join drd.tblShomareHedabCodeDaramd_Detail d on c.fldid=d.fldCodeDaramdId
--				where fldDaramadCode=@NewCode and   fldStartYear=@sal and fldEndYear=@sal
--				)
--begin
select @idhesabNew =ISNULL(max(fldId),0)+1 from [Drd].[tblShomareHesabCodeDaramad] 
INSERT INTO [Drd].[tblShomareHesabCodeDaramad] ([fldId], [fldShomareHesadId], [fldCodeDaramadId],[fldOrganId],[fldUserId], [fldDesc], [fldDate],fldShorooshenaseGhabz,fldFormulMohasebatId, fldFormulKoliId,fldReportFileId,fldFormolsaz,fldSharhCodDaramd,fldstatus)
select @idhesabNew,fldShomareHesadId,@fldID,fldOrganId,@userId,fldDesc,getdate(),
fldShorooshenaseGhabz,fldFormulMohasebatId,fldFormulKoliId,fldReportFileId,fldFormolsaz,fldSharhCodDaramd,fldStatus 
from drd.tblShomareHesabCodeDaramad  where fldid=@idHesabOld

-------------------------------------------------------------------[tblShomareHesab_Formula]

select @idFormul =ISNULL(max(fldId),0) from [Drd].[tblShomareHesab_Formula] 
INSERT INTO [Drd].[tblShomareHesab_Formula] ([fldId], [fldShomareHesab_CodeId], [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId], [fldTarikhEjra], [fldDate], [fldUserId],fldActive)
SELECT row_number()over (order by  fldid)+@idFormul ,@idhesabNew,fldFormolsaz,fldFormulKoliId,fldFormulMohasebatId,fldTarikhEjra,getdate(),@userId,fldActive from drd.tblShomareHesab_Formula
where fldShomareHesab_CodeId=@idHesabOld

----------------------------------------------------------------------[tblParametreSabet]

select @parametrSabetid =ISNULL(max(fldId),0) from [Drd].[tblParametreSabet] 
INSERT INTO [Drd].[tblParametreSabet] ([fldId], [fldShomareHesabCodeDaramadId], [fldNameParametreFa], [fldNameParametreEn], [fldNoe], [fldNoeField], [fldVaziyat], [fldFormulId], [fldComboBaxId], [fldUserId], [fldDesc], [fldDate],fldTypeParametr)
SELECT row_number() over (order by fldid)+@parametrSabetid, @idhesabNew, fldNameParametreFa, fldNameParametreEn, fldNoe, fldNoeField, fldVaziyat,null, fldComboBaxId, fldUserId, fldid, getdate(),fldTypeParametr
from  [Drd].[tblParametreSabet] where fldShomareHesabCodeDaramadId=@idHesabOld

-----------------------------------------------------------------------------

select @Nerkhid =ISNULL(max(fldId),0) from [Drd].[tblParametreSabet_Nerkh] 
INSERT INTO [Drd].[tblParametreSabet_Nerkh] ([fldId], [fldParametreSabetId], [fldTarikhFaalSazi], [fldValue], [fldUserId], [fldDesc], [fldDate])
SELECT row_number() over (order by [tblParametreSabet_Nerkh].fldid)+@Nerkhid, p.fldid, fldTarikhFaalSazi, fldValue, @UserId, [tblParametreSabet_Nerkh].fldDesc, getDate()
 from drd.[tblParametreSabet_Nerkh] inner join [Drd].[tblParametreSabet] 
 on fldParametreSabetId=[tblParametreSabet].fldid
 cross apply (select fldid from drd.tblParametreSabet 
			where fldShomareHesabCodeDaramadId=@idhesabNew and fldDesc=fldParametreSabetId
					)p
 where  fldShomareHesabCodeDaramadId=@idHesabOld



--------------------------------------------------------------------------[tblMahdoodiyatMohasebat_ShomareHesabDaramad]

select @idMahdodiyat =ISNULL(max(fldId),0) from [Drd].[tblMahdoodiyatMohasebat_ShomareHesabDaramad] 
INSERT INTO [Drd].[tblMahdoodiyatMohasebat_ShomareHesabDaramad] ([fldId], [fldMahdodiyatMohasebatId], [fldShomarehesabDarmadId], [fldUserId], [fldDesc], [fldDate])
SELECT row_number() over (order by fldid)+@idMahdodiyat, fldMahdodiyatMohasebatId, @idhesabNew, @UserId, fldDesc, GETDATE()
from  [Drd].[tblMahdoodiyatMohasebat_ShomareHesabDaramad]  where fldShomarehesabDarmadId=@idHesabOld

-------------------------------------------------------------------------[tblTakhfifDetail]

select @idTakhfif =ISNULL(max(fldId),0) from [Drd].[tblTakhfifDetail] 
INSERT INTO [Drd].[tblTakhfifDetail] ([fldId], [fldTakhfifId], [fldShCodeDaramad], [fldUserId], [fldDesc], [fldDate])
SELECT row_number() over (order by fldid)+@idTakhfif, fldTakhfifId, fldShCodeDaramad, @userId, fldDesc, GETDATE()
from [Drd].[tblTakhfifDetail]  where fldShCodeDaramad=@idHesabOld

-------------------------------------------------------------------------[tblRoonevesht]

select @idRoonevesht =ISNULL(max(fldId),0) from [Drd].[tblRoonevesht] 
INSERT INTO [Drd].[tblRoonevesht] ([fldId], [fldShomareHesabCodeDaramadId], [fldTitle], [fldUserId], [fldDate], [fldDesc])
SELECT row_number()over (order by fldid )+@idRoonevesht, fldShomareHesabCodeDaramadId, fldTitle, @UserId,getDate(), fldDesc
from drd.tblRoonevesht where fldShomareHesabCodeDaramadId=@idHesabOld

-------------------------------------------------------------------[tblLetterMinut]

select @idLetter =ISNULL(max(fldId),0) from [Drd].[tblLetterMinut] 
INSERT INTO [Drd].[tblLetterMinut] ([fldId], [fldShomareHesabCodeDaramadId], [fldTitle], [fldDescMinut], [fldUserId], [fldDate], [fldDesc],fldSodoorBadAzVarizNaghdi,fldSodoorBadAzTaghsit,fldTanzimkonande)
SELECT  row_number()over (order by fldid )+@idLetter, fldShomareHesabCodeDaramadId, fldTitle, fldDescMinut, @userId, getdate(), fldDesc,fldSodoorBadAzVarizNaghdi,fldSodoorBadAzTaghsit,fldTanzimkonande
from [Drd].[tblLetterMinut]  where fldShomareHesabCodeDaramadId=@idHesabOld

--end
commit 
end try
begin catch

rollback
	select @errorId =max(fldid)+1 from com.tblError
	insert into com.tblError(fldid,fldUserName,fldMatn,fldTarikh,fldIP,fldUserId,fldDate )
	select @errorId,'',ERROR_MESSAGE(),cast(getdate() as date),'::1',@userId,getdate()

end catch
GO
