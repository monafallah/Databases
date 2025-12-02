CREATE TABLE [Drd].[tblPardakhtFish]
(
[fldId] [int] NOT NULL,
[fldFishId] [int] NOT NULL,
[fldDatePardakht] [datetime] NOT NULL,
[fldNahvePardakhtId] [int] NOT NULL,
[fldTarikh] AS ([com].[MiladiTOShamsi]([fldDatePardakht])),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPardakhtFish_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPardakhtFish_fldDate] DEFAULT (getdate()),
[fldPardakhtFiles_DetailId] [int] NULL,
[fldDateVariz] [datetime] NULL,
[fldTarikhVariz] AS ([com].[MiladiTOShamsi]([fldDateVariz])),
[fldDocumentHeaderId1] [int] NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPardakhtFish] ADD CONSTRAINT [PK_tblPardakhtFish] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblPardakhtFish] ADD CONSTRAINT [IX_tblPardakhtFish] UNIQUE NONCLUSTERED ([fldFishId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPardakhtFish] ADD CONSTRAINT [FK_tblPardakhtFish_tblDocumentRecord_Header1] FOREIGN KEY ([fldDocumentHeaderId1]) REFERENCES [ACC].[tblDocumentRecord_Header1] ([fldId])
GO
ALTER TABLE [Drd].[tblPardakhtFish] ADD CONSTRAINT [FK_tblPardakhtFish_tblNahvePardakht] FOREIGN KEY ([fldNahvePardakhtId]) REFERENCES [Drd].[tblNahvePardakht] ([fldId])
GO
ALTER TABLE [Drd].[tblPardakhtFish] ADD CONSTRAINT [FK_tblPardakhtFish_tblPardakhtFiles_Detail] FOREIGN KEY ([fldPardakhtFiles_DetailId]) REFERENCES [Drd].[tblPardakhtFiles_Detail] ([fldId])
GO
ALTER TABLE [Drd].[tblPardakhtFish] ADD CONSTRAINT [FK_tblPardakhtFish_tblSodoorFish] FOREIGN KEY ([fldFishId]) REFERENCES [Drd].[tblSodoorFish] ([fldId])
GO
ALTER TABLE [Drd].[tblPardakhtFish] ADD CONSTRAINT [FK_tblPardakhtFish_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'getdate()', 'SCHEMA', N'Drd', 'TABLE', N'tblPardakhtFish', 'COLUMN', N'fldDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'''''', 'SCHEMA', N'Drd', 'TABLE', N'tblPardakhtFish', 'COLUMN', N'fldDesc'
GO
