CREATE TABLE [Pay].[tblMohasebat_Items]
(
[fldId] [int] NOT NULL,
[fldMohasebatId] [int] NOT NULL,
[fldItemEstekhdamId] [int] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMohasebat_Items_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMohasebat_Items_fldDate] DEFAULT (getdate()),
[fldBimeMashmool] [bit] NULL,
[fldMaliyatMashmool] [bit] NULL,
[fldSourceId] [int] NULL,
[fldHesabTypeItemId] [tinyint] NULL,
[fldShomareHesabItemId] [int] NULL,
[fldMostamar] [tinyint] NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMohasebat_Items] ADD CONSTRAINT [PK_tblMohasebat_Items] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
CREATE NONCLUSTERED INDEX [IxfldMohasebatId] ON [Pay].[tblMohasebat_Items] ([fldMohasebatId]) INCLUDE ([fldItemEstekhdamId]) ON [PayRoll]
GO
CREATE NONCLUSTERED INDEX [IX_tblMohasebat_Items] ON [Pay].[tblMohasebat_Items] ([fldMohasebatId], [fldHesabTypeItemId], [fldMostamar]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMohasebat_Items] ADD CONSTRAINT [FK_tblMohasebat_Items_Pay_tblMohasebat] FOREIGN KEY ([fldMohasebatId]) REFERENCES [Pay].[tblMohasebat] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Pay].[tblMohasebat_Items] ADD CONSTRAINT [FK_tblMohasebat_Items_tblHesabType] FOREIGN KEY ([fldHesabTypeItemId]) REFERENCES [Com].[tblHesabType] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_Items] ADD CONSTRAINT [FK_tblMohasebat_Items_tblItems_Estekhdam] FOREIGN KEY ([fldItemEstekhdamId]) REFERENCES [Com].[tblItems_Estekhdam] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_Items] ADD CONSTRAINT [FK_tblMohasebat_Items_tblShomareHesabeOmoomi] FOREIGN KEY ([fldShomareHesabItemId]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_Items] ADD CONSTRAINT [FK_tblMohasebat_Items_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
