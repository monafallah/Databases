CREATE TABLE [Auto].[tblSecurityType]
(
[fldID] [int] NOT NULL,
[fldSecurityType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganID] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblSecurityType_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSecurityType_fldDesc] DEFAULT (''),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblSecurityType] ADD CONSTRAINT [PK_tblSecurityType] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblSecurityType] ADD CONSTRAINT [FK_tblSecurityType_tblOrganization] FOREIGN KEY ([fldOrganID]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblSecurityType] ADD CONSTRAINT [FK_tblSecurityType_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
