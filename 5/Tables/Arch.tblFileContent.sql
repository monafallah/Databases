CREATE TABLE [Arch].[tblFileContent]
(
[fldId] [int] NOT NULL,
[fldFileContent] [varbinary] (max) NULL,
[fldFileFormatId] [int] NOT NULL,
[fldPrsPesonalId] [int] NULL,
[fldTreeId] [int] NOT NULL,
[fldWebRef] [uniqueidentifier] NOT NULL,
[fldTemp] [bigint] NOT NULL,
[fldDeleted] [bigint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFiles_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFiles_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblFileContent] ADD CONSTRAINT [PK_tblFiles] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblFileContent] ADD CONSTRAINT [FK_tblFileContent_Prs_tblPersonalInfo] FOREIGN KEY ([fldPrsPesonalId]) REFERENCES [Prs].[Prs_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Arch].[tblFileContent] ADD CONSTRAINT [FK_tblFileContent_tblArchiveTree] FOREIGN KEY ([fldTreeId]) REFERENCES [Arch].[tblArchiveTree] ([fldId])
GO
ALTER TABLE [Arch].[tblFileContent] ADD CONSTRAINT [FK_tblFileContent_tblFileContent] FOREIGN KEY ([fldFileFormatId]) REFERENCES [Arch].[tblFormatFile] ([fldId])
GO
ALTER TABLE [Arch].[tblFileContent] ADD CONSTRAINT [FK_tblFileContent_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
