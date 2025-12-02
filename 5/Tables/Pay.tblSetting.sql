CREATE TABLE [Pay].[tblSetting]
(
[fldId] [int] NOT NULL,
[fldH_BankFixId] [int] NULL,
[fldH_NameShobe] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldH_CodeOrgan] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldH_CodeShobe] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShowBankLogo] [bit] NULL,
[fldOrganId] [int] NOT NULL,
[fldCodeEghtesadi] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPrs_PersonalId] [int] NULL,
[fldCodeParvande] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldCodeOrganPasAndaz] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldSh_HesabCheckId] [int] NULL,
[fldB_BankFixId] [int] NULL,
[fldB_NameShobe] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldB_ShomareHesabId] [int] NULL,
[fldB_CodeShenasaee] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldCodeDastgah] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSetting_fldCodeDastgah] DEFAULT (''),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSetting_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblSetting_fldDate] DEFAULT (getdate()),
[fldP_BankFixId] [int] NULL,
[fldP_ShobeId] [int] NULL,
[fldStatusMahalKedmatId] [tinyint] NOT NULL CONSTRAINT [DF_tblSetting_fldStatusMahalKedmat_1] DEFAULT ((1))
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblSetting] ADD CONSTRAINT [PK_tblSetting] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblSetting] ADD CONSTRAINT [FK_tblSetting_Pay_tblBank] FOREIGN KEY ([fldB_BankFixId]) REFERENCES [Com].[tblBank] ([fldId])
GO
ALTER TABLE [Pay].[tblSetting] ADD CONSTRAINT [FK_tblSetting_Pay_tblBank1] FOREIGN KEY ([fldH_BankFixId]) REFERENCES [Com].[tblBank] ([fldId])
GO
ALTER TABLE [Pay].[tblSetting] ADD CONSTRAINT [FK_tblSetting_Prs_tblPersonalInfo] FOREIGN KEY ([fldPrs_PersonalId]) REFERENCES [Prs].[Prs_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Pay].[tblSetting] ADD CONSTRAINT [FK_tblSetting_tblBank] FOREIGN KEY ([fldP_BankFixId]) REFERENCES [Com].[tblBank] ([fldId])
GO
ALTER TABLE [Pay].[tblSetting] ADD CONSTRAINT [FK_tblSetting_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Pay].[tblSetting] ADD CONSTRAINT [FK_tblSetting_tblSHobe] FOREIGN KEY ([fldP_ShobeId]) REFERENCES [Com].[tblSHobe] ([fldId])
GO
ALTER TABLE [Pay].[tblSetting] ADD CONSTRAINT [FK_tblSetting_tblShomareHesabeOmoomi] FOREIGN KEY ([fldB_ShomareHesabId]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
ALTER TABLE [Pay].[tblSetting] ADD CONSTRAINT [FK_tblSetting_tblShomareHesabeOmoomi1] FOREIGN KEY ([fldSh_HesabCheckId]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
ALTER TABLE [Pay].[tblSetting] ADD CONSTRAINT [FK_tblSetting_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
