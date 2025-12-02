SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_pay_rptSanad1](@year INT,@month INT, @nobat INT,@tafkik bit,@organId int,@CalcType TINYINT=1)
as
--DECLARE @tafkik BIT=1
DECLARE @temp TABLE(fldid INT IDENTITY,fldbed bigINT,fldbes BIGINT,flddesc NVARCHAR(200),markaz NVARCHAR(200))
declare @YearP SMALLINT=@year,@MonthP TINYINT=@month-1

if(@month=1)
begin
	set @YearP=@year-1
	set @MonthP=12
end
DECLARE @M TABLE(fldId int,payId int)

INSERT INTO @M
      SELECT m.fldId,m.fldPersonalId FROM Pay.tblMohasebat as m
	  inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
        WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@Nobat and fldOrganId=@OrganId and fldCalcType=@CalcType
INSERT INTO @temp
SELECT  cast(SUM(Expr1)as bigint) , 0 AS Expr2, N'حقوق' AS Expr3, fldTitle FROM
(SELECT    SUM(cast(Pay.tblMohasebat_Items.fldMablagh as bigint))AS Expr1,  Pay.tblCostCenter.fldTitle
FROM            Pay.tblMohasebat_Items INNER JOIN
                         Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                         Pay.tblMohasebat ON Pay.tblMohasebat_Items.fldMohasebatId = Pay.tblMohasebat.fldId AND Pay.tblMohasebat_Items.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                         Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND 
                         Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month) AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId AND (Com.tblItemsHoghughi.fldId IN (1, 2, 3, 4, 5, 30, 31, 38))
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle,Pay.tblMohasebat.fldId
union
SELECT     SUM(cast(Pay.tblMoavaghat_Items.fldMablagh as bigint)) AS Expr1,tblCostCenter.fldTitle
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMoavaghat.fldMohasebatId = Pay.tblMohasebat.fldId AND Pay.tblMoavaghat.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND 
                      Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE     (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId AND (Com.tblItems_Estekhdam.fldItemsHoghughiId IN (1, 2, 3, 4, 5, 30, 31, 38))
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle
union
select sum(o.fldMablagh) as fldMablaghMotamam ,tblCostCenter.fldTitle
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
                                INNER JOIN Pay.tblCostCenter ON p.fldCostCenterId = Pay.tblCostCenter.fldId
                                inner join @M as m on m.payId=m2.fldPersonalId
								where  m2.fldYear= @YearP and m2.fldMonth=@MonthP  AND Com.tblItems_Estekhdam.fldItemsHoghughiId IN (1, 2, 3, 4, 5, 30, 31, 38)
                               group by m2.fldPersonalId,tblCostCenter.fldTitle
                                )t
GROUP BY t.fldTitle

