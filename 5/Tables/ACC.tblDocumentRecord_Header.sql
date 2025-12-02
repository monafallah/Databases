CREATE TABLE [ACC].[tblDocumentRecord_Header]
(
[fldId] [int] NOT NULL,
[fldDescriptionDocu] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblDocumentRecord_Header_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblDocumentRecord_Header_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldYear] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldType] [tinyint] NULL,
[fldFiscalYearId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblDocumentRecord_Header] ADD CONSTRAINT [PK_tblDocumentRecord_Header] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblDocumentRecord_Header] ON [ACC].[tblDocumentRecord_Header] ([fldYear], [fldOrganId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblDocumentRecord_Header] ADD CONSTRAINT [FK_tblDocumentRecord_Header_tblFiscalYear] FOREIGN KEY ([fldFiscalYearId]) REFERENCES [ACC].[tblFiscalYear] ([fldId])
GO
ALTER TABLE [ACC].[tblDocumentRecord_Header] ADD CONSTRAINT [FK_tblDocumentRecord_Header_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [ACC].[tblDocumentRecord_Header] ADD CONSTRAINT [FK_tblDocumentRecord_Header_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
