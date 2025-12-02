CREATE TABLE [Drd].[tblCheck]
(
[fldId] [int] NOT NULL,
[fldShomareHesabId] [int] NOT NULL,
[fldReplyTaghsitId] [int] NULL,
[fldShomareSanad] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikhSarResid] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldMablaghSanad] [bigint] NOT NULL,
[fldStatus] [tinyint] NULL,
[fldTypeSanad] [bit] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCheck_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCheck_fldDate] DEFAULT (getdate()),
[fldShomareHesabIdOrgan] [int] NULL,
[fldDateStatus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldTarikhAkhz] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCheck_fldTarikhAkhz] DEFAULT (''),
[fldSendToMali] [bit] NULL,
[fldSendToMaliDate] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldAshkhasId] [int] NULL,
[fldBabat] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCheck_fldBabat] DEFAULT (''),
[fldBabatFlag] [bit] NOT NULL CONSTRAINT [DF_tblCheck_fldBabatFlag] DEFAULT ((0)),
[fldIdDasteCheck] [int] NULL,
[fldOrganId] [int] NULL,
[fldShobeId] [int] NULL,
[fldReceive] [bit] NOT NULL CONSTRAINT [DF__tblCheck__fldRec__1A0EBAA7] DEFAULT ((0)),
[fldDocumentHeader1Id] [int] NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblCheck] ADD CONSTRAINT [CK_tblCheck_1] CHECK ((len([fldShomareSanad])>=(2)))
GO
ALTER TABLE [Drd].[tblCheck] ADD CONSTRAINT [PK_tblCheck] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblCheck] ADD CONSTRAINT [IX_tblCheck] UNIQUE NONCLUSTERED ([fldShomareSanad]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblCheck] ADD CONSTRAINT [FK_tblCheck_tblAshkhas] FOREIGN KEY ([fldAshkhasId]) REFERENCES [Com].[tblAshkhas] ([fldId])
GO
ALTER TABLE [Drd].[tblCheck] ADD CONSTRAINT [FK_tblCheck_tblDasteCheck] FOREIGN KEY ([fldIdDasteCheck]) REFERENCES [chk].[tblDasteCheck] ([fldId])
GO
ALTER TABLE [Drd].[tblCheck] ADD CONSTRAINT [FK_tblCheck_tblDocumentRecord_Header1] FOREIGN KEY ([fldDocumentHeader1Id]) REFERENCES [ACC].[tblDocumentRecord_Header1] ([fldId])
GO
ALTER TABLE [Drd].[tblCheck] ADD CONSTRAINT [FK_tblCheck_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Drd].[tblCheck] ADD CONSTRAINT [FK_tblCheck_tblReplyTaghsit] FOREIGN KEY ([fldReplyTaghsitId]) REFERENCES [Drd].[tblReplyTaghsit] ([fldId])
GO
ALTER TABLE [Drd].[tblCheck] ADD CONSTRAINT [FK_tblCheck_tblShomareHesabeOmoomi] FOREIGN KEY ([fldShomareHesabId]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
ALTER TABLE [Drd].[tblCheck] ADD CONSTRAINT [FK_tblCheck_tblShomareHesabeOmoomi1] FOREIGN KEY ([fldShomareHesabIdOrgan]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
ALTER TABLE [Drd].[tblCheck] ADD CONSTRAINT [FK_tblCheck_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
