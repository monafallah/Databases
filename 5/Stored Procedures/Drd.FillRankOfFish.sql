SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Drd].[FillRankOfFish](
@fishId int=140
)
---در برنامه ازین پروسیجر استفاده نشده است 
as
declare @AvarezId int=0,@MaliatId int=0,@OrganId int,@ElamAvarezId int
declare @Avarez bigint=0,@maliat bigint=0,@Amuzesh bigint=0
SELECT     @ElamAvarezId=fldElamAvarezId,@OrganId=Drd.tblElamAvarez.fldOrganId
FROM         Drd.tblSodoorFish INNER JOIN
                      Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
WHERE     (Drd.tblSodoorFish.fldId = @fishId)

SELECT @AvarezId=isnull(fldAvarezId,0) FROM Drd.tblTanzimateDaramad WHERE fldOrganId=@OrganId

SELECT @MaliatId=isnull(fldMaliyatId,0) FROM Drd.tblTanzimateDaramad WHERE fldOrganId=@OrganId

select @Avarez=isnull(SUM(fldTakhfifAvarezValue),SUM(fldAvarezValue)),@maliat=isnull(SUM(fldTakhfifMaliyatValue),sum(fldMaliyatValue)) 
,@Amuzesh=isnull(SUM(fldTakhfifAmuzeshParvareshValue),SUM(fldAmuzeshParvareshValue))
from drd.tblSodoorFish_Detail inner join
drd.tblCodhayeDaramadiElamAvarez on drd.tblSodoorFish_Detail.fldCodeElamAvarezId=drd.tblCodhayeDaramadiElamAvarez.fldID
where fldFishId=@fishId

declare @temp table(fldId int identity,fldElamAvarezId int,fldShomareHesabCodeDaramadId int,fldMablagh bigint,fldRank tinyint)

if(@Avarez+@maliat+@Amuzesh<>0)
begin
	insert into @temp 
	select @ElamAvarezId,@MaliatId,@maliat,0
	
	insert into @temp 
	select @ElamAvarezId,@AvarezId,@Avarez,0

	insert into @temp 
	select @ElamAvarezId,0,@Amuzesh,0

end

insert into @temp
select @ElamAvarezId,fldCodeElamAvarezId,fldSumAsli,1 from drd.tblSodoorFish_Detail inner join
drd.tblCodhayeDaramadiElamAvarez on drd.tblSodoorFish_Detail.fldCodeElamAvarezId=drd.tblCodhayeDaramadiElamAvarez.fldID
where fldFishId=@fishId

select * from @temp
declare @SumMablaghTemp bigint,@SumMablaghAsli bigint

select @SumMablaghAsli=fldMablaghAvarezGerdShode from drd.tblSodoorFish where fldId=@fishId
select @SumMablaghTemp=SUM(fldMablagh) from @temp

select @SumMablaghAsli as gerd_fish,@SumMablaghTemp as temp

if(@SumMablaghAsli<>@SumMablaghTemp)
begin
	declare @maxid int
	select @maxid=MAX(fldid) from @temp
	declare @diff int
	set @diff=@SumMablaghTemp-@SumMablaghAsli
	
	update @temp set fldMablagh=fldMablagh-@diff,fldRank=2 where fldId=@maxid
end
select * from @temp
GO
