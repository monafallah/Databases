SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Weigh].[spr_SelectArze_Kala]
@fldBaskoolId int,
@fldOrganId int
as
/*begin tran
	SELECT       k.fldId fldKalaId,codedaramad.fldId,  isnull(codedaramad.fldCodeDaramadId,0) fldCodeDaramadId, isnull(fldParametrSabetDaramadId,0) fldParametrSabetDaramadId, 
	isnull( codedaramad.fldSharheCodeDaramad,'')fldSharheCodeDaramad, isnull(fldNameParametreFa,'')fldNameParametreFa, k.fldName AS fldKalaName
,Baskool.fldName fldNameWeighbridge,isnull(fldShomareHesabCodeDaramadId,0)fldShomareHesabCodeDaramadId
from com.tblKala k
						
	outer apply (select a.fldId,fldCodeDaramadId ,fldSharheCodeDaramad,p.fldNameParametreFa,fldParametrSabetDaramadId ,c.fldShomareHesabCodeDaramadId
		
			from Weigh.tblArze a
			
				inner join drd.tblCodhayeDaramadiElamAvarez c on fldCodeDaramadId =c.fldid
				inner join drd.tblParametreSabet p on p.fldid=fldParametrSabetDaramadId 
				where fldBaskoolId=@fldBaskoolId and a.fldOrganId=@fldOrganId and a.fldKalaId=k.fldid )codedaramad
				cross apply (select fldName from Weigh.tblWeighbridge where fldid=@fldBaskoolId)Baskool*/

		
						
						
							 

commit tran
GO
