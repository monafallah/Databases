SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [BUD].[spr_GetDataSalGhabl](@year int, @organId int)
as
begin tran
--declare @year int=1403,@organId int=1, @MotammamId int
declare @SalMali1sal int,@salmali2sal int
select @SalMali1sal=fldid from acc.tblFiscalYear where fldOrganId=@organId and fldYear=@year-1
select @salmali2sal=fldid from acc.tblFiscalYear where fldOrganId=@organId and fldYear=@year-2
----------------------------------------------------------------------------
declare @AzT9Mah varchar(10)='',@TaT9Mah varchar(10)=''
select @AzT9Mah=min(fldTarikh) from com.tblDateDim where fldSal=@year-1 and fldMah=4
select @TaT9Mah=max(fldTarikh) from com.tblDateDim where fldSal=@year-1 and fldMah=12 /*عملکرد 9 ماهه آخر سال قبل */
------------------------------------------------------------------------
declare @AzT2Sal varchar(10),@Tat2Sal varchar(10)
select @AzT2Sal=min(fldTarikh) from com.tblDateDim where fldSal=@year-2 and fldMah=1
select @Tat2Sal=max(fldTarikh) from com.tblDateDim where fldSal=@year-2 and fldMah=12/*عملکرد دو سال قبل*/
-------------------------------------------------------------------------
declare @AzT3Mah varchar(10)='',@TaT3mah varchar(10)=''
select @AzT3Mah=min(fldTarikh) from com.tblDateDim where fldSal=@year-2 and fldMah=10
select @TaT3mah=max(fldTarikh) from com.tblDateDim where fldSal=@year-2 and fldMah=12/*عملکرد سه ماهه آخر دو سال قبل*/
------------------------------------------------------------------------
declare @AzT1Sal varchar(10),@TaT1Sal varchar(10)=''
select @AzT1Sal=min(fldTarikh) from com.tblDateDim where fldSal=@year-1 and fldMah=1
select @TaT1Sal=max(fldTarikh) from com.tblDateDim where fldSal=@year-1 and fldMah=12/*مصوب سال قبل*/

----------------------------------------------------------------------
--select @SalMali1sal,@salmali2sal,@AzT9Mah,@TaT9Mah,@AzT2Sal,@Tat2Sal,@AzT3Mah,@TaT3mah,@AzT1Sal,@TaT1Sal

create table #SalGhabl
(Hid HIERARCHYID,fldCode varchar(20),fldLevelId int,fldTitle nvarchar(300),fldId int,bed_g bigint,bes_g bigint,bed_m bigint,bed bigint,bes bigint,bes_m bigint,mbed bigint,mbes bigint,
fldCaseName nvarchar(500), fldflag tinyint,fldCaseTypeId tinyint,aztarikh varchar(10),tatarikh varchar(10))

insert into #SalGhabl
exec [BUD].[spr_Taraz_Main_Pishbini] @AzT9Mah,@TaT9Mah,@SalMali1sal,@organId,0,6,0,0,0,1

insert into #SalGhabl
exec [BUD].[spr_Taraz_Main_Pishbini] @AzT2Sal,@Tat2Sal,@SalMali2sal,@organId,0,6,0,0,0,1

insert into #SalGhabl
exec [BUD].[spr_Taraz_Main_Pishbini] @AzT3Mah,@TaT3mah,@SalMali2sal,@organId,0,6,0,0,0,1

insert into #SalGhabl
exec [BUD].[spr_Taraz_Main_Pishbini] @AzT1Sal,@TaT1Sal,@SalMali1sal,@organId,0,6,0,0,0,1

select fldCode,fldTitle,mbed,mbes,fldid,case when aztarikh=@AzT9Mah and tatarikh=@TaT9Mah then 3 
			when aztarikh=@AzT2Sal and tatarikh=@Tat2Sal then 4
			when aztarikh=@AzT3Mah and tatarikh=@TaT3mah then 5
			when aztarikh=@AzT1Sal and tatarikh=@TaT1Sal then 2 end fldBudgetTypeId from #SalGhabl

--drop table #SalGhabl

commit
GO
