CREATE TABLE [Arch].[tblPropertiesValues]
(
[fldId] [int] NOT NULL,
[fldParticularId] [int] NOT NULL,
[fldValue] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFileContentId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPropertiesValues_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPropertiesValues_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblPropertiesValues] ADD CONSTRAINT [PK_tblPropertiesValues_1] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblPropertiesValues] ADD CONSTRAINT [FK_tblPropertiesValues_tblParticularProperties] FOREIGN KEY ([fldParticularId]) REFERENCES [Arch].[tblParticularProperties] ([fldId])
GO
ALTER TABLE [Arch].[tblPropertiesValues] ADD CONSTRAINT [FK_tblPropertiesValues_tblPropertiesValues] FOREIGN KEY ([fldFileContentId]) REFERENCES [Arch].[tblFileContent] ([fldId])
GO
ALTER TABLE [Arch].[tblPropertiesValues] ADD CONSTRAINT [FK_tblPropertiesValues_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
