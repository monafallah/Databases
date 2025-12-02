SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_CheckCopyCode](@maghsadId INT)
as

IF EXISTS(SELECT * FROM Drd.tblParametreSabet WHERE fldShomareHesabCodeDaramadId=@maghsadid)
SELECT 1 AS fldCheck
ELSE IF EXISTS (SELECT * FROM Drd.tblRoonevesht WHERE fldShomareHesabCodeDaramadId=@maghsadid)
SELECT 1  AS fldCheck
ELSE IF EXISTS (SELECT * FROM Drd.tblLetterMinut WHERE fldShomareHesabCodeDaramadId=@maghsadid)
SELECT 1 AS fldCheck
ELSE 
SELECT 0 AS fldCheck
GO
