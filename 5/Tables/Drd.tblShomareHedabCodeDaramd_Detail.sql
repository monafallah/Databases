CREATE TABLE [Drd].[tblShomareHedabCodeDaramd_Detail]
(
[fldId] [int] NOT NULL,
[fldStartYear] [smallint] NOT NULL,
[fldEndYear] [smallint] NOT NULL,
[fldCodeDaramdId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblShomareHedabCodeDaramd_Detail_fldDate] DEFAULT (getdate()),
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblShomareHedabCodeDaramd_Detail] ADD CONSTRAINT [PK_tblShomareHedabCodeDaramd_Detail] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblShomareHedabCodeDaramd_Detail] ADD CONSTRAINT [FK_tblShomareHedabCodeDaramd_Detail_tblCodhayeDaramd] FOREIGN KEY ([fldCodeDaramdId]) REFERENCES [Drd].[tblCodhayeDaramd] ([fldId])
GO
ALTER TABLE [Drd].[tblShomareHedabCodeDaramd_Detail] ADD CONSTRAINT [FK_tblShomareHedabCodeDaramd_Detail_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
