SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Weigh].[spr_SelectIsEbtalFishDaramd](@idvazn int,@fldOrganId  int,@fldModuleId int)
as
declare @IsEbtal bit=0

if not  exists (select em.fldElamAvarezId from Weigh.tblElamAvarez_ModuleOrgan em
					inner join com.tblModule_Organ m on m.fldid=em.fldModulOrganId
				where id=@idvazn and fldOrganId=@fldOrganId and fldModuleId=@fldModuleId)
set @IsEbtal=1
else 
begin


select @IsEbtal=cast(1 as bit) from (select 
				CASE WHEN (fldid IN (SELECT TOP(1)  
									CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=e.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN 1
										 WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=e.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN 2
									     WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=e.fldId AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN 3
									     WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=e.fldId AND fldRequestType=1) THEN 4 
				ELSE 0 end AS fldStatusTaghsit,
				 CASE WHEN (fldid IN (SELECT TOP(1) 
									 CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=e.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN 1
										  WHEN (fldid IN (SELECT TOP(1)  CASE WHEN fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId ) THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=e.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc)) THEN 2
										  WHEN fldid in (SELECT TOP(1)  CASE WHEN fldid IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)  THEN fldElamAvarezId ELSE 0 end  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=e.fldId AND fldRequestType=2 ORDER BY tblRequestTaghsit_Takhfif.fldId desc) THEN 3
										  WHEN EXISTS (SELECT * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=e.fldId AND fldRequestType=2) THEN 4 
			ELSE 0 END AS fldStatusTakhfif
			 ,ISNULL(pardakht,0) as fldPardakhtshode 
from drd.tblElamAvarez e
cross apply (select em.fldElamAvarezId from Weigh.tblElamAvarez_ModuleOrgan em
					inner join com.tblModule_Organ m on m.fldid=em.fldModulOrganId
				where id=@idvazn and fldOrganId=@fldOrganId and fldModuleId=@fldModuleId
			)em

outer apply (select 1 pardakht,fldElamAvarezId from drd.tblSodoorFish s inner join drd.tblPardakhtFish p
				on s.fldid=p.fldFishId where fldElamAvarezId=e.fldid
			)fish
where e.fldid=em.fldElamAvarezId
)t
where fldPardakhtshode=0 and fldStatusTaghsit not in (1,4) and fldStatusTakhfif <>4
end 
select @IsEbtal as fldEbtal
GO
