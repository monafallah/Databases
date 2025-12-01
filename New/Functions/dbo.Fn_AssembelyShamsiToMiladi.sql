SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO
CREATE FUNCTION [dbo].[Fn_AssembelyShamsiToMiladi] (@Tarikh [nvarchar] (20))
RETURNS [datetime]
WITH EXECUTE AS CALLER
EXTERNAL NAME [ClassLibrary1].[clsShamsi].[ShamsiToMiladi]
GO
