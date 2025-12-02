CREATE TABLE [Auto].[tblImmediacy]
(
[fldID] [int] NOT NULL,
[fldName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFileId] [int] NOT NULL,
[fldOrganID] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblImmediacy_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblImmediacy_fldDesc] DEFAULT (''),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblImmediacy] ADD CONSTRAINT [CK_tblImmediacy] CHECK ((len([fldName])>=(2)))
GO
ALTER TABLE [Auto].[tblImmediacy] ADD CONSTRAINT [PK_tblImmediacy] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblImmediacy] ADD CONSTRAINT [FK_tblImmediacy_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [Auto].[tblImmediacy] ADD CONSTRAINT [FK_tblImmediacy_tblOrganization] FOREIGN KEY ([fldOrganID]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblImmediacy] ADD CONSTRAINT [FK_tblImmediacy_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
