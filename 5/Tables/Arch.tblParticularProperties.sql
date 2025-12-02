CREATE TABLE [Arch].[tblParticularProperties]
(
[fldId] [int] NOT NULL,
[fldArchiveTreeId] [int] NOT NULL,
[fldPropertiesId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblParticularProperties_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblParticularProperties_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblParticularProperties] ADD CONSTRAINT [PK_tblParticularProperties] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblParticularProperties] ADD CONSTRAINT [IX_tblParticularProperties] UNIQUE NONCLUSTERED ([fldArchiveTreeId], [fldPropertiesId]) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblParticularProperties] ADD CONSTRAINT [FK_tblParticularProperties_tblArchiveTree] FOREIGN KEY ([fldArchiveTreeId]) REFERENCES [Arch].[tblArchiveTree] ([fldId])
GO
ALTER TABLE [Arch].[tblParticularProperties] ADD CONSTRAINT [FK_tblParticularProperties_tblProperties] FOREIGN KEY ([fldPropertiesId]) REFERENCES [Arch].[tblProperties] ([fldId])
GO
ALTER TABLE [Arch].[tblParticularProperties] ADD CONSTRAINT [FK_tblParticularProperties_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
