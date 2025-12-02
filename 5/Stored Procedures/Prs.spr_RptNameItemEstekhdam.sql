SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_RptNameItemEstekhdam](@TypeEstekhdamId INT)
as
SELECT ISNULL([h-paye],'')[h-paye],ISNULL([sanavat],'')[sanavat],ISNULL([paye],'')[paye],ISNULL([sanavat-basiji],'')[sanavat-basiji]
,ISNULL([sanavat-isar],'')[sanavat-isar],ISNULL([foghshoghl],'')[foghshoghl],ISNULL([takhasosi],'')[takhasosi],ISNULL([made26],'')[made26],
ISNULL([modiryati],'')[modiryati],ISNULL([barjastegi],'')[barjastegi],ISNULL([tatbigh],'')[tatbigh],ISNULL([fogh-isar],'')[fogh-isar],
ISNULL([abohava],'')[abohava],ISNULL([tashilat],'')[tashilat],ISNULL([sakhtikar],'')[sakhtikar],ISNULL([tadil],'')[tadil],
ISNULL([riali],'')[riali],ISNULL([jazb9],'')[jazb9],ISNULL([jazb],'')[jazb],ISNULL([makhsos],'')[makhsos],ISNULL([vije],'')[vije],
ISNULL([olad],'')[olad],ISNULL([ayelemandi],'')[ayelemandi],ISNULL([kharobar],'')[kharobar],ISNULL([maskan],'')[maskan],ISNULL([nobatkari],'')[nobatkari],ISNULL([bon],'')[bon]
,ISNULL([jazb-tabsare],'')[jazb-tabsare],ISNULL([talash],'')[talash],ISNULL([jebhe],'')[jebhe],ISNULL([janbazi],'')[janbazi],ISNULL([sayer],'')[sayer] 
,ISNULL([ghazai],'')[ghazai],ISNULL([ashoora],'')[ashoora],ISNULL([zaribtadil],'')[zaribtadil],ISNULL([jazbTakhasosi],'')jazbTakhasosi,
ISNULL([jazbtadil],'')jazbtadil,ISNULL([hadaghaltadil],'')hadaghaltadil,ISNULL([shift],'')shift
,ISNULL([band_y],0)[band_y] ,ISNULL([joz1],0)[joz1],ISNULL([band6],0)[band6]
FROM
(SELECT    Com.tblItemsHoghughi.fldNameEN AS [fldNameEN]  , ISNULL(Com.tblItems_Estekhdam.fldTitle,'') fldTitle
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId
                      WHERE fldTypeEstekhdamId=@TypeEstekhdamId)t1
  

 PIVOT (MAX(fldTitle)
FOR fldNameEN IN([h-paye],[sanavat],[paye],[sanavat-basiji],[sanavat-isar],[foghshoghl],[takhasosi],[made26],[modiryati],[barjastegi],[tatbigh],[fogh-isar],
[abohava],[tashilat],[sakhtikar],[tadil],[riali],[jazb9],[jazb],[makhsos],[vije],[olad],[ayelemandi],[kharobar],[maskan],[nobatkari],[bon],[jazb-tabsare],[talash],[jebhe]
,[janbazi],[sayer],[ghazai],[ashoora],[zaribtadil],[jazbTakhasosi],[jazbtadil],[hadaghaltadil],[shift]
,[band_y],[joz1],[band6]))p
GO
