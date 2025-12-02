SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHokm_ItemSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT     TOP (@h) tblHokm_Item.fldId, tblHokm_Item.fldPersonalHokmId, tblHokm_Item.fldItems_EstekhdamId, tblHokm_Item.fldMablagh, Com.tblItems_Estekhdam.fldItemsHoghughiId,
                      tblHokm_Item.fldZarib, tblHokm_Item.fldUserId, tblHokm_Item.fldDate, tblHokm_Item.fldDesc, Com.tblItems_Estekhdam.fldTitle AS fldNameItem_Estekhdam
FROM         tblHokm_Item INNER JOIN
                      Com.tblItems_Estekhdam ON tblHokm_Item.fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId
	WHERE  tblHokm_Item.fldId = @Value
	
		if (@fieldname=N'fldDesc')
SELECT     TOP (@h) tblHokm_Item.fldId, tblHokm_Item.fldPersonalHokmId, tblHokm_Item.fldItems_EstekhdamId, tblHokm_Item.fldMablagh,  Com.tblItems_Estekhdam.fldItemsHoghughiId,
                      tblHokm_Item.fldZarib, tblHokm_Item.fldUserId, tblHokm_Item.fldDate, tblHokm_Item.fldDesc, Com.tblItems_Estekhdam.fldTitle AS fldNameItem_Estekhdam
FROM         tblHokm_Item INNER JOIN
                      Com.tblItems_Estekhdam ON tblHokm_Item.fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId
	WHERE  tblHokm_Item.fldDesc like @Value

		if (@fieldname=N'fldPersonalHokmId')
		begin
		declare @temp table(fldId int, fldPersonalHokmId int, fldItems_EstekhdamId int, fldMablagh int,  fldItemsHoghughiId int,
                      fldZarib decimal(6, 3), fldUserId int, fldDate datetime, fldDesc nvarchar(max),fldNameItem_Estekhdam nvarchar(max)
)
;with cte
as
(
SELECT     TOP (@h) tblHokm_Item.fldId, tblHokm_Item.fldPersonalHokmId, tblHokm_Item.fldItems_EstekhdamId, tblHokm_Item.fldMablagh,  Com.tblItems_Estekhdam.fldItemsHoghughiId,
                       case when fldItemsHoghughiId=19 and p.fldAnvaeEstekhdamId in (1,2) then p.fldGroup+10 else  tblHokm_Item.fldZarib end fldZarib, tblHokm_Item.fldUserId, tblHokm_Item.fldDate, tblHokm_Item.fldDesc, Com.tblItems_Estekhdam.fldTitle AS fldNameItem_Estekhdam
FROM         prs.tblHokm_Item INNER JOIN
                      Com.tblItems_Estekhdam ON tblHokm_Item.fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId inner join
					  prs.tblPersonalHokm as p on p.fldId=fldPersonalHokmId
	WHERE  fldPersonalHokmId = @Value 
	)
insert into @temp
select * from cte
update @temp set fldZarib=0,fldMablagh=fldMablagh+isnull((select sum(fldmablagh) from @temp where fldItemsHoghughiId in(7,8,9)),0) where fldItemsHoghughiId=6
delete from @temp where fldItemsHoghughiId in(7,8,9)
update @temp set fldZarib=fldZarib+isnull((select sum(fldZarib) from @temp where fldItemsHoghughiId in(47,48,60)),0),fldMablagh=fldMablagh+isnull((select sum(fldmablagh) from @temp where fldItemsHoghughiId in(47,48,60)),0) where fldItemsHoghughiId=19
delete from @temp where fldItemsHoghughiId in(47,48,60)
update @temp set fldZarib=fldZarib+isnull((select sum(fldZarib) from @temp where fldItemsHoghughiId in(49,50,61)),0),fldMablagh=fldMablagh+isnull((select sum(fldmablagh) from @temp where fldItemsHoghughiId in(49,50,61)),0) where fldItemsHoghughiId=21
delete from @temp where fldItemsHoghughiId in(49,50,61)
update @temp set fldZarib=fldZarib+isnull((select sum(fldZarib) from @temp where fldItemsHoghughiId in(51,52)),0),fldMablagh=fldMablagh+isnull((select sum(fldmablagh) from @temp where fldItemsHoghughiId in(51,52)),0) where fldItemsHoghughiId=20
delete from @temp where fldItemsHoghughiId in(51,52)
update @temp set fldZarib=fldZarib+isnull((select sum(fldZarib) from @temp where fldItemsHoghughiId in(62)),0),fldMablagh=fldMablagh+isnull((select sum(fldmablagh) from @temp where fldItemsHoghughiId in(62)),0) where fldItemsHoghughiId=54
delete from @temp where fldItemsHoghughiId in(62)
update @temp set fldZarib=0,fldNameItem_Estekhdam=N'تجمیع تفاوت بند(ی) و جزء1',fldMablagh=fldMablagh+isnull((select sum(fldmablagh) from @temp where fldItemsHoghughiId =45),0) where fldItemsHoghughiId=44
delete from @temp where fldItemsHoghughiId =45
select * from @temp where fldItems_EstekhdamId not in (85,86,150,151,152,153,154,9,85,86,87)
	end
	if (@fieldname=N'fldPersonalHokmIdGroupo')
		begin

