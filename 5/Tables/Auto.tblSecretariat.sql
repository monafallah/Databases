CREATE TABLE [Auto].[tblSecretariat]
(
[fldID] [int] NOT NULL,
[fldChartOrganEjraeeId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCentralSecretariat_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCentralSecretariat_fldDesc] DEFAULT (''),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblSecretariat] ADD CONSTRAINT [PK_tblCentralSecretariat] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblSecretariat] ADD CONSTRAINT [FK_tblSecretariat_tblChartOrganEjraee] FOREIGN KEY ([fldChartOrganEjraeeId]) REFERENCES [Com].[tblChartOrganEjraee] ([fldId])
GO
ALTER TABLE [Auto].[tblSecretariat] ADD CONSTRAINT [FK_tblSecretariat_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblSecretariat] ADD CONSTRAINT [FK_tblSecretariat_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
