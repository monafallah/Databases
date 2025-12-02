CREATE TABLE [Pay].[tblMohasebat]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldMonth] [tinyint] NOT NULL,
[fldKarkard] [tinyint] NOT NULL,
[fldGheybat] [tinyint] NOT NULL,
[fldTedadEzafeKar] [decimal] (6, 3) NOT NULL,
[fldTedadTatilKar] [decimal] (6, 3) NOT NULL,
[fldBaBeytute] [tinyint] NOT NULL,
[fldBedunBeytute] [tinyint] NOT NULL,
[fldBimeOmrKarFarma] [int] NOT NULL,
[fldBimeOmr] [int] NOT NULL,
[fldBimeTakmilyKarFarma] [int] NOT NULL,
[fldBimeTakmily] [int] NOT NULL,
[fldHaghDarmanKarfFarma] [int] NOT NULL,
[fldHaghDarmanDolat] [int] NOT NULL CONSTRAINT [DF_tblMohasebat_fldHaghDarmanDolat] DEFAULT ((0)),
[fldHaghDarman] [int] NOT NULL,
[fldBimePersonal] [int] NOT NULL,
[fldBimeKarFarma] [int] NOT NULL,
[fldBimeBikari] [int] NOT NULL,
[fldBimeMashaghel] [int] NOT NULL,
[fldDarsadBimePersonal] [decimal] (8, 4) NOT NULL,
[fldDarsadBimeKarFarma] [decimal] (8, 4) NOT NULL,
[fldDarsadBimeBikari] [decimal] (8, 4) NOT NULL,
[fldDarsadBimeSakht] [decimal] (8, 4) NOT NULL,
[fldTedadNobatKari] [tinyint] NOT NULL,
[fldMosaede] [int] NOT NULL,
[fldNobatPardakht] [int] NOT NULL,
[fldGhestVam] [int] NOT NULL,
[fldPasAndaz] [int] NOT NULL,
[fldMashmolBime] [int] NOT NULL,
[fldMashmolMaliyat] [int] NOT NULL,
[fldFlag] [bit] NOT NULL,
[fldMogharari] [int] NOT NULL CONSTRAINT [DF_tblMohasebat_fldMogharari] DEFAULT ((0)),
[fldMaliyat] [int] NOT NULL CONSTRAINT [DF_tblMohasebat_fldMaliyat] DEFAULT ((0)),
[fldkhalesPardakhti] AS ((((((([Com].[fn_SumItemMohasebat]([fldId])+[Com].[fn_SumMohasebeMotalebat_Kosorat]([fldId],(0)))+[fldHaghDarmanKarfFarma])+[fldHaghDarmanDolat])+[fldPasAndaz]/(2))+[fldBimeTakmilyKarFarma])+[fldBimeOmrKarFarma])-(((((((((([Com].[fn_SumMohasebeMotalebat_Kosorat]([fldId],(1))+[fldHaghDarman])+[fldPasAndaz])+[Com].[fn_SumMohasebeKosoratBank]([fldId]))+[fldMosaede])+[fldBimePersonal])+[fldMaliyat])+[fldBimeTakmily])+[fldBimeOmr])+[fldMogharari])+[fldGhestVam])),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMohasebat_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMohasebat_fldDate] DEFAULT (getdate()),
[fldShift] [int] NOT NULL CONSTRAINT [DF_tblMohasebat_fldShift] DEFAULT ((0)),
[fldHesabTypeId] [tinyint] NULL,
[fldMashmolBimeNaKhales] [int] NULL,
[fldMaliyatCalc] [int] NULL,
[fldMaliyatType] [tinyint] NULL,
[fldMeetingCount] [smallint] NULL,
[fldCalcType] [tinyint] NOT NULL CONSTRAINT [DF_tblMohasebat_fldCalcType] DEFAULT ((1)),
[fldEstelagi] [tinyint] NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMohasebat] ADD CONSTRAINT [PK_tblMohasebat] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>] ON [Pay].[tblMohasebat] ([fldPersonalId], [fldYear], [fldMonth]) INCLUDE ([fldId], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarman], [fldBimePersonal]) ON [PayRoll]
GO
CREATE NONCLUSTERED INDEX [IxYearMonthNobat] ON [Pay].[tblMohasebat] ([fldYear], [fldMonth], [fldNobatPardakht]) INCLUDE ([fldId], [fldPersonalId], [fldKarkard], [fldGheybat], [fldTedadEzafeKar], [fldTedadTatilKar], [fldBaBeytute], [fldBedunBeytute], [fldBimeOmrKarFarma], [fldBimeOmr], [fldBimeTakmilyKarFarma], [fldBimeTakmily], [fldHaghDarmanKarfFarma], [fldHaghDarmanDolat], [fldHaghDarman], [fldBimePersonal], [fldBimeKarFarma], [fldBimeBikari], [fldBimeMashaghel], [fldTedadNobatKari], [fldMosaede], [fldGhestVam], [fldPasAndaz], [fldMashmolBime], [fldMashmolMaliyat], [fldMogharari], [fldMaliyat]) ON [PayRoll]
GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20251022-145614] ON [Pay].[tblMohasebat] ([fldYear] DESC, [fldMonth] DESC, [fldPersonalId], [fldFlag]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMohasebat] ADD CONSTRAINT [FK_tblMohasebat_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat] ADD CONSTRAINT [FK_tblMohasebat_tblHesabType] FOREIGN KEY ([fldHesabTypeId]) REFERENCES [Com].[tblHesabType] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat] ADD CONSTRAINT [FK_tblMohasebat_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
