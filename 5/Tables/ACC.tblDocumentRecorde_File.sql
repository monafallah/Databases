CREATE TABLE [ACC].[tblDocumentRecorde_File]
(
[fldId] [int] NOT NULL,
[fldDocumentHeaderId] [int] NOT NULL,
[fldFileId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblDocumentRecorde_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblDocumentRecorde_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblDocumentRecorde_File] ADD CONSTRAINT [PK_tblDocumentRecorde] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblDocumentRecorde_File] ADD CONSTRAINT [FK_tblDocumentRecorde_tblDocumentRecord_Header] FOREIGN KEY ([fldDocumentHeaderId]) REFERENCES [ACC].[tblDocumentRecord_Header] ([fldId])
GO
ALTER TABLE [ACC].[tblDocumentRecorde_File] ADD CONSTRAINT [FK_tblDocumentRecorde_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [ACC].[tblDocumentRecorde_File] ADD CONSTRAINT [FK_tblDocumentRecorde_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
