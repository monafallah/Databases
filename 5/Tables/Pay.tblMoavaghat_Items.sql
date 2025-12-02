CREATE TABLE [Pay].[tblMoavaghat_Items]
(
[fldId] [int] NOT NULL,
[fldMoavaghatId] [int] NOT NULL,
[fldItemEstekhdamId] [int] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMoavaghat_Items_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMoavaghat_Items_fldDate] DEFAULT (getdate()),
[fldBimeMashmool] [bit] NULL,
[fldMaliyatMashmool] [bit] NULL,
[fldHesabTypeItemId] [tinyint] NULL,
[fldShomareHesabItemId] [int] NULL,
[fldSourceId] [int] NULL,
[fldMostamar] [tinyint] NULL CONSTRAINT [DF_tblMoavaghat_Items_fldIsMostamar] DEFAULT ((0))
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMoavaghat_Items] ADD CONSTRAINT [PK_tblMoavaghat_Items] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
CREATE NONCLUSTERED INDEX [IX_tblMoavaghat_Items] ON [Pay].[tblMoavaghat_Items] ([fldMoavaghatId], [fldHesabTypeItemId], [fldMostamar]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [DiskeyMaliyat] ON [Pay].[tblMoavaghat_Items] ([fldMoavaghatId], [fldMostamar], [fldHesabTypeItemId]) INCLUDE ([fldMablagh]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMoavaghat_Items] ADD CONSTRAINT [FK_tblMoavaghat_Items_Pay_tblMoavaghat] FOREIGN KEY ([fldMoavaghatId]) REFERENCES [Pay].[tblMoavaghat] ([fldId])
GO
ALTER TABLE [Pay].[tblMoavaghat_Items] ADD CONSTRAINT [FK_tblMoavaghat_Items_tblItems_Estekhdam] FOREIGN KEY ([fldItemEstekhdamId]) REFERENCES [Com].[tblItems_Estekhdam] ([fldId])
GO
ALTER TABLE [Pay].[tblMoavaghat_Items] ADD CONSTRAINT [FK_tblMoavaghat_Items_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
