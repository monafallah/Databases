CREATE TABLE [Auto].[tblSecretariat_OrganizationUnit]
(
[fldID] [int] NOT NULL,
[fldSecretariatID] [int] NOT NULL,
[fldOrganizationUnitID] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblSecretariat_OrganizationUnit_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_tblSecretariat_OrganizationUnit_fldDesc] DEFAULT (''),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldOrganId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblSecretariat_OrganizationUnit] ADD CONSTRAINT [PK_tblSecretariat_OrganizationUnit] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblSecretariat_OrganizationUnit] ADD CONSTRAINT [IX_tblSecretariat_OrganizationUnit] UNIQUE NONCLUSTERED ([fldOrganId], [fldSecretariatID], [fldOrganizationUnitID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblSecretariat_OrganizationUnit] ADD CONSTRAINT [FK_tblSecretariat_OrganizationUnit_tblChartOrganEjraee] FOREIGN KEY ([fldOrganizationUnitID]) REFERENCES [Com].[tblChartOrganEjraee] ([fldId])
GO
ALTER TABLE [Auto].[tblSecretariat_OrganizationUnit] ADD CONSTRAINT [FK_tblSecretariat_OrganizationUnit_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblSecretariat_OrganizationUnit] ADD CONSTRAINT [FK_tblSecretariat_OrganizationUnit_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
