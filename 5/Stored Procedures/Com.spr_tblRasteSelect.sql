SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Com].[spr_tblRasteSelect]
@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
as
if(@fieldname='')
	SELECT        fldId, fldCode,Com.fn_TextNormalize( fldText) as fldText, fldIndex,fldMaliyat
	FROM            Com.tblRaste

if(@fieldname='fldText')
	SELECT        fldId, fldCode,Com.fn_TextNormalize( fldText) as fldText, fldIndex,fldMaliyat
	FROM            Com.tblRaste
	where Com.fn_TextNormalize( fldText)=Com.fn_TextNormalize( @Value)
GO
