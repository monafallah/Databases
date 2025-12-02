CREATE TABLE [Pay].[tblMohasebat_PersonalInfo]
(
[fldId] [int] NOT NULL,
[fldMohasebatId] [int] NULL,
[fldVamId] [int] NULL,
[fldEzafe_TatilKariId] [int] NULL,
[fldMamuriyatId] [int] NULL,
[fldSayerPardakhthaId] [int] NULL,
[fldCostCenterId] [int] NULL,
[fldInsuranceWorkShopId] [int] NULL,
[fldCodeShoghliBime] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldTypeBimeId] [int] NULL,
[fldAnvaEstekhdamId] [int] NULL,
[fldFiscalHeaderId] [int] NULL,
[fldMoteghayerHoghoghiId] [int] NULL,
[fldShomareHesabId] [int] NULL,
[fldShomareBime] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldShPasAndazPersonal] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldShPasAndazKarFarma] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldHokmId] [int] NULL,
[fldTedadBime1] [int] NULL,
[fldTedadBime2] [int] NULL,
[fldTedadBime3] [int] NULL,
[fldT_Asli] [tinyint] NULL,
[fldT_70] [tinyint] NULL,
[fldT_60] [tinyint] NULL,
[fldHamsareKarmand] [bit] NULL,
[fldMazad30Sal] [bit] NULL,
[fldMohasebatEydiId] [int] NULL,
[fldKomakGheyerNaghdiId] [int] NULL,
[fldStatusIsargariId] [int] NULL,
[fldMorakhasiId] [int] NULL,
[fldOrganId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMohasebat_PersonalInfo_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMohasebat_PersonalInfo_fldDate] DEFAULT (getdate()),
[fldChartOrganId] [int] NULL,
[fldT_BedonePoshesh] [tinyint] NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [PK_tblMohasebat_PersonalInfo] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
CREATE NONCLUSTERED INDEX [IxfldInsuranceWorkShopId_OrganId] ON [Pay].[tblMohasebat_PersonalInfo] ([fldInsuranceWorkShopId], [fldOrganId]) INCLUDE ([fldMohasebatId], [fldCostCenterId], [fldCodeShoghliBime], [fldTypeBimeId], [fldShomareHesabId], [fldShomareBime], [fldShPasAndazPersonal], [fldShPasAndazKarFarma], [fldHokmId], [fldTedadBime1], [fldTedadBime2], [fldTedadBime3], [fldT_Asli], [fldT_70], [fldT_60], [fldHamsareKarmand], [fldMazad30Sal], [fldStatusIsargariId]) ON [PayRoll]
GO
CREATE NONCLUSTERED INDEX [IX_tblMohasebat_PersonalInfo] ON [Pay].[tblMohasebat_PersonalInfo] ([fldMohasebatEydiId], [fldOrganId]) ON [PayRoll]
GO
CREATE NONCLUSTERED INDEX [ixMohasebatId] ON [Pay].[tblMohasebat_PersonalInfo] ([fldMohasebatId], [fldOrganId]) INCLUDE ([fldShomareHesabId]) ON [PayRoll]
GO
CREATE NONCLUSTERED INDEX [tax] ON [Pay].[tblMohasebat_PersonalInfo] ([fldSayerPardakhthaId]) INCLUDE ([fldShomareHesabId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblAnvaEstekhdam] FOREIGN KEY ([fldAnvaEstekhdamId]) REFERENCES [Com].[tblAnvaEstekhdam] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblChartOrgan] FOREIGN KEY ([fldChartOrganId]) REFERENCES [Com].[tblChartOrganEjraee] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblChartOrganEjraee] FOREIGN KEY ([fldChartOrganId]) REFERENCES [Com].[tblChartOrganEjraee] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblCostCenter] FOREIGN KEY ([fldCostCenterId]) REFERENCES [Pay].[tblCostCenter] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblFiscal_Header] FOREIGN KEY ([fldFiscalHeaderId]) REFERENCES [Pay].[tblFiscal_Header] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblInsuranceWorkshop] FOREIGN KEY ([fldInsuranceWorkShopId]) REFERENCES [Pay].[tblInsuranceWorkshop] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblKomakGheyerNaghdi] FOREIGN KEY ([fldKomakGheyerNaghdiId]) REFERENCES [Pay].[tblKomakGheyerNaghdi] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblMohasebat] FOREIGN KEY ([fldMohasebatId]) REFERENCES [Pay].[tblMohasebat] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblMohasebat_Eydi] FOREIGN KEY ([fldMohasebatEydiId]) REFERENCES [Pay].[tblMohasebat_Eydi] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblMohasebat_Mamuriyat] FOREIGN KEY ([fldMamuriyatId]) REFERENCES [Pay].[tblMohasebat_Mamuriyat] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblMohasebat_Morakhasi] FOREIGN KEY ([fldMorakhasiId]) REFERENCES [Pay].[tblMohasebat_Morakhasi] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblMohasebatEzafeKari_TatilKari] FOREIGN KEY ([fldEzafe_TatilKariId]) REFERENCES [Pay].[tblMohasebatEzafeKari_TatilKari] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblMoteghayerhayeHoghoghi] FOREIGN KEY ([fldMoteghayerHoghoghiId]) REFERENCES [Pay].[tblMoteghayerhayeHoghoghi] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblPersonalHokm] FOREIGN KEY ([fldHokmId]) REFERENCES [Prs].[tblPersonalHokm] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblSayerPardakhts] FOREIGN KEY ([fldSayerPardakhthaId]) REFERENCES [Pay].[tblSayerPardakhts] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblShomareHesabeOmoomi] FOREIGN KEY ([fldShomareHesabId]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblTypeBime] FOREIGN KEY ([fldTypeBimeId]) REFERENCES [Com].[tblTypeBime] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblVam] FOREIGN KEY ([fldVamId]) REFERENCES [Pay].[tblVam] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_PersonalInfo] ADD CONSTRAINT [FK_tblMohasebat_PersonalInfo_tblVaziyatEsargari] FOREIGN KEY ([fldStatusIsargariId]) REFERENCES [Prs].[tblVaziyatEsargari] ([fldId])
GO
