CREATE TABLE [Auto].[tblLetterFileMojaz]
(
[fldId] [int] NOT NULL,
[fldFormatFileId] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblLetterFileMojaz_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblLetterFileMojaz_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL,
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldType] [tinyint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterFileMojaz] ADD CONSTRAINT [PK_tblLetterFileMojaz] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblLetterFileMojaz] ADD CONSTRAINT [FK_tblLetterFileMojaz_tblFormatFile] FOREIGN KEY ([fldFormatFileId]) REFERENCES [Com].[tblFormatFile] ([fldId])
GO
ALTER TABLE [Auto].[tblLetterFileMojaz] ADD CONSTRAINT [FK_tblLetterFileMojaz_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblLetterFileMojaz] ADD CONSTRAINT [FK_tblLetterFileMojaz_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
