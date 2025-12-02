CREATE TABLE [Drd].[tblGozareshatFile]
(
[fldId] [int] NOT NULL,
[fldGozareshatId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldReportFileId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblGozareshatFile_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblGozareshatFile_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblGozareshatFile] ADD CONSTRAINT [PK_tblGozareshatFile] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblGozareshatFile] ADD CONSTRAINT [FK_tblGozareshatFile_tblFile] FOREIGN KEY ([fldReportFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [Drd].[tblGozareshatFile] ADD CONSTRAINT [FK_tblGozareshatFile_tblGozareshat] FOREIGN KEY ([fldGozareshatId]) REFERENCES [Drd].[tblGozareshat] ([fldId])
GO
ALTER TABLE [Drd].[tblGozareshatFile] ADD CONSTRAINT [FK_tblGozareshatFile_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Drd].[tblGozareshatFile] ADD CONSTRAINT [FK_tblGozareshatFile_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
