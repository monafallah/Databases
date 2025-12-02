CREATE TABLE [Pay].[tblMoavaghat]
(
[fldId] [int] NOT NULL,
[fldMohasebatId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldMonth] [tinyint] NOT NULL,
[fldHaghDarmanKarfFarma] [int] NOT NULL,
[fldHaghDarmanDolat] [int] NOT NULL CONSTRAINT [DF_tblMoavaghat_fldHaghDarmanDolat] DEFAULT ((0)),
[fldHaghDarman] [int] NOT NULL,
[fldBimePersonal] [int] NOT NULL,
[fldBimeKarFarma] [int] NOT NULL,
[fldBimeBikari] [int] NOT NULL,
[fldBimeMashaghel] [int] NOT NULL,
[fldPasAndaz] [int] NOT NULL,
[fldMashmolBime] [int] NOT NULL,
[fldMashmolMaliyat] [int] NOT NULL,
[fldkhalesPardakhti] AS (((([Com].[fn_SumMoavaghatItem]([fldid])+[fldHaghDarmanKarfFarma])+[fldHaghDarmanDolat])+[fldPasAndaz]/(2))-((([Com].[fn_IsMaliyatManfiForMoavaghe]([fldMohasebatId],[fldid])+[fldBimePersonal])+[fldHaghDarman])+[fldPasAndaz])),
[fldMaliyat] [int] NOT NULL CONSTRAINT [DF_tblMoavaghat_fldMaliyat_1] DEFAULT ((0)),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMoavaghat_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMoavaghat_fldDate] DEFAULT (getdate()),
[fldHokmId] [int] NULL,
[fldMashmolBimeNaKhales] [int] NULL,
[fldMaliyatCalc] [int] NULL CONSTRAINT [DF_tblMoavaghat_fldMaliyat] DEFAULT ((0))
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMoavaghat] ADD CONSTRAINT [PK_tblMoavaghat] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
CREATE NONCLUSTERED INDEX [IX_tblMoavaghat] ON [Pay].[tblMoavaghat] ([fldMohasebatId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMoavaghat] ADD CONSTRAINT [FK_tblMoavaghat_Pay_tblMohasebat] FOREIGN KEY ([fldMohasebatId]) REFERENCES [Pay].[tblMohasebat] ([fldId])
GO
ALTER TABLE [Pay].[tblMoavaghat] ADD CONSTRAINT [FK_tblMoavaghat_tblPersonalHokm] FOREIGN KEY ([fldHokmId]) REFERENCES [Prs].[tblPersonalHokm] ([fldId])
GO
ALTER TABLE [Pay].[tblMoavaghat] ADD CONSTRAINT [FK_tblMoavaghat_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
