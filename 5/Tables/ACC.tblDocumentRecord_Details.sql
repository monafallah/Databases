CREATE TABLE [ACC].[tblDocumentRecord_Details]
(
[fldId] [int] NOT NULL,
[fldDocument_HedearId] [int] NOT NULL,
[fldDocument_HedearId1] [int] NULL,
[fldCodingId] [int] NOT NULL,
[fldDescription] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldBedehkar] [bigint] NOT NULL,
[fldBestankar] [bigint] NOT NULL,
[fldCenterCoId] [int] NULL,
[fldCaseId] [int] NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblDocumentRecord_Details_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblDocumentRecord_Details_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrder] [smallint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblDocumentRecord_Details] ADD CONSTRAINT [PK_tblDocumentRecord_Details] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblDocumentRecord_Details] ON [ACC].[tblDocumentRecord_Details] ([fldCodingId], [fldCaseId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Ixheader] ON [ACC].[tblDocumentRecord_Details] ([fldDocument_HedearId]) INCLUDE ([fldDocument_HedearId1], [fldBedehkar], [fldBestankar]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IxDocument_HedearId] ON [ACC].[tblDocumentRecord_Details] ([fldDocument_HedearId1]) INCLUDE ([fldCodingId], [fldBedehkar], [fldBestankar]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblDocumentRecord_Details] ADD CONSTRAINT [FK_tblDocumentRecord_Details_tblCase] FOREIGN KEY ([fldCaseId]) REFERENCES [ACC].[tblCase] ([fldId])
GO
ALTER TABLE [ACC].[tblDocumentRecord_Details] ADD CONSTRAINT [FK_tblDocumentRecord_Details_tblCenterCost] FOREIGN KEY ([fldCenterCoId]) REFERENCES [ACC].[tblCenterCost] ([fldId])
GO
ALTER TABLE [ACC].[tblDocumentRecord_Details] ADD CONSTRAINT [FK_tblDocumentRecord_Details_tblCoding] FOREIGN KEY ([fldCodingId]) REFERENCES [ACC].[tblCoding_Details] ([fldId])
GO
ALTER TABLE [ACC].[tblDocumentRecord_Details] ADD CONSTRAINT [FK_tblDocumentRecord_Details_tblDocumentRecord_Header] FOREIGN KEY ([fldDocument_HedearId]) REFERENCES [ACC].[tblDocumentRecord_Header] ([fldId])
GO
ALTER TABLE [ACC].[tblDocumentRecord_Details] ADD CONSTRAINT [FK_tblDocumentRecord_Details_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
