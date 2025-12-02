CREATE TABLE [Drd].[tblShomareHesabCodeDaramad]
(
[fldId] [int] NOT NULL,
[fldShomareHesadId] [int] NOT NULL,
[fldCodeDaramadId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblShomareHesabCodeDaramad_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblShomareHesabCodeDaramad_fldDate] DEFAULT (getdate()),
[fldShorooshenaseGhabz] [tinyint] NOT NULL,
[fldFormolsaz] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldFormulKoliId] [int] NULL,
[fldFormulMohasebatId] [int] NULL,
[fldReportFileId] [int] NULL,
[fldSharhCodDaramd] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldStatus] [bit] NOT NULL CONSTRAINT [DF_tblShomareHesabCodeDaramad_fldStatus] DEFAULT ((1))
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblShomareHesabCodeDaramad] ADD CONSTRAINT [CK_tblShomareHesabCodeDaramad] CHECK (([fldShorooshenaseGhabz]>=(10) AND [fldShorooshenaseGhabz]<=(99)))
GO
ALTER TABLE [Drd].[tblShomareHesabCodeDaramad] ADD CONSTRAINT [CK_tblShomareHesabCodeDaramad_1] CHECK (([fldFormolsaz] IS NULL OR len([fldFormolsaz])>=(2)))
GO
ALTER TABLE [Drd].[tblShomareHesabCodeDaramad] ADD CONSTRAINT [CK_tblShomareHesabCodeDaramad_2] CHECK (([fldSharhCodDaramd] IS NULL OR len([fldSharhCodDaramd])>=(2)))
GO
ALTER TABLE [Drd].[tblShomareHesabCodeDaramad] ADD CONSTRAINT [PK_tblShomareHesabCodeDaramad] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblShomareHesabCodeDaramad] ADD CONSTRAINT [IX_tblShomareHesabCodeDaramad] UNIQUE NONCLUSTERED ([fldOrganId], [fldShomareHesadId], [fldCodeDaramadId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblShomareHesabCodeDaramad] ADD CONSTRAINT [FK_tblShomareHesabCodeDaramad_tblCodhayeDaramd] FOREIGN KEY ([fldCodeDaramadId]) REFERENCES [Drd].[tblCodhayeDaramd] ([fldId])
GO
ALTER TABLE [Drd].[tblShomareHesabCodeDaramad] ADD CONSTRAINT [FK_tblShomareHesabCodeDaramad_tblComputationFormula] FOREIGN KEY ([fldFormulKoliId]) REFERENCES [Com].[tblComputationFormula] ([fldId])
GO
ALTER TABLE [Drd].[tblShomareHesabCodeDaramad] ADD CONSTRAINT [FK_tblShomareHesabCodeDaramad_tblComputationFormula1] FOREIGN KEY ([fldFormulMohasebatId]) REFERENCES [Com].[tblComputationFormula] ([fldId])
GO
ALTER TABLE [Drd].[tblShomareHesabCodeDaramad] ADD CONSTRAINT [FK_tblShomareHesabCodeDaramad_tblFile] FOREIGN KEY ([fldReportFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [Drd].[tblShomareHesabCodeDaramad] ADD CONSTRAINT [FK_tblShomareHesabCodeDaramad_tblOrgan] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Drd].[tblShomareHesabCodeDaramad] ADD CONSTRAINT [FK_tblShomareHesabCodeDaramad_tblShomareHesabeOmoomi] FOREIGN KEY ([fldShomareHesadId]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
ALTER TABLE [Drd].[tblShomareHesabCodeDaramad] ADD CONSTRAINT [FK_tblShomareHesabCodeDaramad_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
