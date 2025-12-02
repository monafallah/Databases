SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [ACC].[fn_GetPCodeFromCodeDarmad](@daramadcod varchar(20),  @sal smallint,@CodingHeader int)
--declare @sal smallint=1404,@CodingHeader int
returns table
as
return
(with  daramad 
as 
(select fldDaramadId,fldDaramadCode,fldLevel,c.fldid id from drd.tblCodhayeDaramd c
inner join drd.tblShomareHedabCodeDaramd_Detail s on s.fldCodeDaramdId=c.fldid
where @sal between fldStartYear and fldEndYear and  fldDaramadCode=@daramadcod
union all
select d.fldDaramadId,d.fldDaramadCode ,d.fldLevel,d.fldid id from drd.tblCodhayeDaramd d
inner join drd.tblShomareHedabCodeDaramd_Detail s on s.fldCodeDaramdId=d.fldid
inner join daramad c on  c.flddaramadId.GetAncestor(1)=d.fldDaramadId
where @sal between fldStartYear and fldEndYear  and d.fldLevel<>0
)
select top(1) cd.* from daramad cd
 inner join
		acc.tblCoding_Details as d on d.fldDaramadCode=cd.fldDaramadCode
		where d.fldHeaderCodId=@CodingHeader
order by cd.fldDaramadCode desc
)
GO
