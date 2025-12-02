CREATE TABLE [ACC].[tblItemNecessary]
(
[fldId] [int] NOT NULL,
[fldItemId] [sys].[hierarchyid] NOT NULL,
[fldLevelId] AS ([fldItemId].[GetLevel]()),
[fldStrhid] AS ([fldItemId].[ToString]()),
[fldNameItem] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMahiyatId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblItemNecessary_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblItemNecessary_fldDate] DEFAULT (getdate()),
[fldIp] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldTypeHesabId] [tinyint] NOT NULL,
[fldMahiyat_GardeshId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblItemNecessary] ADD CONSTRAINT [PK_tblItemNecessary] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblItemNecessary] ADD CONSTRAINT [IX_tblItemNecessary] UNIQUE NONCLUSTERED ([fldNameItem]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblItemNecessary] ADD CONSTRAINT [FK_tblItemNecessary_tblMahiyat] FOREIGN KEY ([fldMahiyatId]) REFERENCES [ACC].[tblMahiyat] ([fldId])
GO
ALTER TABLE [ACC].[tblItemNecessary] ADD CONSTRAINT [FK_tblItemNecessary_tblMahiyat1] FOREIGN KEY ([fldMahiyat_GardeshId]) REFERENCES [ACC].[tblMahiyat] ([fldId])
GO
ALTER TABLE [ACC].[tblItemNecessary] ADD CONSTRAINT [FK_tblItemNecessary_tblTypeHesab] FOREIGN KEY ([fldTypeHesabId]) REFERENCES [ACC].[tblTypeHesab] ([fldId])
GO
ALTER TABLE [ACC].[tblItemNecessary] ADD CONSTRAINT [FK_tblItemNecessary_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
