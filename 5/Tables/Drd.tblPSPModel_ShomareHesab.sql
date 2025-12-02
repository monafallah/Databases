CREATE TABLE [Drd].[tblPSPModel_ShomareHesab]
(
[fldId] [int] NOT NULL,
[fldPSPModelId] [int] NOT NULL,
[fldShHesabId] [int] NOT NULL,
[fldOrder] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPSPModel_ShomareHesab_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPSPModel_ShomareHesab_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPSPModel_ShomareHesab] ADD CONSTRAINT [PK_tblPSPModel_ShomareHesab] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblPSPModel_ShomareHesab] ADD CONSTRAINT [FK_tblPSPModel_ShomareHesab_tblPspModel] FOREIGN KEY ([fldPSPModelId]) REFERENCES [Drd].[tblPspModel] ([fldId])
GO
ALTER TABLE [Drd].[tblPSPModel_ShomareHesab] ADD CONSTRAINT [FK_tblPSPModel_ShomareHesab_tblShomareHesabeOmoomi] FOREIGN KEY ([fldShHesabId]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
