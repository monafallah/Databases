CREATE TABLE [Drd].[tblCodhayeDaramadiElamAvarez]
(
[fldID] [int] NOT NULL,
[fldElamAvarezId] [int] NOT NULL,
[fldSharheCodeDaramad] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShomareHesabCodeDaramadId] [int] NOT NULL,
[fldAsliValue] [bigint] NOT NULL,
[fldAvarezValue] [bigint] NOT NULL,
[fldMaliyatValue] [bigint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCodhayeDaramadiElamAvarez_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCodhayeDaramadiElamAvarez_fldDate] DEFAULT (getdate()),
[fldShomareHesabId] [int] NOT NULL,
[fldTedad] [int] NOT NULL CONSTRAINT [DF_tblCodhayeDaramadiElamAvarez_fldTedad] DEFAULT ((1)),
[fldTakhfifAsliValue] [bigint] NULL,
[fldTakhfifAvarezValue] [bigint] NULL,
[fldTakhfifMaliyatValue] [bigint] NULL,
[fldSumMablgh] AS ((([fldAsliValue]*[fldTedad]+[fldAvarezValue])+[fldMaliyatValue])+[fldAmuzeshParvareshValue]),
[fldSumAsli] [bigint] NULL,
[fldDarsadTakhfif] [decimal] (5, 2) NULL,
[fldAmuzeshParvareshValue] [bigint] NOT NULL CONSTRAINT [DF_tblCodhayeDaramadiElamAvarez_fldAmuzeshParvareshValue] DEFAULT ((0)),
[fldTakhfifAmuzeshParvareshValue] [bigint] NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblCodhayeDaramadiElamAvarez] ADD CONSTRAINT [PK_tblCodhayeDaramadiElamAvarez] PRIMARY KEY CLUSTERED ([fldID]) ON [Daramad]
GO
CREATE NONCLUSTERED INDEX [_dta_index_tblCodhayeDaramadiElamAvarez_6_1735833396__K2_5_6_7_12] ON [Drd].[tblCodhayeDaramadiElamAvarez] ([fldElamAvarezId]) INCLUDE ([fldAsliValue], [fldAvarezValue], [fldMaliyatValue], [fldTedad]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblCodhayeDaramadiElamAvarez] ADD CONSTRAINT [FK_tblCodhayeDaramadiElamAvarez_tblCodhayeDaramd] FOREIGN KEY ([fldShomareHesabCodeDaramadId]) REFERENCES [Drd].[tblShomareHesabCodeDaramad] ([fldId])
GO
ALTER TABLE [Drd].[tblCodhayeDaramadiElamAvarez] ADD CONSTRAINT [FK_tblCodhayeDaramadiElamAvarez_tblElamAvarez] FOREIGN KEY ([fldElamAvarezId]) REFERENCES [Drd].[tblElamAvarez] ([fldId])
GO
ALTER TABLE [Drd].[tblCodhayeDaramadiElamAvarez] ADD CONSTRAINT [FK_tblCodhayeDaramadiElamAvarez_tblShomareHesabCodeDaramad] FOREIGN KEY ([fldShomareHesabCodeDaramadId]) REFERENCES [Drd].[tblShomareHesabCodeDaramad] ([fldId])
GO
ALTER TABLE [Drd].[tblCodhayeDaramadiElamAvarez] ADD CONSTRAINT [FK_tblCodhayeDaramadiElamAvarez_tblShomareHesabeOmoomi] FOREIGN KEY ([fldShomareHesabId]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
ALTER TABLE [Drd].[tblCodhayeDaramadiElamAvarez] ADD CONSTRAINT [FK_tblCodhayeDaramadiElamAvarez_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
