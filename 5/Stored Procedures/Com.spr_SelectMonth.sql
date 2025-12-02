SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE  PROC [Com].[spr_SelectMonth]
AS
SELECT
 FORMAT(number,'0#')fldCode,
 com.fn_month(number)fldName
FROM master..spt_values
WHERE Type = 'P' and number between 1 and 12
ORDER BY Number
GO
