CREATE TABLE [ACC].[tblDocumentRecord_Header1]
(
[fldId] [int] NOT NULL,
[fldDocument_HedearId] [int] NOT NULL,
[fldDocumentNum] [int] NOT NULL,
[fldArchiveNum] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldTarikhDocument] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAccept] [tinyint] NOT NULL,
[fldModuleSaveId] [int] NULL,
[fldModuleErsalId] [int] NULL,
[fldShomareFaree] [int] NULL,
[fldPId] [int] NULL,
[fldTypeSanadId] [int] NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblDocumentRecord_Header1_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldEdit] [tinyint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblDocumentRecord_Header1] ADD CONSTRAINT [PK_tblDocumentRecord_Header_Details] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblDocumentRecord_Header1] ON [ACC].[tblDocumentRecord_Header1] ([fldModuleSaveId], [fldDocumentNum], [fldTarikhDocument]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblDocumentRecord_Header1] ADD CONSTRAINT [FK_tblDocumentRecord_Header1_tblDocumentRecord_Header] FOREIGN KEY ([fldDocument_HedearId]) REFERENCES [ACC].[tblDocumentRecord_Header] ([fldId])
GO
ALTER TABLE [ACC].[tblDocumentRecord_Header1] ADD CONSTRAINT [FK_tblDocumentRecord_Header1_tblDocumentRecord_Header11] FOREIGN KEY ([fldPId]) REFERENCES [ACC].[tblDocumentRecord_Header1] ([fldId])
GO
ALTER TABLE [ACC].[tblDocumentRecord_Header1] ADD CONSTRAINT [FK_tblDocumentRecord_Header1_tblDocumentType] FOREIGN KEY ([fldTypeSanadId]) REFERENCES [ACC].[tblDocumentType] ([fldId])
GO
ALTER TABLE [ACC].[tblDocumentRecord_Header1] ADD CONSTRAINT [FK_tblDocumentRecord_Header1_tblModule] FOREIGN KEY ([fldModuleErsalId]) REFERENCES [Com].[tblModule] ([fldId])
GO
ALTER TABLE [ACC].[tblDocumentRecord_Header1] ADD CONSTRAINT [FK_tblDocumentRecord_Header1_tblModule1] FOREIGN KEY ([fldModuleSaveId]) REFERENCES [Com].[tblModule] ([fldId])
GO
ALTER TABLE [ACC].[tblDocumentRecord_Header1] ADD CONSTRAINT [FK_tblDocumentRecord_Header1_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
