SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO
CREATE FUNCTION [dbo].[Fn_AssembelyMiladiToShamsi] (@Tarikh [datetime])
RETURNS [nvarchar] (10)
WITH EXECUTE AS CALLER
EXTERNAL NAME [ClassLibrary1].[clsShamsi].[MiladiToShamsi]
GO
