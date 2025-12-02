SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [Com].[spr_CheckShomareSheba](@fldShomareSheba nvarchar(27))
as 
select com.fn_CheckShomareSheba(@fldShomareSheba) as CheckShomareSheba
GO
