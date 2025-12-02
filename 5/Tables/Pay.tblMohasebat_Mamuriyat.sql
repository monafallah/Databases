CREATE TABLE [Pay].[tblMohasebat_Mamuriyat]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL CONSTRAINT [DF_tblMohasebat_Mamuriyat_fldYear] DEFAULT ((1394)),
[fldMonth] [tinyint] NOT NULL CONSTRAINT [DF_tblMohasebat_Mamuriyat_fldMonth] DEFAULT ((1)),
[fldTedadBaBeytute] [tinyint] NOT NULL,
[fldTedadBedunBeytute] [tinyint] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldBimePersonal] [int] NOT NULL,
[fldBimeKarFarma] [int] NOT NULL,
[fldBimeBikari] [int] NOT NULL,
[fldBimeSakht] [int] NOT NULL,
[fldDarsadBimePersonal] [decimal] (8, 4) NOT NULL,
[fldDarsadBimeKarFarma] [decimal] (8, 4) NOT NULL,
[fldDarsadBimeBiKari] [decimal] (8, 4) NOT NULL,
[fldDarsadBimeSakht] [decimal] (8, 4) NOT NULL,
[fldMashmolBime] [int] NOT NULL,
[fldMashmolMaliyat] [int] NOT NULL,
[fldKhalesPardakhti] [int] NOT NULL,
[fldMaliyat] [int] NOT NULL CONSTRAINT [DF_tblMohasebat_Mamuriyat_fldMaliyat] DEFAULT ((0)),
[fldTashilat] [int] NOT NULL CONSTRAINT [DF_tblMohasebat_Mamuriyat_fldTashilat] DEFAULT ((0)),
[fldNobatePardakht] [tinyint] NOT NULL CONSTRAINT [DF_tblMohasebat_Mamuriyat_fldNobatePardakht] DEFAULT ((1)),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMohasebat_Mamuriyat_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMohasebat_Mamuriyat_fldDate] DEFAULT (getdate()),
[fldHesabTypeId] [tinyint] NULL,
[fldMashmolBimeNaKhales] [int] NULL,
[fldFlag] [bit] NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMohasebat_Mamuriyat] ADD CONSTRAINT [PK_tblMohasebat_Mamuriyat] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMohasebat_Mamuriyat] ADD CONSTRAINT [FK_tblMohasebat_Mamuriyat_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Pay].[tblMohasebat_Mamuriyat] ADD CONSTRAINT [FK_tblMohasebat_Mamuriyat_tblHesabType] FOREIGN KEY ([fldHesabTypeId]) REFERENCES [Com].[tblHesabType] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_Mamuriyat] ADD CONSTRAINT [FK_tblMohasebat_Mamuriyat_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
