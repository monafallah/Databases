CREATE TABLE [Drd].[tblMahdoodiyatMohasebat_ShomareHesabDaramad]
(
[fldId] [int] NOT NULL,
[fldMahdodiyatMohasebatId] [int] NOT NULL,
[fldShomarehesabDarmadId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMahdoodiyatMohasebat_ShomareHesabDaramad_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMahdoodiyatMohasebat_ShomareHesabDaramad_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblMahdoodiyatMohasebat_ShomareHesabDaramad] ADD CONSTRAINT [PK_tblMahdoodiyatMohasebat_ShomareHesabDaramad] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblMahdoodiyatMohasebat_ShomareHesabDaramad] ADD CONSTRAINT [FK_tblMahdoodiyatMohasebat_ShomareHesabDaramad_tblMahdoodiyatMohasebat] FOREIGN KEY ([fldMahdodiyatMohasebatId]) REFERENCES [Drd].[tblMahdoodiyatMohasebat] ([fldId])
GO
ALTER TABLE [Drd].[tblMahdoodiyatMohasebat_ShomareHesabDaramad] ADD CONSTRAINT [FK_tblMahdoodiyatMohasebat_ShomareHesabDaramad_tblShomareHesabCodeDaramad] FOREIGN KEY ([fldShomarehesabDarmadId]) REFERENCES [Drd].[tblShomareHesabCodeDaramad] ([fldId])
GO
ALTER TABLE [Drd].[tblMahdoodiyatMohasebat_ShomareHesabDaramad] ADD CONSTRAINT [FK_tblMahdoodiyatMohasebat_ShomareHesabDaramad_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
