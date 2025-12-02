CREATE TABLE [Drd].[tblSodoorFish]
(
[fldId] [int] NOT NULL,
[fldElamAvarezId] [int] NOT NULL,
[fldShomareHesabId] [int] NOT NULL,
[fldShenaseGhabz] [nvarchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShenasePardakht] [nvarchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMablaghAvarezGerdShode] [bigint] NOT NULL,
[fldShorooShenaseGhabz] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFish_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFish_fldDate] DEFAULT (getdate()),
[fldJamKol] [bigint] NOT NULL,
[fldBarcode] [nvarchar] (26) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikh] AS ([dbo].[Fn_AssembelyMiladiToShamsi]([flddate])),
[fldSendToMaliFlag] [bit] NOT NULL CONSTRAINT [DF_tblSodoorFish_fldSendToMaliFlag] DEFAULT ((0)),
[fldFishSentFlag] [bit] NOT NULL CONSTRAINT [DF_tblSodoorFish_fldFishSentFlag] DEFAULT ((0)),
[fldDateSendToMali] [datetime] NULL,
[fldDateFishSent] [datetime] NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblSodoorFish] ADD CONSTRAINT [CK_tblSodoorFish] CHECK (([fldShorooShenaseGhabz]>=(10) AND [fldShorooShenaseGhabz]<=(99)))
GO
ALTER TABLE [Drd].[tblSodoorFish] ADD CONSTRAINT [PK_tblFish] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblSodoorFish] ADD CONSTRAINT [FK_tblSodoorFish_tblElamAvarez] FOREIGN KEY ([fldElamAvarezId]) REFERENCES [Drd].[tblElamAvarez] ([fldId])
GO
ALTER TABLE [Drd].[tblSodoorFish] ADD CONSTRAINT [FK_tblSodoorFish_tblShomareHesabeOmoomi] FOREIGN KEY ([fldShomareHesabId]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
ALTER TABLE [Drd].[tblSodoorFish] ADD CONSTRAINT [FK_tblSodoorFish_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
