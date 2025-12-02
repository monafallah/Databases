CREATE TABLE [Pay].[tblMohasebat_ItemMotamam]
(
[fldId] [int] NOT NULL,
[fldMohasebatId] [int] NOT NULL,
[fldItemEstekhdamId] [int] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldBimeMashmool] [bit] NULL,
[fldMaliyatMashmool] [bit] NULL,
[fldSourceId] [int] NULL,
[fldHesabTypeItemId] [tinyint] NULL,
[fldShomareHesabItemId] [int] NULL,
[fldMostamar] [tinyint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMohasebat_ItemMotamam] ADD CONSTRAINT [PK_tblMohasebat_ItemMotamam_1] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMohasebat_ItemMotamam] ADD CONSTRAINT [FK_tblMohasebat_ItemMotamam_tblHesabType1] FOREIGN KEY ([fldHesabTypeItemId]) REFERENCES [Com].[tblHesabType] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_ItemMotamam] ADD CONSTRAINT [FK_tblMohasebat_ItemMotamam_tblItems_Estekhdam1] FOREIGN KEY ([fldItemEstekhdamId]) REFERENCES [Com].[tblItems_Estekhdam] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_ItemMotamam] ADD CONSTRAINT [FK_tblMohasebat_ItemMotamam_tblMohasebat1] FOREIGN KEY ([fldMohasebatId]) REFERENCES [Pay].[tblMohasebat] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_ItemMotamam] ADD CONSTRAINT [FK_tblMohasebat_ItemMotamam_tblShomareHesabeOmoomi] FOREIGN KEY ([fldShomareHesabItemId]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
