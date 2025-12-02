SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_GetDate]
AS
select getdate() as fldDateTime,dbo.Fn_AssembelyMiladiToShamsi(getdate()) as fldTarikh , cast(  GETDATE()as time (0)) as fldTime
GO
