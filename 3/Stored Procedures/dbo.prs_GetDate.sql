SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [dbo].[prs_GetDate]
AS
select getdate() as fldDateTime,dbo.MiladiTOShamsi(getdate()) as fldTarikh ,CAST( cast(  GETDATE()as time (0)) AS NVARCHAR(8)) as fldTime,CAST(GETDATE() AS DATE) AS fldDate
GO
