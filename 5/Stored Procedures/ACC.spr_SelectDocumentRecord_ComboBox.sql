SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_SelectDocumentRecord_ComboBox](@fldYear SMALLINT,@organId  INT,@CodingDetailId int)
AS 
	SELECT   tblCase.fldSourceId fldId,fldCaseTypeId,fldName+'_'+fldFamily+'('+fldFatherName+')' as fldName
			FROM   [ACC].[tblDocumentRecord_Details] Detail inner join 
			acc.tblDocumentRecord_Header header ON header.fldid=Detail.fldDocument_HedearId INNER JOIN
            acc.tblFiscalYear fisc ON fisc.fldid=header.fldFiscalYearId INNER JOIN 
			[ACC].tblCase	on tblCase.fldId=Detail.fldCaseId inner join
			Com.tblEmployee on tblEmployee.fldId=fldSourceId inner join
			com.tblEmployee_Detail on tblEmployee_Detail.fldEmployeeId=tblEmployee.fldId inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId  
			WHERE fisc.fldYear=@fldYear AND header.fldOrganId=@organId AND Detail.fldCodingId=@CodingDetailId and tblCase.fldCaseTypeId=1 
			
			union ALL
            
			SELECT tblCase.fldSourceId fldId,fldCaseTypeId,fldName as fldName
			FROM   [ACC].[tblDocumentRecord_Details] Detail inner join 
			acc.tblDocumentRecord_Header header ON header.fldid=Detail.fldDocument_HedearId INNER JOIN
            acc.tblFiscalYear fisc ON fisc.fldid=header.fldFiscalYearId INNER JOIN 
			[ACC].tblCase	on tblCase.fldId=Detail.fldCaseId inner join
			Com.tblAshkhaseHoghoghi on tblAshkhaseHoghoghi.fldId=fldSourceId inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId
			WHERE   fisc.fldYear=@fldYear AND header.fldOrganId=@organId AND Detail.fldCodingId=@CodingDetailId and tblCase.fldCaseTypeId=2 
			union ALL
            
			SELECT tblCase.fldSourceId fldId,fldCaseTypeId,fldSubject as fldName
			FROM   [ACC].[tblDocumentRecord_Details] Detail inner join 
			acc.tblDocumentRecord_Header header ON header.fldid=Detail.fldDocument_HedearId INNER JOIN
            acc.tblFiscalYear fisc ON fisc.fldid=header.fldFiscalYearId INNER JOIN 
			[ACC].tblCase	on tblCase.fldId=Detail.fldCaseId inner join
			Cntr.tblContracts on tblContracts.fldId=fldSourceId inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId
			WHERE  fisc.fldYear=@fldYear AND header.fldOrganId=@organId AND Detail.fldCodingId=@CodingDetailId and tblCase.fldCaseTypeId in (13,14) 
			union ALL
            
			SELECT  tblCase.fldSourceId fldId,fldCaseTypeId,fldShomareSanad+'('+fldBabat+')' as fldName
			FROM   [ACC].[tblDocumentRecord_Details] Detail inner join 
			acc.tblDocumentRecord_Header header ON header.fldid=Detail.fldDocument_HedearId INNER JOIN
            acc.tblFiscalYear fisc ON fisc.fldid=header.fldFiscalYearId INNER JOIN 
			[ACC].tblCase	on tblCase.fldId=Detail.fldCaseId inner join
			drd.tblCheck on tblCheck.fldId=fldSourceId  inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId
			WHERE  fisc.fldYear=@fldYear AND header.fldOrganId=@organId AND Detail.fldCodingId=@CodingDetailId and tblCase.fldCaseTypeId=3 
			 and fldReplyTaghsitId is null

			union ALL
            
			SELECT tblCase.fldSourceId fldId,fldCaseTypeId,fldCodeSerialCheck+'('+fldBabat+')' as fldName
			FROM   [ACC].[tblDocumentRecord_Details] Detail inner join 
			acc.tblDocumentRecord_Header header ON header.fldid=Detail.fldDocument_HedearId INNER JOIN
            acc.tblFiscalYear fisc ON fisc.fldid=header.fldFiscalYearId INNER JOIN 
			[ACC].tblCase	on tblCase.fldId=Detail.fldCaseId inner join
			chk.tblSodorCheck on tblSodorCheck.fldId=fldSourceId  inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId
			WHERE   fisc.fldYear=@fldYear AND header.fldOrganId=@organId AND Detail.fldCodingId=@CodingDetailId 

			union all
			SELECT   tblCase.fldSourceId fldId,fldCaseTypeId,cast(tblSodoorFish.fldid as varchar(30))+'_'+Nameshakhs.fldName+'('+Nameshakhs.fldCodemeli+')' as fldName
			FROM   [ACC].[tblDocumentRecord_Details] Detail inner join 
			acc.tblDocumentRecord_Header header ON header.fldid=Detail.fldDocument_HedearId INNER JOIN
            acc.tblFiscalYear fisc ON fisc.fldid=header.fldFiscalYearId INNER JOIN 
			[ACC].tblCase	on tblCase.fldId=Detail.fldCaseId inner join
			drd.tblSodoorFish on tblSodoorFish.fldId=fldSourceId  inner join 
			drd.tblElamAvarez e on e.fldid=fldElamAvarezId inner join
			acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId
			cross apply (
					select fldName collate SQL_Latin1_General_CP1_CI_AS+' '+fldFamily collate SQL_Latin1_General_CP1_CI_AS as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					where a.fldid=fldAshakhasID
					union all
					select fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
			WHERE   fisc.fldYear=@fldYear AND header.fldOrganId=@organId AND Detail.fldCodingId=@CodingDetailId and tblCase.fldCaseTypeId=6 
			 and not exists (select * from drd.tblEbtal where fldFishId=tblSodoorFish.fldid)

			union all
			SELECT  tblCase.fldSourceId fldId,fldCaseTypeId,p.fldTitle as fldName
			FROM   [ACC].[tblDocumentRecord_Details] Detail inner join 
			acc.tblDocumentRecord_Header header ON header.fldid=Detail.fldDocument_HedearId INNER JOIN
            acc.tblFiscalYear fisc ON fisc.fldid=header.fldFiscalYearId INNER JOIN 
			[ACC].tblCase	on tblCase.fldId=Detail.fldCaseId inner join
			bud.tblCodingBudje_Details p on p.fldCodeingBudjeId=fldSourceId  inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId
			WHERE   fisc.fldYear=@fldYear AND header.fldOrganId=@organId AND Detail.fldCodingId=@CodingDetailId  and p.fldLevelId=4 and p.fldTarh_KhedmatTypeId=1

			union all
			SELECT tblCase.fldSourceId fldId,fldCaseTypeId,fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')' as fldName
			FROM   [ACC].[tblDocumentRecord_Details] Detail inner join 
			acc.tblDocumentRecord_Header header ON header.fldid=Detail.fldDocument_HedearId INNER JOIN
            acc.tblFiscalYear fisc ON fisc.fldid=header.fldFiscalYearId INNER JOIN 
			[ACC].tblCase	on tblCase.fldId=Detail.fldCaseId inner JOIN
			 com.tblShomareHesabeOmoomi as s on s.fldId=fldSourceId
			inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
			inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
			inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
			inner join com.tblSHobe sh on sh.fldid=fldShobeId
			inner join com.tblBank b on b.fldid=sh.fldBankId 
			inner join acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId
			WHERE   fisc.fldYear=@fldYear AND header.fldOrganId=@organId AND Detail.fldCodingId=@CodingDetailId and tblCase.fldCaseTypeId=5 




GO
