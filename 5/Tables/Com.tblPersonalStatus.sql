CREATE TABLE [Com].[tblPersonalStatus]
(
[fldId] [int] NOT NULL,
[fldStatusId] [int] NOT NULL,
[fldPrsPersonalInfoId] [int] NULL,
[fldPayPersonalInfoId] [int] NULL,
[fldDateTaghirVaziyat] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPersonalStatus_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPersonalStatus_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblPersonalStatus] ADD CONSTRAINT [PK_tblPersonalStatus] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblPersonalStatus] ADD CONSTRAINT [IX_tblPersonalStatus] UNIQUE NONCLUSTERED ([fldStatusId], [fldPayPersonalInfoId], [fldPrsPersonalInfoId], [fldDateTaghirVaziyat]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblPersonalStatus] ADD CONSTRAINT [FK_tblPersonalStatus_Pay_tblPersonalInfo] FOREIGN KEY ([fldPayPersonalInfoId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Com].[tblPersonalStatus] ADD CONSTRAINT [FK_tblPersonalStatus_Prs_tblPersonalInfo] FOREIGN KEY ([fldPrsPersonalInfoId]) REFERENCES [Prs].[Prs_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Com].[tblPersonalStatus] ADD CONSTRAINT [FK_tblPersonalStatus_tblStatus] FOREIGN KEY ([fldStatusId]) REFERENCES [Com].[tblStatus] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Com].[tblPersonalStatus] ADD CONSTRAINT [FK_tblPersonalStatus_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