;with cte
as
(
SELECT      tblHokm_Item.fldId, tblHokm_Item.fldPersonalHokmId, tblHokm_Item.fldItems_EstekhdamId
, case when fldItemsHoghughiId=27 and fldMablagh=0 then (select fldHaghBon from prs.tblMoteghayerhaAhkam where fldYear=@h and fldType=0) else tblHokm_Item.fldMablagh end fldMablagh
,  Com.tblItems_Estekhdam.fldItemsHoghughiId,
                       case when fldItemsHoghughiId=19 and p.fldAnvaeEstekhdamId in (1,2) then p.fldGroup+10 else  tblHokm_Item.fldZarib end fldZarib, tblHokm_Item.fldUserId, tblHokm_Item.fldDate, tblHokm_Item.fldDesc, Com.tblItems_Estekhdam.fldTitle AS fldNameItem_Estekhdam
FROM         prs.tblHokm_Item INNER JOIN
                      Com.tblItems_Estekhdam ON tblHokm_Item.fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId inner join
					  prs.tblPersonalHokm as p on p.fldId=fldPersonalHokmId
	WHERE  fldPersonalHokmId = @Value 
	union
	SELECT     TOP (1)0, tblHokm_Item.fldPersonalHokmId,194, (select fldHagheAeleMandi from prs.tblMoteghayerhaAhkam where fldYear=@h and fldType=0),  23,
                    0, tblHokm_Item.fldUserId, tblHokm_Item.fldDate, tblHokm_Item.fldDesc, N'حق تأهل' AS fldNameItem_Estekhdam
FROM         prs.tblHokm_Item INNER JOIN
                      Com.tblItems_Estekhdam ON tblHokm_Item.fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId
					  WHERE  fldPersonalHokmId = @Value and not exists (select *FROM         prs.tblHokm_Item INNER JOIN
                      Com.tblItems_Estekhdam ON tblHokm_Item.fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId
	WHERE  fldPersonalHokmId = @Value and fldItemsHoghughiId=23)
	union
	SELECT     TOP (1)0, tblHokm_Item.fldPersonalHokmId,9, (select fldHaghBon from prs.tblMoteghayerhaAhkam where fldYear=@h and fldType=0),  27,
                    0, tblHokm_Item.fldUserId, tblHokm_Item.fldDate, tblHokm_Item.fldDesc, N'بن ماهیانه' AS fldNameItem_Estekhdam
FROM         prs.tblHokm_Item INNER JOIN
                      Com.tblItems_Estekhdam ON tblHokm_Item.fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId
					  WHERE  fldPersonalHokmId = @Value and not exists (select *FROM         prs.tblHokm_Item INNER JOIN
                      Com.tblItems_Estekhdam ON tblHokm_Item.fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId
	WHERE  fldPersonalHokmId = @Value and fldItemsHoghughiId=27)

	)
insert into @temp
select * from cte
update @temp set fldZarib=0,fldMablagh=fldMablagh+isnull((select sum(fldmablagh) from @temp where fldItemsHoghughiId in(7,8,9)),0) where fldItemsHoghughiId=6
delete from @temp where fldItemsHoghughiId in(7,8,9)
update @temp set fldZarib=fldZarib+isnull((select sum(fldZarib) from @temp where fldItemsHoghughiId in(47,48,60)),0),fldMablagh=fldMablagh+isnull((select sum(fldmablagh) from @temp where fldItemsHoghughiId in(47,48,60)),0) where fldItemsHoghughiId=19
delete from @temp where fldItemsHoghughiId in(47,48,60)
update @temp set fldZarib=fldZarib+isnull((select sum(fldZarib) from @temp where fldItemsHoghughiId in(49,50,61)),0),fldMablagh=fldMablagh+isnull((select sum(fldmablagh) from @temp where fldItemsHoghughiId in(49,50,61)),0) where fldItemsHoghughiId=21
delete from @temp where fldItemsHoghughiId in(49,50,61)
update @temp set fldZarib=fldZarib+isnull((select sum(fldZarib) from @temp where fldItemsHoghughiId in(51,52)),0),fldMablagh=fldMablagh+isnull((select sum(fldmablagh) from @temp where fldItemsHoghughiId in(51,52)),0) where fldItemsHoghughiId=20
delete from @temp where fldItemsHoghughiId in(51,52)
update @temp set fldZarib=fldZarib+isnull((select sum(fldZarib) from @temp where fldItemsHoghughiId in(62)),0),fldMablagh=fldMablagh+isnull((select sum(fldmablagh) from @temp where fldItemsHoghughiId in(62)),0) where fldItemsHoghughiId=54
delete from @temp where fldItemsHoghughiId in(62)
update @temp set fldZarib=0,fldNameItem_Estekhdam=N'تجمیع تفاوت بند(ی) و جزء1',fldMablagh=fldMablagh+isnull((select sum(fldmablagh) from @temp where fldItemsHoghughiId =45),0) where fldItemsHoghughiId=44
delete from @temp where fldItemsHoghughiId =45
select * from @temp --where fldItems_EstekhdamId not in (85,86,150,151,152,153,154,85,86,87)
	end
	IF (@fieldname=N'fldItems_EstekhdamId')
