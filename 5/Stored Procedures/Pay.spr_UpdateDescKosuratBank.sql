SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_UpdateDescKosuratBank](@Id INT,@Desc NVARCHAR(max),@userId INT)
as
UPDATE Pay.tblKosuratBank
SET fldDesc=@Desc
WHERE fldId=@Id
GO
