SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[LogSelect](@__$operation as int)
RETURNS nvarchar(30)
AS
BEGIN
declare @name as nvarchar(30)
set @name=case @__$operation
	when 1 then N'حذف'
	when 2 then N'اضافه'
	when 3 then N'اطلاعات قبل از ویرایش'
	when 4 then N'اطلاعات بعد از ویرایش'

	end
return @name
END
GO
