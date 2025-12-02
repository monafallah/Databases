CREATE TABLE [Drd].[tblSodoorFish_Detail]
(
[fldId] [int] NOT NULL,
[fldFishId] [int] NOT NULL,
[fldCodeElamAvarezId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFish_Detail_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFish_Detail_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblSodoorFish_Detail] ADD CONSTRAINT [PK_tblFish_Detail] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
CREATE NONCLUSTERED INDEX [_dta_index_tblSodoorFish_Detail_6_911446421__K3_K2_1] ON [Drd].[tblSodoorFish_Detail] ([fldCodeElamAvarezId], [fldFishId]) INCLUDE ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblSodoorFish_Detail] ADD CONSTRAINT [IX_tblSodoorFish_Detail] UNIQUE NONCLUSTERED ([fldFishId], [fldCodeElamAvarezId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblSodoorFish_Detail] ADD CONSTRAINT [FK_tblFish_Detail_tblCodhayeDaramadiElamAvarez] FOREIGN KEY ([fldCodeElamAvarezId]) REFERENCES [Drd].[tblCodhayeDaramadiElamAvarez] ([fldID])
GO
ALTER TABLE [Drd].[tblSodoorFish_Detail] ADD CONSTRAINT [FK_tblFish_Detail_tblFish] FOREIGN KEY ([fldFishId]) REFERENCES [Drd].[tblSodoorFish] ([fldId])
GO
ALTER TABLE [Drd].[tblSodoorFish_Detail] ADD CONSTRAINT [FK_tblFish_Detail_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
