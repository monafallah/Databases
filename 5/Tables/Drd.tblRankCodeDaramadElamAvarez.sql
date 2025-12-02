CREATE TABLE [Drd].[tblRankCodeDaramadElamAvarez]
(
[fldId] [int] NOT NULL,
[fldElamAvarezId] [int] NOT NULL,
[fldShomareHesabCodeDaramadId] [int] NOT NULL,
[fldMablagh] [bigint] NOT NULL,
[fldRank] [tinyint] NOT NULL,
[fldFishId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblRankCodeDaramadElamAvarez] ADD CONSTRAINT [PK_tblRankCodeDaramadElamAvarez] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblRankCodeDaramadElamAvarez] ADD CONSTRAINT [FK_tblRankCodeDaramadElamAvarez_tblElamAvarez] FOREIGN KEY ([fldElamAvarezId]) REFERENCES [Drd].[tblElamAvarez] ([fldId])
GO
ALTER TABLE [Drd].[tblRankCodeDaramadElamAvarez] ADD CONSTRAINT [FK_tblRankCodeDaramadElamAvarez_tblShomareHesabCodeDaramad] FOREIGN KEY ([fldShomareHesabCodeDaramadId]) REFERENCES [Drd].[tblShomareHesabCodeDaramad] ([fldId])
GO
ALTER TABLE [Drd].[tblRankCodeDaramadElamAvarez] ADD CONSTRAINT [FK_tblRankCodeDaramadElamAvarez_tblSodoorFish] FOREIGN KEY ([fldFishId]) REFERENCES [Drd].[tblSodoorFish] ([fldId])
GO
