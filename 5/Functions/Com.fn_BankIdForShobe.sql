SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [Com].[fn_BankIdForShobe] (@fldShobeId int)
returns int
with schemabinding 
as
begin
declare @s int
SELECT @s= Com.tblSHobe.fldBankId
FROM     Com.tblSHobe
where  fldId=@fldShobeId
return @s
end
GO
