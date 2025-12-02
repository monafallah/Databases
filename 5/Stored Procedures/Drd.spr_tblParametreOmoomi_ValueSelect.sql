SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreOmoomi_ValueSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value1 NVARCHAR(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	DECLARE @tarikh NVARCHAR(10)=dbo.Fn_AssembelyMiladiToShamsi(GETDATE())
	if (@fieldname=N'fldId')
	SELECT TOP (@h) Drd.tblParametreOmoomi_Value.fldId, Drd.tblParametreOmoomi_Value.fldParametreOmoomiId, Drd.tblParametreOmoomi_Value.fldFromDate, 
                  Drd.tblParametreOmoomi_Value.fldEndDate, Drd.tblParametreOmoomi_Value.fldValue, Drd.tblParametreOmoomi_Value.fldUserId, Drd.tblParametreOmoomi_Value.fldDesc,Drd.tblParametreOmoomi.fldNameParametreFa+'('+Drd.tblParametreOmoomi.fldNameParametreEn+')' as nameParametrFa_En ,
                  Drd.tblParametreOmoomi_Value.fldDate
FROM     Drd.tblParametreOmoomi_Value INNER JOIN
                  Drd.tblParametreOmoomi ON Drd.tblParametreOmoomi_Value.fldParametreOmoomiId = Drd.tblParametreOmoomi.fldId
	WHERE  Drd.tblParametreOmoomi_Value.fldId = @Value

	if (@fieldname=N'fldParametreOmoomiId')
	SELECT top(@h) Drd.tblParametreOmoomi_Value.fldId, Drd.tblParametreOmoomi_Value.fldParametreOmoomiId, Drd.tblParametreOmoomi_Value.fldFromDate, 
                  Drd.tblParametreOmoomi_Value.fldEndDate, Drd.tblParametreOmoomi_Value.fldValue, Drd.tblParametreOmoomi_Value.fldUserId, Drd.tblParametreOmoomi_Value.fldDesc,Drd.tblParametreOmoomi.fldNameParametreFa+'('+Drd.tblParametreOmoomi.fldNameParametreEn+')' as nameParametrFa_En ,
                  Drd.tblParametreOmoomi_Value.fldDate
FROM     Drd.tblParametreOmoomi_Value INNER JOIN
                  Drd.tblParametreOmoomi ON Drd.tblParametreOmoomi_Value.fldParametreOmoomiId = Drd.tblParametreOmoomi.fldId 
	WHERE  Drd.tblParametreOmoomi_Value.fldParametreOmoomiId = @Value

IF (@fieldname=N'LastDate')
	select top( 1) * from(
	select  fldId, fldParametreOmoomiId, fldFromDate, 
                  coalesce(fldEndDate,dbo.Fn_AssembelyMiladiToShamsi(dateadd(day,-1,com.shamsiToMiladi(fldEndDateLead))),@tarikh) as fldEndDate, fldValue, fldUserId,  fldDesc, nameParametrFa_En ,
                   fldDate from (
	SELECT  Drd.tblParametreOmoomi_Value.fldId, Drd.tblParametreOmoomi_Value.fldParametreOmoomiId, Drd.tblParametreOmoomi_Value.fldFromDate, 
                  case when fldEndDate='' then null else Drd.tblParametreOmoomi_Value.fldEndDate end fldEndDate
				  , Drd.tblParametreOmoomi_Value.fldValue, Drd.tblParametreOmoomi_Value.fldUserId, Drd.tblParametreOmoomi_Value.fldDesc,Drd.tblParametreOmoomi.fldNameParametreFa+'('+Drd.tblParametreOmoomi.fldNameParametreEn+')' as nameParametrFa_En ,
                  Drd.tblParametreOmoomi_Value.fldDate
				  ,lead(fldFromDate) over (partition by fldParametreOmoomiId order by fldFromDate,Drd.tblParametreOmoomi_Value.fldId) as fldEndDateLead
FROM     Drd.tblParametreOmoomi_Value INNER JOIN
                  Drd.tblParametreOmoomi ON Drd.tblParametreOmoomi_Value.fldParametreOmoomiId = Drd.tblParametreOmoomi.fldId 
	WHERE  Drd.tblParametreOmoomi_Value.fldParametreOmoomiId = @value )t)t2
	where @tarikh between fldFromDate and fldEndDate
	order by fldEndDate desc,fldFromDate desc
	
	
	if (@fieldname=N'fldDesc')
	SELECT top(@h) Drd.tblParametreOmoomi_Value.fldId, Drd.tblParametreOmoomi_Value.fldParametreOmoomiId, Drd.tblParametreOmoomi_Value.fldFromDate, 
                  Drd.tblParametreOmoomi_Value.fldEndDate, Drd.tblParametreOmoomi_Value.fldValue, Drd.tblParametreOmoomi_Value.fldUserId, Drd.tblParametreOmoomi_Value.fldDesc,Drd.tblParametreOmoomi.fldNameParametreFa+'('+Drd.tblParametreOmoomi.fldNameParametreEn+')' as nameParametrFa_En ,
                  Drd.tblParametreOmoomi_Value.fldDate
FROM     Drd.tblParametreOmoomi_Value INNER JOIN
                  Drd.tblParametreOmoomi ON Drd.tblParametreOmoomi_Value.fldParametreOmoomiId = Drd.tblParametreOmoomi.fldId
	WHERE  Drd.tblParametreOmoomi_Value.fldDesc like @Value



		if (@fieldname=N'nameParametrFa_En')
	SELECT top(@h)* from(select Drd.tblParametreOmoomi_Value.fldId, Drd.tblParametreOmoomi_Value.fldParametreOmoomiId, Drd.tblParametreOmoomi_Value.fldFromDate, 
                  Drd.tblParametreOmoomi_Value.fldEndDate, Drd.tblParametreOmoomi_Value.fldValue, Drd.tblParametreOmoomi_Value.fldUserId, Drd.tblParametreOmoomi_Value.fldDesc,Drd.tblParametreOmoomi.fldNameParametreFa+'('+Drd.tblParametreOmoomi.fldNameParametreEn+')' as nameParametrFa_En ,
                  Drd.tblParametreOmoomi_Value.fldDate
FROM     Drd.tblParametreOmoomi_Value INNER JOIN
                  Drd.tblParametreOmoomi ON Drd.tblParametreOmoomi_Value.fldParametreOmoomiId = Drd.tblParametreOmoomi.fldId)as t
	WHERE  nameParametrFa_En like @Value


	if (@fieldname=N'fldFromDate')
	SELECT top(@h)Drd.tblParametreOmoomi_Value.fldId, Drd.tblParametreOmoomi_Value.fldParametreOmoomiId, Drd.tblParametreOmoomi_Value.fldFromDate, 
                  Drd.tblParametreOmoomi_Value.fldEndDate, Drd.tblParametreOmoomi_Value.fldValue, Drd.tblParametreOmoomi_Value.fldUserId, Drd.tblParametreOmoomi_Value.fldDesc,Drd.tblParametreOmoomi.fldNameParametreFa+'('+Drd.tblParametreOmoomi.fldNameParametreEn+')' as nameParametrFa_En ,
                  Drd.tblParametreOmoomi_Value.fldDate
FROM     Drd.tblParametreOmoomi_Value INNER JOIN
                  Drd.tblParametreOmoomi ON Drd.tblParametreOmoomi_Value.fldParametreOmoomiId = Drd.tblParametreOmoomi.fldId
	WHERE  Drd.tblParametreOmoomi_Value.fldFromDate like @Value




	if (@fieldname=N'fldEndDate')
	SELECT top(@h)Drd.tblParametreOmoomi_Value.fldId, Drd.tblParametreOmoomi_Value.fldParametreOmoomiId, Drd.tblParametreOmoomi_Value.fldFromDate, 
                  Drd.tblParametreOmoomi_Value.fldEndDate, Drd.tblParametreOmoomi_Value.fldValue, Drd.tblParametreOmoomi_Value.fldUserId, Drd.tblParametreOmoomi_Value.fldDesc,Drd.tblParametreOmoomi.fldNameParametreFa+'('+Drd.tblParametreOmoomi.fldNameParametreEn+')' as nameParametrFa_En ,
                  Drd.tblParametreOmoomi_Value.fldDate
FROM     Drd.tblParametreOmoomi_Value INNER JOIN
                  Drd.tblParametreOmoomi ON Drd.tblParametreOmoomi_Value.fldParametreOmoomiId = Drd.tblParametreOmoomi.fldId
	WHERE  Drd.tblParametreOmoomi_Value.fldEndDate like @Value

	
	if (@fieldname=N'CheckDate')
	select  * from(
	select  fldId, fldParametreOmoomiId, fldFromDate, 
                  coalesce(fldEndDate,dbo.Fn_AssembelyMiladiToShamsi(dateadd(day,-1,com.shamsiToMiladi(fldEndDateLead)))) as fldEndDate, fldValue, fldUserId,  fldDesc, nameParametrFa_En ,
                   fldDate from (
	SELECT  Drd.tblParametreOmoomi_Value.fldId, Drd.tblParametreOmoomi_Value.fldParametreOmoomiId, Drd.tblParametreOmoomi_Value.fldFromDate, 
                  case when fldEndDate='' then null else Drd.tblParametreOmoomi_Value.fldEndDate end fldEndDate
				  , Drd.tblParametreOmoomi_Value.fldValue, Drd.tblParametreOmoomi_Value.fldUserId, Drd.tblParametreOmoomi_Value.fldDesc,Drd.tblParametreOmoomi.fldNameParametreFa+'('+Drd.tblParametreOmoomi.fldNameParametreEn+')' as nameParametrFa_En ,
                  Drd.tblParametreOmoomi_Value.fldDate
				  ,lead(fldFromDate) over (partition by fldParametreOmoomiId order by fldFromDate,Drd.tblParametreOmoomi_Value.fldId) as fldEndDateLead
FROM     Drd.tblParametreOmoomi_Value INNER JOIN
                  Drd.tblParametreOmoomi ON Drd.tblParametreOmoomi_Value.fldParametreOmoomiId = Drd.tblParametreOmoomi.fldId 
	 )t)t2
	where (@Value1 is not null and(fldFromDate between @Value and @Value1
	or fldEndDate between @Value and @Value1
	or @Value between fldFromDate and fldEndDate
	or @Value1 between fldFromDate and fldEndDate))
	or (@Value1 is null and((@Value <= fldFromDate and fldEndDate is null)
	or @Value between fldFromDate and fldEndDate ))

	if (@fieldname=N'fldValue')
	SELECT top(@h)Drd.tblParametreOmoomi_Value.fldId, Drd.tblParametreOmoomi_Value.fldParametreOmoomiId, Drd.tblParametreOmoomi_Value.fldFromDate, 
                  Drd.tblParametreOmoomi_Value.fldEndDate, Drd.tblParametreOmoomi_Value.fldValue, Drd.tblParametreOmoomi_Value.fldUserId, Drd.tblParametreOmoomi_Value.fldDesc,Drd.tblParametreOmoomi.fldNameParametreFa+'('+Drd.tblParametreOmoomi.fldNameParametreEn+')' as nameParametrFa_En ,
                  Drd.tblParametreOmoomi_Value.fldDate
FROM     Drd.tblParametreOmoomi_Value INNER JOIN
                  Drd.tblParametreOmoomi ON Drd.tblParametreOmoomi_Value.fldParametreOmoomiId = Drd.tblParametreOmoomi.fldId
	WHERE  Drd.tblParametreOmoomi_Value.fldValue like @Value



	if (@fieldname=N'')
	SELECT top(@h) Drd.tblParametreOmoomi_Value.fldId, Drd.tblParametreOmoomi_Value.fldParametreOmoomiId, Drd.tblParametreOmoomi_Value.fldFromDate, 
                  Drd.tblParametreOmoomi_Value.fldEndDate, Drd.tblParametreOmoomi_Value.fldValue, Drd.tblParametreOmoomi_Value.fldUserId, Drd.tblParametreOmoomi_Value.fldDesc,Drd.tblParametreOmoomi.fldNameParametreFa+'('+Drd.tblParametreOmoomi.fldNameParametreEn+')' as nameParametrFa_En ,
                  Drd.tblParametreOmoomi_Value.fldDate
FROM     Drd.tblParametreOmoomi_Value INNER JOIN
                  Drd.tblParametreOmoomi ON Drd.tblParametreOmoomi_Value.fldParametreOmoomiId = Drd.tblParametreOmoomi.fldId

	COMMIT
GO
