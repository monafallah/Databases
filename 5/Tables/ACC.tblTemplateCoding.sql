CREATE TABLE [ACC].[tblTemplateCoding]
(
[fldId] [int] NOT NULL,
[fldTempCodeId] [sys].[hierarchyid] NOT NULL,
[fldLevelId] AS ([fldTempCodeId].[GetLevel]()),
[fldStrhid] AS ([fldTempCodeId].[ToString]()),
[fldItemId] [int] NULL,
[fldName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPCod] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldMahiyatId] [int] NULL,
[fldCode] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTempNameId] [int] NULL,
[fldLevelsAccountTypId] [int] NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTemplateCoding_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTemplateCoding_fldDate] DEFAULT (getdate()),
[fldIp] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldTypeHesabId] [tinyint] NOT NULL,
[fldCodeBudget] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldAddChildNode] [bit] NULL,
[fldMahiyat_GardeshId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblTemplateCoding] ADD CONSTRAINT [PK_tblTemplateCoding] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblTemplateCoding] ADD CONSTRAINT [IX_tblTemplateCoding] UNIQUE NONCLUSTERED ([fldCode], [fldTempNameId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblTemplateCoding_1] ON [ACC].[tblTemplateCoding] ([fldTempNameId], [fldLevelId], [fldItemId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblTemplateCoding] ADD CONSTRAINT [FK_tblTemplateCoding_tblItemNecessary] FOREIGN KEY ([fldItemId]) REFERENCES [ACC].[tblItemNecessary] ([fldId])
GO
ALTER TABLE [ACC].[tblTemplateCoding] ADD CONSTRAINT [FK_tblTemplateCoding_tblLevelsAccountingType] FOREIGN KEY ([fldLevelsAccountTypId]) REFERENCES [ACC].[tblLevelsAccountingType] ([fldId])
GO
ALTER TABLE [ACC].[tblTemplateCoding] ADD CONSTRAINT [FK_tblTemplateCoding_tblMahiyat] FOREIGN KEY ([fldMahiyatId]) REFERENCES [ACC].[tblMahiyat] ([fldId])
GO
ALTER TABLE [ACC].[tblTemplateCoding] ADD CONSTRAINT [FK_tblTemplateCoding_tblMahiyat1] FOREIGN KEY ([fldMahiyat_GardeshId]) REFERENCES [ACC].[tblMahiyat] ([fldId])
GO
ALTER TABLE [ACC].[tblTemplateCoding] ADD CONSTRAINT [FK_tblTemplateCoding_tblTemplateName] FOREIGN KEY ([fldTempNameId]) REFERENCES [ACC].[tblTemplateName] ([fldId])
GO
ALTER TABLE [ACC].[tblTemplateCoding] ADD CONSTRAINT [FK_tblTemplateCoding_tblTypeHesab] FOREIGN KEY ([fldTypeHesabId]) REFERENCES [ACC].[tblTypeHesab] ([fldId])
GO
ALTER TABLE [ACC].[tblTemplateCoding] ADD CONSTRAINT [FK_tblTemplateCoding_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
