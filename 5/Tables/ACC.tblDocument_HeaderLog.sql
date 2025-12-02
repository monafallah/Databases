CREATE TABLE [ACC].[tblDocument_HeaderLog]
(
[fldId] [int] NOT NULL,
[fldHeaderId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblDocument_HeaderLog] ADD CONSTRAINT [PK_tblDocument_HeaderLog] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblDocument_HeaderLog] ADD CONSTRAINT [FK_tblDocument_HeaderLog_tblDocumentRecord_Header1] FOREIGN KEY ([fldHeaderId]) REFERENCES [ACC].[tblDocumentRecord_Header1] ([fldId])
GO
ALTER TABLE [ACC].[tblDocument_HeaderLog] ADD CONSTRAINT [FK_tblDocument_HeaderLog_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
