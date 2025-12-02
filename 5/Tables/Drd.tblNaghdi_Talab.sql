CREATE TABLE [Drd].[tblNaghdi_Talab]
(
[fldId] [int] NOT NULL,
[fldMablagh] [bigint] NOT NULL,
[fldReplyTaghsitId] [int] NOT NULL,
[fldType] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTaghdi_Talab_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTaghdi_Talab_fldDate] DEFAULT (getdate()),
[fldFishId] [int] NULL,
[fldShomareHesabId] [int] NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblNaghdi_Talab] ADD CONSTRAINT [PK_tblTaghdi_Talab] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblNaghdi_Talab] ADD CONSTRAINT [FK_tblNaghdi_Talab_tblShomareHesabeOmoomi] FOREIGN KEY ([fldShomareHesabId]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
ALTER TABLE [Drd].[tblNaghdi_Talab] ADD CONSTRAINT [FK_tblNaghdi_Talab_tblSodoorFish] FOREIGN KEY ([fldFishId]) REFERENCES [Drd].[tblSodoorFish] ([fldId])
GO
ALTER TABLE [Drd].[tblNaghdi_Talab] ADD CONSTRAINT [FK_tblTaghdi_Talab_tblReplyTaghsit] FOREIGN KEY ([fldReplyTaghsitId]) REFERENCES [Drd].[tblReplyTaghsit] ([fldId])
GO
ALTER TABLE [Drd].[tblNaghdi_Talab] ADD CONSTRAINT [FK_tblTaghdi_Talab_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
