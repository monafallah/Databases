SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[tblBankBill_DetailsDeleteNotExists]
 @HedearId int
 as
begin tran
if  exists (
SELECT * 
	FROM   [ACC].[tblBankBill_Details] 
	WHERE  [fldHedearId]=@HedearId)
	begin
		select 1 as flag
	end
	else 
	begin
		delete 	FROM   [ACC].[tblBankBill_Header] 
		WHERE  fldId=@HedearId
		select 0 as flag
	END
commit tran		
GO
