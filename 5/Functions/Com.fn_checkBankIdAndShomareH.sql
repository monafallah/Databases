SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE Function [Com].[fn_checkBankIdAndShomareH](@fldshobeId int,@fldShomareHesab varchar(50))
returns bit
as
begin 
DECLARE @s BIT=1
IF (SELECT COUNT(*) 
FROM   com.tblShomareHesabeOmoomi
WHERE fldBankId=com.fn_BankIdForShobe(@fldshobeId) and  fldShomareHesab=@fldShomareHesab)>1

	SET @s=0

	 
RETURN @s
end


GO
