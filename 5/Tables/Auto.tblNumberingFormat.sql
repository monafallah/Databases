CREATE TABLE [Auto].[tblNumberingFormat]
(
[fldID] [int] NOT NULL,
[fldYear] [int] NOT NULL,
[fldSecretariatID] [int] NOT NULL,
[fldNumberFormat] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldStartNumber] [int] NOT NULL,
[fldOrganID] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblNumberingFormat_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblNumberingFormat_fldDesc] DEFAULT (''),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblNumberingFormat] ADD CONSTRAINT [PK_tblNumberingFormat] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblNumberingFormat] ADD CONSTRAINT [IX_tblNumberingFormat] UNIQUE NONCLUSTERED ([fldSecretariatID], [fldYear]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblNumberingFormat] ADD CONSTRAINT [FK_tblNumberingFormat_tblOrganization] FOREIGN KEY ([fldOrganID]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblNumberingFormat] ADD CONSTRAINT [FK_tblNumberingFormat_tblSecretariat_OrganizationUnit] FOREIGN KEY ([fldSecretariatID]) REFERENCES [Auto].[tblSecretariat_OrganizationUnit] ([fldID])
GO
ALTER TABLE [Auto].[tblNumberingFormat] ADD CONSTRAINT [FK_tblNumberingFormat_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
