CREATE TABLE [Arch].[tblArchiveTree]
(
[fldId] [int] NOT NULL,
[fldPID] [int] NULL,
[fldTitle] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFileUpload] [bit] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblArchiveTree_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblArchiveTree_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NULL,
[fldModuleId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblArchiveTree] ADD CONSTRAINT [PK_tblArchiveTree] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblArchiveTree] ADD CONSTRAINT [IX_tblArchiveTree] UNIQUE NONCLUSTERED ([fldTitle], [fldPID], [fldModuleId], [fldOrganId]) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblArchiveTree] ADD CONSTRAINT [FK_tblArchiveTree_tblArchiveTree] FOREIGN KEY ([fldPID]) REFERENCES [Arch].[tblArchiveTree] ([fldId])
GO
ALTER TABLE [Arch].[tblArchiveTree] ADD CONSTRAINT [FK_tblArchiveTree_tblModule] FOREIGN KEY ([fldModuleId]) REFERENCES [Com].[tblModule] ([fldId])
GO
ALTER TABLE [Arch].[tblArchiveTree] ADD CONSTRAINT [FK_tblArchiveTree_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
