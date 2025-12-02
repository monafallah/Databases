SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_CheckTanzimatDaramad](@avarezId INT,@MaliyatId INT,@TakhirId INT)
as
/*IF EXISTS (SELECT * FROM Drd.tblTanzimateDaramad WHERE fldMaliyatId=@avarezId OR fldTakhirId=@avarezId) 
SELECT fldOrganId FROM Drd.tblTanzimateDaramad WHERE fldMaliyatId=@avarezId OR fldTakhirId=@avarezId

ELSE IF EXISTS (SELECT * FROM Drd.tblTanzimateDaramad WHERE fldAvarezId=@MaliyatId OR fldTakhirId=@MaliyatId)
SELECT fldOrganId FROM Drd.tblTanzimateDaramad WHERE fldAvarezId=@MaliyatId OR fldTakhirId=@MaliyatId*/

IF EXISTS (SELECT * FROM Drd.tblTanzimateDaramad WHERE fldAvarezId=@TakhirId OR fldMaliyatId=@TakhirId)
SELECT fldOrganId FROM Drd.tblTanzimateDaramad WHERE fldAvarezId=@TakhirId OR fldMaliyatId=@TakhirId

ELSE 
SELECT 0 AS fldOrganId
GO
