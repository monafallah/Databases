CREATE TABLE [Pay].[tblShomareHesabPasAndaz]
(
[fldId] [int] NOT NULL,
[fldShomareHesabPersonalId] [int] NOT NULL,
[fldShomareHesabKarfarmaId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblShomareHesabPasAndaz_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblShomareHesabPasAndaz_fldDesc] DEFAULT ('')
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblShomareHesabPasAndaz] ADD CONSTRAINT [PK_tblShomareHesabPasAndaz] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblShomareHesabPasAndaz] ADD CONSTRAINT [FK_tblShomareHesabPasAndaz_tblShomareHesabeOmoomi] FOREIGN KEY ([fldShomareHesabKarfarmaId]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
ALTER TABLE [Pay].[tblShomareHesabPasAndaz] ADD CONSTRAINT [FK_tblShomareHesabPasAndaz_tblShomareHesabeOmoomi1] FOREIGN KEY ([fldShomareHesabPersonalId]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
ALTER TABLE [Pay].[tblShomareHesabPasAndaz] ADD CONSTRAINT [FK_tblShomareHesabPasAndaz_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