INSERT INTO @temp
SELECT  cast(SUM(Expr1)as bigint)   , 0 AS Expr2, N'اضافه کاری' AS Expr3, fldTitle FROM (select   SUM(cast(Pay.tblMohasebat_Items.fldMablagh as bigint))  AS Expr1, Pay.tblCostCenter.fldTitle
FROM            Pay.tblMohasebat_Items INNER JOIN
                         Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                         Pay.tblMohasebat ON Pay.tblMohasebat_Items.fldMohasebatId = Pay.tblMohasebat.fldId AND Pay.tblMohasebat_Items.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                         Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND 
                         Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId AND (Com.tblItemsHoghughi.fldId IN (33,35,26))
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle,Pay.tblMohasebat.fldid
union
SELECT     SUM(cast(Pay.tblMoavaghat_Items.fldMablagh as bigint)) AS Expr1,tblCostCenter.fldTitle
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMoavaghat.fldMohasebatId = Pay.tblMohasebat.fldId AND Pay.tblMoavaghat.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND 
                      Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE     (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId AND (Com.tblItems_Estekhdam.fldItemsHoghughiId IN (33, 35, 26))
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle
union
select sum(o.fldMablagh) as fldMablaghMotamam ,tblCostCenter.fldTitle
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
                                INNER JOIN Pay.tblCostCenter ON p.fldCostCenterId = Pay.tblCostCenter.fldId
                                inner join @M as m on m.payId=m2.fldPersonalId
								where  m2.fldYear= @YearP and m2.fldMonth=@MonthP  AND Com.tblItems_Estekhdam.fldItemsHoghughiId IN (33, 35, 26)
                                group by m2.fldPersonalId,tblCostCenter.fldTitle
                              
)t
GROUP BY t.fldTitle

INSERT INTO @temp
SELECT  cast(SUM(Expr1)as bigint)   , 0 AS Expr2, N'ماموریت' AS Expr3, fldTitle FROM (select   cast(SUM(Pay.tblMohasebat_Items.fldMablagh)as bigint)  AS Expr1, Pay.tblCostCenter.fldTitle
FROM            Pay.tblMohasebat_Items INNER JOIN
                         Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                         Pay.tblMohasebat ON Pay.tblMohasebat_Items.fldMohasebatId = Pay.tblMohasebat.fldId AND Pay.tblMohasebat_Items.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                         Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND 
                         Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId AND (Com.tblItemsHoghughi.fldId IN (34))
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle,Pay.tblMohasebat.fldid
union
SELECT     SUM(cast(Pay.tblMoavaghat_Items.fldMablagh as bigint)) AS Expr1,tblCostCenter.fldTitle
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMoavaghat.fldMohasebatId = Pay.tblMohasebat.fldId AND Pay.tblMoavaghat.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND 
                      Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE     (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId AND (Com.tblItems_Estekhdam.fldItemsHoghughiId IN (34))
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle
union
select sum(o.fldMablagh) as fldMablaghMotamam ,tblCostCenter.fldTitle
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
                                INNER JOIN Pay.tblCostCenter ON p.fldCostCenterId = Pay.tblCostCenter.fldId
                                inner join @M as m on m.payId=m2.fldPersonalId
								where  m2.fldYear= @YearP and m2.fldMonth=@MonthP  AND Com.tblItems_Estekhdam.fldItemsHoghughiId IN (34)
                                group by m2.fldPersonalId,tblCostCenter.fldTitle
)t
GROUP BY t.fldTitle

INSERT INTO @temp
SELECT    cast(SUM(Expr1)as bigint), 0 AS Expr2, N'عائله مندی' AS Expr3, fldTitle FROM (SELECT   cast( SUM(Pay.tblMohasebat_Items.fldMablagh)
as bigint) AS Expr1, Pay.tblCostCenter.fldTitle
FROM            Pay.tblMohasebat_Items INNER JOIN
                         Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                         Pay.tblMohasebat ON Pay.tblMohasebat_Items.fldMohasebatId = Pay.tblMohasebat.fldId AND Pay.tblMohasebat_Items.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                         Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND 
                         Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId AND (Com.tblItemsHoghughi.fldId IN (22,23))
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle,Pay.tblMohasebat.fldId
union
SELECT     SUM(cast(Pay.tblMoavaghat_Items.fldMablagh as bigint)) AS Expr1,tblCostCenter.fldTitle
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMoavaghat.fldMohasebatId = Pay.tblMohasebat.fldId AND Pay.tblMoavaghat.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND 
                      Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE     (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId AND (Com.tblItems_Estekhdam.fldItemsHoghughiId IN (22,23))
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle
union
select sum(o.fldMablagh) as fldMablaghMotamam ,tblCostCenter.fldTitle
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
                                INNER JOIN Pay.tblCostCenter ON p.fldCostCenterId = Pay.tblCostCenter.fldId
                                inner join @M as m on m.payId=m2.fldPersonalId
								where  m2.fldYear= @YearP and m2.fldMonth=@MonthP  AND Com.tblItems_Estekhdam.fldItemsHoghughiId IN (22,23)
                                group by m2.fldPersonalId,tblCostCenter.fldTitle
)t
GROUP BY t.fldTitle


--IF(@tafkik=1)
--BEGIN
--INSERT INTO @temp
--SELECT cast(SUM(Expr1)as bigint) , 0 AS Expr2, Expr4, fldTitle FROM (SELECT       cast(SUM(Pay.tblMohasebat_Items.fldMablagh)+ISNULL((SELECT        SUM(Pay.tblMoavaghat_Items.fldMablagh)
--FROM            Pay.tblMoavaghat INNER JOIN
--                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
--                         Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
--						 WHERE fldItemsHoghughiId NOT IN (33, 34, 35, 26, 22, 23, 1, 2, 3, 4, 5, 30, 31, 38) and fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0)as bigint) AS Expr1, Com.tblItems_Estekhdam.fldTitle AS Expr4, Pay.tblCostCenter.fldTitle
--FROM            Pay.tblMohasebat_Items INNER JOIN
--                         Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
--                         Pay.tblMohasebat ON Pay.tblMohasebat_Items.fldMohasebatId = Pay.tblMohasebat.fldId AND Pay.tblMohasebat_Items.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
--                         Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
--                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
--                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND 
--                         Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
--WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat AND (Com.tblItemsHoghughi.fldId NOT IN (33, 34, 35, 26, 22, 23, 1, 2, 3, 4, 5, 30, 31, 38))
--GROUP BY Pay.tblCostCenter.fldTitle, Com.tblItems_Estekhdam.fldTitle,Pay.tblMohasebat.fldId)t
--GROUP BY Expr4, fldTitle

--INSERT INTO @temp
--SELECT        cast(SUM(fldMablagh) as bigint)AS Expr1, 0 AS Expr2,N'سایر مطالبات'  AS Expr4, Pay.tblCostCenter.fldTitle
--FROM            Pay.[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
--                         Pay.tblMohasebat ON Pay.[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
--                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
--                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
--		where				 (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat AND fldKosoratId IS NULL
--		GROUP BY Pay.tblCostCenter.fldTitle

--end
IF(@tafkik=0)
BEGIN
	INSERT INTO @temp
	SELECT     cast(SUM(Expr1)as bigint),0 AS Expr2 , N'مزایا' AS Expr3,fldTitle   FROM (SELECT
CAST( ISNULL((SELECT SUM(ISNULL(cast(fldMablagh as bigint),0)) FROM Pay.tblMohasebat_Items WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)+isnull((SELECT SUM(cast(fldMablagh as bigint)) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NULL),0)+sum(fldHaghDarmanKarfFarma+fldHaghDarmanDolat+(Pay.tblMohasebat.fldPasAndaz/2)+fldBimeTakmilyKarFarma+fldBimeOmrKarFarma+fldBimeKarFarma+fldBimeBikari)+
					    ISNULL((SELECT   DISTINCT SUM(fldMablagh)   OVER (PARTITION BY fldMohasebatId) 
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						 WHERE fldMohasebatId=Pay.tblMohasebat.fldId) ,0)
						 + ISNULL((SELECT SUM(Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat+(Pay.tblMoavaghat.fldPasAndaz/2)
						 +Pay.tblMoavaghat.fldBimeBikari+Pay.tblMoavaghat.fldBimeKarFarma )
						  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid GROUP BY fldMohasebatId),0)	AS BIGINT) as expr1,Pay.tblCostCenter.fldTitle
FROM            Pay.tblMohasebat INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND 
                         Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle,Pay.tblMohasebat.fldId
)t
GROUP BY t.fldTitle
--SELECT  cast(SUM(Expr1)as bigint) ,0,N'مزایا',fldTitle FROM (SELECT cast(SUM(Expr1) as bigint) Expr1, Expr4, fldTitle FROM 
--	(SELECT       SUM(Pay.tblMohasebat_Items.fldMablagh) AS Expr1, Com.tblItems_Estekhdam.fldTitle AS Expr4, Pay.tblCostCenter.fldTitle
--FROM            Pay.tblMohasebat_Items INNER JOIN
--                         Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
--                         Pay.tblMohasebat ON Pay.tblMohasebat_Items.fldMohasebatId = Pay.tblMohasebat.fldId AND Pay.tblMohasebat_Items.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
--                         Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
--                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
--                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND 
--                         Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
--WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat AND (Com.tblItemsHoghughi.fldId NOT IN (33, 34, 35, 26, 22, 23, 1, 2, 3, 4, 5, 30, 31, 38))
--GROUP BY Pay.tblCostCenter.fldTitle, Com.tblItems_Estekhdam.fldTitle,Pay.tblMohasebat.fldId)t
--GROUP BY Expr4, fldTitle
--UNION all
--SELECT     SUM(Pay.tblMoavaghat_Items.fldMablagh) AS Expr1,'',tblCostCenter.fldTitle
--FROM         Pay.tblMoavaghat INNER JOIN
--                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
--                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
--                      Pay.tblMohasebat ON Pay.tblMoavaghat.fldMohasebatId = Pay.tblMohasebat.fldId AND Pay.tblMoavaghat.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
--                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND 
--                      Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
--                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
--WHERE     (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat AND (Com.tblItems_Estekhdam.fldItemsHoghughiId NOT IN (33, 34, 35, 26, 22, 23, 1, 2, 3, 4, 5, 30, 31, 38))
--GROUP BY Pay.tblCostCenter.fldTitle

--	UNION all

--			SELECT        cast(SUM(fldMablagh)as bigint) AS Expr1,'',Pay.tblCostCenter.fldTitle
--			FROM            Pay.[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
--									 Pay.tblMohasebat ON Pay.[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
--                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
--                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
--				where				 (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat AND fldKosoratId IS NULL
--				GROUP BY Pay.tblCostCenter.fldTitle)s
--				GROUP BY s.fldTitle

END

INSERT INTO @temp
SELECT   cast(SUM(Expr1)as bigint), 0 AS Expr2, N'حق بیمه کارفرما' , fldTitle FROM (select   cast(SUM((Pay.tblMohasebat.fldBimeTakmilyKarFarma + Pay.tblMohasebat.fldBimeOmrKarFarma + Pay.tblMohasebat.fldHaghDarmanKarfFarma + Pay.tblMohasebat.fldHaghDarmanDolat + Pay.tblMohasebat.fldBimeKarFarma
                          + Pay.tblMohasebat.fldBimeBikari) + Pay.tblMohasebat.fldPasAndaz / 2)
                           +ISNULL((SELECT SUM(tblMoavaghat.fldHaghDarmanKarfFarma+tblMoavaghat.fldHaghDarmanDolat+tblMoavaghat.fldBimeKarFarma+tblMoavaghat.fldBimeBikari+(tblMoavaghat.fldPasAndaz / 2)) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0)as bigint)
                           AS Expr1
                          , Pay.tblCostCenter.fldTitle
FROM            Pay.tblMohasebat INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Pay.tblCostCenter ON Pay.tblCostCenter.fldId = Pay.tblMohasebat_PersonalInfo.fldCostCenterId
WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle,Pay.tblMohasebat.fldid)t
GROUP BY t.fldTitle

INSERT INTO @temp
SELECT   0,cast(SUM(Expr1)as bigint), N'حق بیمه/بازنشستگی' AS Expr3,fldTitle FROM (SELECT   cast(SUM(fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari)
				+ISNULL((SELECT (SUM(fldBimePersonal)+SUM(fldBimeKarFarma)+SUM(fldBimeBikari)) FROM Pay.tblMoavaghat
				WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0)as bigint) AS Expr1,  Pay.tblCostCenter.fldTitle
FROM            Pay.tblMohasebat INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND 
                         Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle,Pay.tblMohasebat.fldid)t
GROUP BY t.fldTitle

INSERT INTO @temp
SELECT     0 AS Expr2,SUM(cast (Expr1 AS bigint)),N'مالیات' AS Expr3, fldTitle   
FROM (SELECT SUM(fldMaliyat)+ISNULL((SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT cast(SUM(tblMoavaghat.fldMaliyat) as bigint) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) )AS Expr1, Pay.tblCostCenter.fldTitle
FROM            Pay.tblMohasebat INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND 
                         Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle,Pay.tblMohasebat.fldId)t
GROUP BY fldTitle

INSERT INTO @temp
SELECT    0 AS Expr2,cast(SUM(Expr1)as bigint), N'پس انداز' AS Expr3, fldTitle  from(select cast(SUM(fldPasAndaz)as bigint)
+ISNULL((SELECT SUM(fldPasAndaz) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)AS Expr1,  Pay.tblCostCenter.fldTitle
FROM            Pay.tblMohasebat INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND 
                         Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle,Pay.tblMohasebat.fldId)t
GROUP BY t.fldTitle

INSERT INTO @temp
SELECT  0 AS Expr2,cast(SUM(Expr1)as bigint) ,N'بیمه عمر' AS Expr3, fldTitle   from(SELECT SUM(fldBimeOmr) AS Expr1, Pay.tblCostCenter.fldTitle
FROM            Pay.tblMohasebat INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND 
                         Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle,Pay.tblMohasebat.fldId)t
GROUP BY fldTitle

INSERT INTO @temp
SELECT   0 AS Expr2,cast(SUM(Expr1)as bigint),  N'بیمه تکمیلی' AS Expr3, fldTitle  FROM(SELECT SUM(cast(fldBimeTakmily as bigint))AS Expr1
, Pay.tblCostCenter.fldTitle
FROM            Pay.tblMohasebat INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND 
                         Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle,Pay.tblMohasebat.fldId)t
GROUP BY fldTitle

INSERT INTO @temp
SELECT     0 AS Expr2,cast(SUM(Expr1)as bigint) , N'حق درمان' AS Expr3,fldTitle   FROM (SELECT
cast(SUM(fldHaghDarman)
+ISNULL((SELECT SUM(fldHaghDarman) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)as bigint)AS Expr1, Pay.tblCostCenter.fldTitle

FROM            Pay.tblMohasebat INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND 
                         Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle,Pay.tblMohasebat.fldId)t
GROUP BY t.fldTitle
--IF(@tafkik=1 )
--BEGIN
--INSERT INTO @temp
--SELECT     0 AS Expr2,cast(SUM(Expr1)as bigint) , N'سایر کسورات' AS Expr3,fldTitle   FROM (SELECT
--cast(isnull(SUM(fldGhestVam+fldMosaede),0)
--+ISNULL(Com.fn_IsMaliyatforMohasebe(Pay.tblMohasebat.fldId),0)
----+ISNULL((SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT cast(SUM(tblMoavaghat.fldMaliyat) as bigint) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0))
--AS bigint) AS Expr1
--,Pay.tblCostCenter.fldTitle
--FROM            Pay.tblMohasebat INNER JOIN
--                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
--                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND 
--                         Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
--WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat
--GROUP BY Pay.tblCostCenter.fldTitle,Pay.tblMohasebat.fldId)t
--GROUP BY t.fldTitle

--INSERT INTO @temp
--SELECT     0 AS Expr2,cast(SUM(Expr1)as bigint) , Expr3,fldTitle   FROM (SELECT
--CAST(ISNULL(SUM([tblMohasebat_kosorat/MotalebatParam].fldMablagh),0)AS bigint)AS Expr1,CAST(tblParametrs.fldTitle COLLATE Latin1_General_CI_AI AS NVARCHAR(MAX))Expr3
--,Pay.tblCostCenter.fldTitle
--FROM         Pay.tblKosorateParametri_Personal INNER JOIN
--                      Pay.[tblMohasebat_kosorat/MotalebatParam] ON Pay.tblKosorateParametri_Personal.fldId = Pay.[tblMohasebat_kosorat/MotalebatParam].fldKosoratId INNER JOIN
--                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
--                      Pay.tblMohasebat ON Pay.[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
--                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
--                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
--WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat
--AND fldKosoratId IS NOT null
--GROUP BY Pay.tblCostCenter.fldTitle,Pay.tblMohasebat.fldId,tblParametrs.fldTitle)t
--GROUP BY t.fldTitle,Expr3

--INSERT INTO @temp
--SELECT     0 AS Expr2,cast(SUM(Expr1)as bigint) ,  Expr3,fldTitle   FROM (SELECT     CAST(ISNULL(SUM(Pay.tblKosuratBank.fldMablagh), 0) AS bigint) AS Expr1, tblBank.fldBankName + N' شعبه ' + tblShobe.fldName AS Expr3, 
--                      Pay.tblCostCenter.fldTitle
--FROM         Pay.tblMohasebat_KosoratBank INNER JOIN
--                      Pay.tblMohasebat INNER JOIN
--                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND 
--                      Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
--                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND 
--                      Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId ON 
--                      Pay.tblMohasebat_KosoratBank.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
--                      Com.tblSHobe AS tblShobe INNER JOIN
--                      Pay.tblKosuratBank ON tblShobe.fldId = Pay.tblKosuratBank.fldShobeId INNER JOIN
--                      Com.tblBank AS tblBank ON tblShobe.fldBankId = tblBank.fldId ON Pay.tblMohasebat_KosoratBank.fldKosoratBankId = Pay.tblKosuratBank.fldId
--WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat
--GROUP BY Pay.tblCostCenter.fldTitle,Pay.tblMohasebat.fldId,fldBankName, tblShobe.fldName)t
--GROUP BY t.fldTitle,Expr3

--end
--ELSE
if(@tafkik=0)
BEGIN

INSERT INTO @temp
SELECT     0 AS Expr2,cast(SUM(Expr1)as bigint) , N'سایر کسورات' AS Expr3,fldTitle   FROM (SELECT
CAST((ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL),0)+ISNULL((select SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
+sum(fldMosaede+fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari+fldMaliyat+fldHaghDarman+Pay.tblMohasebat.fldPasAndaz+Pay.tblMohasebat.fldGhestVam+fldBimeTakmily+Pay.tblMohasebat.fldBimeOmr))+
					    ISNULL(Com.fn_IsMaliyatforMohasebe(Pay.tblMohasebat.fldId),0)+ISNULL((SELECT sum(fldBimePersonal+fldPasAndaz+fldHaghDarman+fldBimeKarFarma+fldBimeBikari ) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) AS bigint) as expr1,Pay.tblCostCenter.fldTitle
FROM            Pay.tblMohasebat INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId AND Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId AND 
                         Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId
WHERE        (Pay.tblMohasebat.fldYear = @year) AND (Pay.tblMohasebat.fldMonth = @month)AND tblMohasebat.fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
and fldCalcType=@CalcType
GROUP BY Pay.tblCostCenter.fldTitle,Pay.tblMohasebat.fldId)t
GROUP BY t.fldTitle
end

declare cur cursor for
select distinct markaz from @temp
open cur
declare @fldid int,@fldbed bigint,@fldbes bigint,@flddesc nvarchar(max),@markaz nvarchar(max)
fetch next from cur into @markaz
while @@FETCH_STATUS=0
begin
	update @temp set fldbes=fldbes-(select sum(fldbes) from @temp where markaz=@markaz and flddesc<>N'سایر کسورات') where markaz=@markaz and flddesc=N'سایر کسورات'
	update @temp set fldbed=fldbed-(select sum(fldbed) from @temp where markaz=@markaz and flddesc<>N'مزایا') where markaz=@markaz and flddesc=N'مزایا'
fetch next from cur into @markaz
end

close cur
DEALLOCATE cur		
--SELECT * FROM @temp WHERE fldbed<>0 OR fldbes<>0 ORDER BY markaz,fldid,flddesc

INSERT INTO @temp

SELECT 0, cast(SUM(fldbed)as bigint)-cast(SUM(fldbes)as bigint),N'خالص پرداختی',markaz FROM @temp GROUP BY markaz

SELECT * FROM @temp
ORDER BY markaz
--GROUP BY fldid,fldbed,fldbes,flddesc, markaz
--SELECT * FROM Com.tblItemsHoghughi
GO
