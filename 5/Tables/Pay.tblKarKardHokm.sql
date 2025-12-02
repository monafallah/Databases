CREATE TABLE [Pay].[tblKarKardHokm]
(
[fldId] [int] NOT NULL,
[fldKarkardId] [int] NOT NULL,
[fldHokmId] [int] NOT NULL,
[fldRoze] [decimal] (4, 1) NOT NULL,
[fldGheybat] [decimal] (4, 1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblKarKardHokm] ADD CONSTRAINT [PK_tblKarKardHokm] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblKarKardHokm] ADD CONSTRAINT [IX_tblKarKardHokm] UNIQUE NONCLUSTERED ([fldKarkardId], [fldHokmId]) ON [PRIMARY]
GO
