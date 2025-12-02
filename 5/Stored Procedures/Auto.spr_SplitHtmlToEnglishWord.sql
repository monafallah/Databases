SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Auto].[spr_SplitHtmlToEnglishWord](@HTMLText NVARCHAR(MAX))
as
begin
 --declare @HTMLText NVARCHAR(MAX)=N'<div style="font-family: B Nazanin;"><p dir="RTL"><strong>شهردار محترم آب ttt;بر</strong></p><p dir="RTL"><strong>موضوع: قطعی درگاه پارسیان</strong></p><p dir="RTL"><strong>با سلام و احترام؛</strong><strong></strong></p><p dir="RTL"><strong> به استحضار می&zwnj;رساند با توجه به قطع شدن درگاه پارسیان مرتبط با سامانه عوارض خودرو و پیگیری&zwnj;های متعدد از شرکت پارسیان و عدم همکاری لازم، این شرکت درنظردارد به&zwnj;منظور تسهیل انجام امور مربوط به پرداخت عوارض خودرو در شهرداری و دفاتر، درگاه جدید سامان کیش را برای آن شهرداری محترم تهیه نماید. خواهشمند است جهت تسریع در انجام اقدامات مذکور، هرچه سریع&zwnj;تر ضمایم را تکمیل و به شرکت ارسال نمایید.</strong></p><p style="text-align: justify; direction: rtl;" dir="RTL"><strong>پیشاپیش از همکاری شما سپاسگزاریم.% </strong></p></div>'
  declare @HTMLText1 NVARCHAR(MAX)=''

  --,@HTMLText2 nvarchar(max)=''
  declare @t table (id int)
SELECT @HTMLText=REPLACE(@HTMLText,'&nbsp;',' ')
--SELECT @HTMLText1=CHARINDEX('&',@HTMLText)
    DECLARE @Start INT
    DECLARE @End INT
    DECLARE @Length INT

    SET @Start = CHARINDEX('<',@HTMLText)
	
    SET @End = CHARINDEX('>',@HTMLText,CHARINDEX('<',@HTMLText))
    SET @Length = (@End - @Start) + 1
	----select @Start,@Length,@HTMLText
	select @HTMLText1= SUBSTRING(@HTMLText,@Start,@Length)
	set @HTMLText=replace (@HTMLText,@HTMLText1,' ')
	--select @HTMLText1,@HTMLText
   WHILE @Start > 0 AND @End > 0 AND @Length > 0
    BEGIN
        --SET @HTMLText = STUFF(@HTMLText,@Start,@Length,' ')
		--select @HTMLText
        SET @Start = CHARINDEX('<',@HTMLText)
        SET @End = CHARINDEX('>',@HTMLText,CHARINDEX('<',@HTMLText))
        SET @Length = (@End - @Start) + 1
		
		select @HTMLText1= SUBSTRING(@HTMLText,@Start,@Length)
		--select @HTMLText1
		set @HTMLText=replace (@HTMLText,@HTMLText1,' ')
		--select @HTMLText
		--select @Start,@end,@Length l,@HTMLText
    END
	
	
	--select @HTMLText

	select * from (select replace (item,'&zwnj','')item  from com.split (@HTMLText,' '))t
	where item <>'' and item like '%[a-zA-Z]%' 
	group by Item

end
GO