SELECT     TOP (@h) tblHokm_Item.fldId, tblHokm_Item.fldPersonalHokmId, tblHokm_Item.fldItems_EstekhdamId, tblHokm_Item.fldMablagh,  Com.tblItems_Estekhdam.fldItemsHoghughiId,
                      tblHokm_Item.fldZarib, tblHokm_Item.fldUserId, tblHokm_Item.fldDate, tblHokm_Item.fldDesc, Com.tblItems_Estekhdam.fldTitle AS fldNameItem_Estekhdam
FROM         tblHokm_Item INNER JOIN
                      Com.tblItems_Estekhdam ON tblHokm_Item.fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId
	WHERE  fldItems_EstekhdamId = @Value
	
		IF (@fieldname=N'fldPersonalHokmId_Details')
SELECT     TOP (@h) tblHokm_Item.fldId, tblHokm_Item.fldPersonalHokmId, tblHokm_Item.fldItems_EstekhdamId, tblHokm_Item.fldMablagh,  Com.tblItems_Estekhdam.fldItemsHoghughiId,
                      tblHokm_Item.fldZarib, tblHokm_Item.fldUserId, tblHokm_Item.fldDate, tblHokm_Item.fldDesc
					  , Com.tblItems_Estekhdam.fldTitle+
					  case when tblHokm_Item.fldZarib=0 then N'' else '('+cast((cast(tblHokm_Item.fldZarib as int)) as varchar(10))+' %)' end AS fldNameItem_Estekhdam
FROM         tblHokm_Item INNER JOIN
                      Com.tblItems_Estekhdam ON tblHokm_Item.fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId
	WHERE  fldPersonalHokmId = @Value

	if (@fieldname=N'fldMablagh')
SELECT     TOP (@h) tblHokm_Item.fldId, tblHokm_Item.fldPersonalHokmId, tblHokm_Item.fldItems_EstekhdamId, tblHokm_Item.fldMablagh,  Com.tblItems_Estekhdam.fldItemsHoghughiId,
                      tblHokm_Item.fldZarib, tblHokm_Item.fldUserId, tblHokm_Item.fldDate, tblHokm_Item.fldDesc, Com.tblItems_Estekhdam.fldTitle AS fldNameItem_Estekhdam
FROM         tblHokm_Item INNER JOIN
                      Com.tblItems_Estekhdam ON tblHokm_Item.fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId
	WHERE  fldMablagh LIKE @Value
	
	if (@fieldname=N'fldZarib')
SELECT     TOP (@h) tblHokm_Item.fldId, tblHokm_Item.fldPersonalHokmId, tblHokm_Item.fldItems_EstekhdamId, tblHokm_Item.fldMablagh,  Com.tblItems_Estekhdam.fldItemsHoghughiId,
                      tblHokm_Item.fldZarib, tblHokm_Item.fldUserId, tblHokm_Item.fldDate, tblHokm_Item.fldDesc, Com.tblItems_Estekhdam.fldTitle AS fldNameItem_Estekhdam
FROM         tblHokm_Item INNER JOIN
                      Com.tblItems_Estekhdam ON tblHokm_Item.fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId
	WHERE  fldZarib LIKE @Value
	
	if (@fieldname=N'fldNameItem_Estekhdam')
SELECT     TOP (@h)* FROM (SELECT tblHokm_Item.fldId, tblHokm_Item.fldPersonalHokmId, tblHokm_Item.fldItems_EstekhdamId, tblHokm_Item.fldMablagh,  Com.tblItems_Estekhdam.fldItemsHoghughiId,
                      tblHokm_Item.fldZarib, tblHokm_Item.fldUserId, tblHokm_Item.fldDate, tblHokm_Item.fldDesc, Com.tblItems_Estekhdam.fldTitle AS fldNameItem_Estekhdam
FROM         tblHokm_Item INNER JOIN
                      Com.tblItems_Estekhdam ON tblHokm_Item.fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId)t
	WHERE  fldNameItem_Estekhdam LIKE @Value


	if (@fieldname=N'')
SELECT     TOP (@h) tblHokm_Item.fldId, tblHokm_Item.fldPersonalHokmId, tblHokm_Item.fldItems_EstekhdamId, tblHokm_Item.fldMablagh,  Com.tblItems_Estekhdam.fldItemsHoghughiId,
                      tblHokm_Item.fldZarib, tblHokm_Item.fldUserId, tblHokm_Item.fldDate, tblHokm_Item.fldDesc, Com.tblItems_Estekhdam.fldTitle AS fldNameItem_Estekhdam
FROM         tblHokm_Item INNER JOIN
                      Com.tblItems_Estekhdam ON tblHokm_Item.fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId

	COMMIT
GO
