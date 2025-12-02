CREATE TABLE [ACC].[tblCoding_Details]
(
[fldId] [int] NOT NULL,
[fldCodeId] [sys].[hierarchyid] NOT NULL,
[fldLevelId] AS ([fldCodeId].[GetLevel]()),
[fldStrhid] AS ([fldCodeId].[ToString]()),
[fldHeaderCodId] [int] NULL,
[fldPCod] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldTempCodingId] [int] NULL,
[fldTitle] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldCode] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAccountLevelId] [int] NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCoding_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCoding_fldDate] DEFAULT (getdate()),
[fldIp] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldMahiyatId] [int] NULL,
[fldTypeHesabId] [tinyint] NOT NULL,
[fldDaramadCode] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldMahiyat_GardeshId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCoding_Details] ADD CONSTRAINT [PK_tblCoding] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblCoding_Details] ON [ACC].[tblCoding_Details] ([fldAccountLevelId] DESC) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblCoding_Details_1] ON [ACC].[tblCoding_Details] ([fldCodeId], [fldHeaderCodId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblCoding_Details_2] ON [ACC].[tblCoding_Details] ([fldDaramadCode], [fldHeaderCodId], [fldCodeId]) INCLUDE ([fldTempCodingId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCoding_Details] ADD CONSTRAINT [IX_tblCoding_Details_3] UNIQUE NONCLUSTERED ([fldHeaderCodId], [fldCode]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCoding_Details] ADD CONSTRAINT [FK_tblCoding_Details_tblAccountingLevel] FOREIGN KEY ([fldAccountLevelId]) REFERENCES [ACC].[tblAccountingLevel] ([fldId])
GO
ALTER TABLE [ACC].[tblCoding_Details] ADD CONSTRAINT [FK_tblCoding_Details_tblCoding_Header] FOREIGN KEY ([fldHeaderCodId]) REFERENCES [ACC].[tblCoding_Header] ([fldId])
GO
ALTER TABLE [ACC].[tblCoding_Details] ADD CONSTRAINT [FK_tblCoding_Details_tblMahiyat] FOREIGN KEY ([fldMahiyatId]) REFERENCES [ACC].[tblMahiyat] ([fldId])
GO
ALTER TABLE [ACC].[tblCoding_Details] ADD CONSTRAINT [FK_tblCoding_Details_tblMahiyat1] FOREIGN KEY ([fldMahiyat_GardeshId]) REFERENCES [ACC].[tblMahiyat] ([fldId])
GO
ALTER TABLE [ACC].[tblCoding_Details] ADD CONSTRAINT [FK_tblCoding_Details_tblTemplateCoding] FOREIGN KEY ([fldTempCodingId]) REFERENCES [ACC].[tblTemplateCoding] ([fldId])
GO
ALTER TABLE [ACC].[tblCoding_Details] ADD CONSTRAINT [FK_tblCoding_Details_tblTypeHesab] FOREIGN KEY ([fldTypeHesabId]) REFERENCES [ACC].[tblTypeHesab] ([fldId])
GO
ALTER TABLE [ACC].[tblCoding_Details] ADD CONSTRAINT [FK_tblCoding_Details_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
