SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[date_to_words] (@tarikh NVARCHAR(10) ) 
 RETURNS 
  NVARCHAR(100)
   as
    BEGIN 
    --DECLARE @tarikh NVARCHAR(10)=com.MiladiTOShamsi(@date) 
    DECLARE @year_ as varchar(4)
	DECLARE @mon_ as varchar(2)
	DECLARE @day_ as varchar(2)
    set @year_=SUBSTRING(@tarikh,1,4)
	SET @mon_=SUBSTRING(@tarikh,6,2)
	SET @day_=SUBSTRING(@tarikh,9,2)
/*
declare @year_ as varchar(4)
declare @mon_ as varchar(2)
declare @day_ as varchar(2)

set @year_='1390'
set @mon_='01'
set @day_='02'*/
    /* Converts date into words */
    DECLARE @yr INT 
    DECLARE @dateval INT 
    DECLARE @thousand INT 
    DECLARE @hundred  INT 
    DECLARE @tens INT 
    DECLARE @mon INT 
    DECLARE @tensword NVARCHAR(10) 
    DECLARE @onesword NVARCHAR(10) 
    DECLARE @thousandsword NVARCHAR(20) 
    DECLARE @hundredsword  NVARCHAR(20) 
    DECLARE @datevalsword NVARCHAR(20)
    DECLARE @MonWord NVARCHAR(20)
 

    SET @yr=cast(@year_ as int)
    SET @dateval=cast(@day_ as int)
    Set @mon=cast(@mon_ as int)


    /* Mon TO WORDS */

    SELECT @MonWord =CASE @Mon
    WHEN 1 THEN N' فروردین ماه '
    WHEN 2 THEN  N' اردیبهشت ماه '
    WHEN 3 THEN  N' خرداد ماه '
    WHEN 4 THEN  N' تیر ماه '
    WHEN 5 THEN  N' مرداد ماه '
    WHEN 6 THEN  N' شهریور ماه '
    WHEN 7 THEN  N' مهر ماه '
    WHEN 8 THEN  N' ابان ماه '
    WHEN 9 THEN  N' اذر ماه '
    WHEN 10 THEN  N' دی ماه '
    WHEN 11 THEN N' بهمن ماه '
    WHEN 12 THEN  N' اسفند ماه '
    END
    /* DAY TO WORDS */

    SELECT @datevalsword =CASE @dateval
    WHEN 1 THEN N'اول'
    WHEN 2 THEN  N'دوم'
    WHEN 3 THEN  N'سوم'
    WHEN 4 THEN  N'چهارم'
    WHEN 5 THEN  N'پنجم'
    WHEN 6 THEN  N'ششم'
    WHEN 7 THEN  N'هفتم'
    WHEN 8 THEN  N'هشتم'
    WHEN 9 THEN  N'نهم'
    WHEN 10 THEN  N'دهم'
    WHEN 11 THEN  N'یازدهم'
    WHEN 12 THEN  N'دوازدهم'
    WHEN 13 THEN  N'سیزدهم'
    WHEN 14 THEN  N'چهاردهم'
    WHEN 15 THEN  N'پانزدهم'
    WHEN 16 THEN  N'شانزدهم'
    WHEN 17 THEN  N'هفدهم'
    WHEN 18 THEN  N'هجدهم'
    WHEN 19 THEN  N'نوزدهم'
    WHEN 20 THEN  N'بیستم'
    WHEN 21 THEN  N' بیست و یکم'
    WHEN 22 THEN  N' بیست و دوم'
    WHEN 23 THEN  N'بیست و سوم'
    WHEN 24 THEN  N'بیست و چهارم'
    WHEN 25 THEN  N'بیست و پنجم'
    WHEN 26 THEN  N'بیست و ششم'
    WHEN 27 THEN  N'بیست و هفتم'
    WHEN 28 THEN  N'بیست و هشتم'
    WHEN 29 THEN  N'بیست و نهم'
    WHEN 30 THEN  N'سی ام'
    WHEN 31 THEN  N'سی و یکم'
    END  

    /* YEAR TO WORDS */

    set @thousand=floor(@yr/1000)  
    set @yr = @yr - @thousand * 1000 
    set @hundred = floor(@yr / 100) 
    set @yr = @yr - @hundred * 100 

    IF (@yr > 19)
    begin
    set @tens = floor(@yr / 10) 
    set @yr = @yr % 10 
    end 
    ELSE
    set @tens=0 

    SELECT @thousandsword=CASE @thousand
    WHEN 1 THEN  N'یک هزار '
    WHEN 2 THEN  N'دو هزار'
    WHEN 3 THEN  N'سه هزار'
    WHEN 4 THEN  N'چهار هزار'
    WHEN 5 THEN  N'پنج هزار'
    WHEN 6 THEN  N'شش هزار'
    WHEN 7 THEN  N'هفت هزار'
    WHEN 8 THEN  N'هشت هزار'
    WHEN 9 THEN  N'نه هزار'
    else ''
    END   

    SELECT @hundredsword=CASE @hundred
    WHEN 0 then ''
    WHEN 1 THEN  N'یک صد'
    WHEN 2 THEN  N'دویست '
    WHEN 3 THEN  N'سیصد '
    WHEN 4 THEN  N'چهارصد '
    WHEN 5 THEN  N'پانصد '
    WHEN 6 THEN  N'ششصد '
    WHEN 7 THEN  N'هفتصد '
    WHEN 8 THEN  N'هشتصد '
    WHEN 9 THEN  N'نهصد '
    else ''
    END   
    if (@hundred<>'')
    set @hundredsword=N'و'+@hundredsword

    /*@tens To WORDS*/
    SELECT @tensword=CASE @tens
    WHEN 2 THEN  N'بیست '
    WHEN 3 THEN  N'سی '
    WHEN 4 THEN  N'چهل '
    WHEN 5 THEN  N'پنجاه '
    WHEN 6 THEN  N'شصت '
    WHEN 7 THEN  N'هفتاد'
    WHEN 8 THEN  N'هشتاد'
    WHEN 9 THEN  N'نود'
    ELSE ''
    END   
    if (@tens<>'')
    set @tensword=N'و'+@tensword
    /*ONES To WORDS*/
    SELECT @onesword=CASE @yr
    WHEN 0 THEN ''
    WHEN 1 THEN  N'یک'
    WHEN 2 THEN  N'دو'
    WHEN 3 THEN  N'سه'
    WHEN 4 THEN  N'چهار'
    WHEN 5 THEN  N'پنج'
    WHEN 6 THEN  N'شش'
    WHEN 7 THEN  N'هفت'
    WHEN 8 THEN  N'هشت'
    WHEN 9 THEN  N'نه'
    WHEN 10 THEN  N'ده'
    WHEN 11 THEN  N'یازده'
    WHEN 12 THEN  N'دوازده'
    WHEN 13 THEN  N'سیزده'
    WHEN 14 THEN  N'چهارده'
    WHEN 15 THEN  N'پانزده'
    WHEN 16 THEN  N'شانزده'
    WHEN 17 THEN  N'هفده'
    WHEN 18 THEN  N'هجده'
    WHEN 19 THEN  N'نوزده'
    END  
    if (@yr<>'')
    set @onesword=N'و'+@onesword 
    return (@datevalsword+@monWord+@thousandsword+@hundredsword+ @tensword+' '+@onesword) 
  END 
GO
