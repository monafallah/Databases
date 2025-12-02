CREATE TABLE [ACC].[tblDocumentBookMark]
(
[fldId] [int] NOT NULL,
[fldDocumentRecordeId] [int] NOT NULL,
[fldArchiveTreeId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblDocumentBookMark_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblDocumentBookMark_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblDocumentBookMark] ADD CONSTRAINT [PK_tblDocumentBookMark] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblDocumentBookMark] ADD CONSTRAINT [FK_tblDocumentBookMark_tblArchiveTree] FOREIGN KEY ([fldArchiveTreeId]) REFERENCES [Arch].[tblArchiveTree] ([fldId])
GO
ALTER TABLE [ACC].[tblDocumentBookMark] ADD CONSTRAINT [FK_tblDocumentBookMark_tblDocumentRecorde] FOREIGN KEY ([fldDocumentRecordeId]) REFERENCES [ACC].[tblDocumentRecorde_File] ([fldId])
GO
ALTER TABLE [ACC].[tblDocumentBookMark] ADD CONSTRAINT [FK_tblDocumentBookMark_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [ACC].[tblDocumentBookMark] ADD CONSTRAINT [FK_tblDocumentBookMark_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
