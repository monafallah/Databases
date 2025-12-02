CREATE TABLE [ACC].[tblArtiklMap]
(
[fldId] [int] NOT NULL,
[fldBankBillId] [int] NOT NULL,
[fldDocumentRecord_DetailsId] [int] NOT NULL,
[fldType] [tinyint] NOT NULL,
[fldSourceId] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblArtiklMap_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblArtiklMap] ADD CONSTRAINT [PK_tblArtiklMap] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblArtiklMap] ADD CONSTRAINT [FK_tblArtiklMap_tblBankBill_Details] FOREIGN KEY ([fldBankBillId]) REFERENCES [ACC].[tblBankBill_Details] ([fldId])
GO
ALTER TABLE [ACC].[tblArtiklMap] ADD CONSTRAINT [FK_tblArtiklMap_tblDocumentRecord_Details] FOREIGN KEY ([fldDocumentRecord_DetailsId]) REFERENCES [ACC].[tblDocumentRecord_Details] ([fldId])
GO
