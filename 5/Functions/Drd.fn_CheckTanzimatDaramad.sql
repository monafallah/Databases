SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Drd].[fn_CheckTanzimatDaramad](@avarezId INT,@MaliyatId INT,@TakhirId INT)
RETURNS BIT
AS
BEGIN
--DECLARE @avarezId INT,@MaliyatId INT,@TakhirId INT,
DEClare @type BIT=0

IF EXISTS (SELECT * FROM Drd.tblTanzimateDaramad WHERE fldMaliyatId=@avarezId OR fldTakhirId=@avarezId) 
BEGIN
set @type=CAST(1 AS BIT)
end
ELSE IF EXISTS (SELECT * FROM Drd.tblTanzimateDaramad WHERE fldAvarezId=@MaliyatId OR fldTakhirId=@MaliyatId)
BEGIN
set @type=CAST(1 AS BIT)
end
ELSE IF EXISTS (SELECT * FROM Drd.tblTanzimateDaramad WHERE fldAvarezId=@TakhirId OR fldMaliyatId=@TakhirId)
BEGIN
set @type=CAST(1 AS BIT)
end
RETURN @type
END 
GO
