SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[GETTIME](@STARTDATE Datetime,@ENDDATE Datetime)
RETURNS NVARCHAR(max)
AS
BEGIN
--declare @temp datetime=null
--if (@STARTDATE>@ENDDATE)
--begin
--set @temp=@ENDDATE
--set @ENDDATE=@STARTDATE
--set @STARTDATE=@temp
--end

DECLARE @result varchar(max)
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
    -- Insert statements for procedure here
	DECLARE @DayNameCheck varchar(250),@daynum1 int,@daynum2 int,@diffHours int,@dayDifday int;
	
	SELECT @daynum1=(SELECT datepart(WEEKDAY,@STARTDATE));
	SELECT @daynum2=(SELECT datepart(WEEKDAY,@ENDDATE));
	IF(@ENDDATE<@STARTDATE)
	BEGIN
		SELECT @diffHours=(SELECT DATEDIFF(HH, @STARTDATE,'23:59:0'));
		SELECT @diffHours=@diffHours+(SELECT DATEPART(HH,@ENDDATE))+1;
	END
	ELSE
		SELECT @diffHours=(SELECT DATEDIFF(HH, @STARTDATE,@ENDDATE));
	
	SELECT @dayDifday=(SELECT DATEDIFF(day,@STARTDATE,@ENDDATE));
	
	--If Both Dates Are Same
	
	IF((SELECT(CONVERT(DATE,@STARTDATE)))= (SELECT(CONVERT(DATE,@ENDDATE))))
	BEGIN	
	DECLARE @getsecond int;
	IF(@ENDDATE<@STARTDATE)
	BEGIN
		SELECT @getsecond=(SELECT DATEDIFF(SS, @STARTDATE,'23:59:0'));
		SELECT @getsecond=@getsecond+(SELECT DATEDIFF(SS,'0:0',@ENDDATE))+60;
	END
	ELSE
		SELECT @getsecond=DATEDIFF(SECOND,@STARTDATE, @ENDDATE);
	--SELECT @result=(Convert(numeric(18,3),
	--   (SELECT DATEDIFF(SECOND,@STARTDATE, @ENDDATE)))/Convert(numeric(18,3),3600));	
	
	--Declare @SubtractDate1 as datetime
	----Enter Number of Seconds here	
	--Set @SubtractDate1=(SELECT DateAdd(s,@getsecond,getdate()) - Getdate())  
	--SELECT @result=(Select (Convert(varchar(10),DatePart(hh,@SubtractDate1))+ ' : ' +
	--  Convert(varchar(10),DatePart(mi,@SubtractDate1))+ ' : ' +
	--     Convert(varchar(10),DatePart(ss,@SubtractDate1))));
	  SELECT @result=(SELECT CAST(@getsecond/3600 AS VARCHAR(10))+ 
	         RIGHT(CONVERT(CHAR(8),DATEADD(ss,@getsecond,0),108),6));
	END
		
    --If Both Dates Are Different
		
	ELSE IF((SELECT(CONVERT(DATE,@STARTDATE)))!=(SELECT(CONVERT(DATE,@ENDDATE))))
	BEGIN	
	DECLARE @Date DATE,@gg DATE,@cc Date,@val int=0,@getseconds int=0,
	@getstart Time,@EndTime Time='18:30:00.000',@StartTime Time='07:30:00.000',@getweek int;
	
	
	SELECT @Date=(SELECT Convert(DATE,@STARTDATE));
    SELECT @getstart=(SELECT Convert(TIME,@STARTDATE));
	SELECT @getseconds=@getseconds+DATEDIFF(SECOND,(CAST (@Date AS DATETIME) + 
	       @getstart),(CAST (@Date AS DATETIME) + @EndTime))
	
	WHILE(@val<@dayDifday)
	BEGIN	
	SELECT @Date=(SELECT Convert(DATE,DATEADD(day,1,@Date)));--Adding one day to Date
	SELECT @getweek=(SELECT datepart(WEEKDAY,@Date));	
	IF(@getweek!=1 AND @getweek!=7)
	BEGIN
	
	IF(@Date!=Convert(DATE,@ENDDATE))
	BEGIN	
	SELECT @getseconds=@getseconds+DATEDIFF(SECOND,(CAST (@Date AS DATETIME) + 
	       @StartTime),(CAST (@Date AS DATETIME) + @EndTime))
	END        
	ELSE IF(@Date=Convert(DATE,@ENDDATE))
	BEGIN
	DECLARE @tt Time;
	SELECT @tt=CONVERT(Time,@ENDDATE)
	
	SELECT @getseconds=@getseconds+DATEDIFF(SECOND,(CAST 
	  (Convert(DATE,@ENDDATE) AS DATETIME) + @StartTime),
	  (CAST (Convert(DATE,@ENDDATE) AS DATETIME) + @tt))
	BREAK;
	END	
	END
	SET @val=@val+1;	
	END
	
	--SELECT @result=(Convert(numeric(18,3),@getseconds)/Convert(numeric(18,3),3600));		
	

 SELECT @result=(SELECT CAST(@getseconds/3600 AS VARCHAR(10))+ 
          RIGHT(CONVERT(CHAR(8),DATEADD(ss,@getseconds,0),108),6));
 --     	Declare @SubtractDate as datetime
	----Enter Number of Seconds here	
	--Set @SubtractDate=(SELECT DateAdd(s,@getseconds,getdate()) - Getdate())
--	SELECT @result=(Select Convert(varchar(10),DateDiff(day,'1900-01-01',@SubtractDate))
--+ ' Day(s) '+(Convert(varchar(10),DatePart(hh,@SubtractDate))+ ' : ' + 
--      Convert(varchar(10),DatePart(mi,@SubtractDate))+ ' : ' +
--        Convert(varchar(10),DatePart(ss,@SubtractDate))));
	END

	
	RETURN @result
	
END
GO
