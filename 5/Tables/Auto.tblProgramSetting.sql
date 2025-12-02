CREATE TABLE [Auto].[tblProgramSetting]
(
[fldID] [int] NOT NULL,
[fldEmailAddress] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldEmailPassword] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldRecieveServer] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldSendServer] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldSendPort] [int] NOT NULL,
[fldSSL] [bit] NOT NULL,
[fldDelFax] [bit] NOT NULL,
[fldIsSigner] [bit] NOT NULL,
[fldFaxPath] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganID] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblSetting_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSetting_fldDesc] DEFAULT (''),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldRecievePort] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblProgramSetting] ADD CONSTRAINT [CK_tblSetting_1] CHECK ((len([fldEmailAddress])>=(5)))
GO
ALTER TABLE [Auto].[tblProgramSetting] ADD CONSTRAINT [PK_tblSetting_1] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblProgramSetting] ADD CONSTRAINT [FK_tblSetting_tblOrganization] FOREIGN KEY ([fldOrganID]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblProgramSetting] ADD CONSTRAINT [FK_tblSetting_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
