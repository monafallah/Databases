CREATE TABLE [Pay].[tblMohasebatEzafeKari_TatilKari]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL CONSTRAINT [DF_tblMohasebatEzafeKari_TatilKari_fldYear] DEFAULT ((1394)),
[fldMonth] [tinyint] NOT NULL CONSTRAINT [DF_tblMohasebatEzafeKari_TatilKari_fldMonth] DEFAULT ((1)),
[fldTedad] [decimal] (6, 3) NOT NULL,
[fldMablagh] [int] NOT NULL CONSTRAINT [DF_tblMohasebatEzafeKari_TatilKari_fldMablagh] DEFAULT ((0)),
[fldBimePersonal] [int] NOT NULL,
[fldBimeKarFarma] [int] NOT NULL,
[fldBimeBikari] [int] NOT NULL,
[fldBimeSakht] [int] NOT NULL,
[fldDarsadBimePersonal] [decimal] (8, 4) NOT NULL CONSTRAINT [DF_tblMohasebatEzafeKari_TatilKari_fldDarsadBimePersonal] DEFAULT ((0)),
[fldDarsadBimeKarFarma] [decimal] (8, 4) NOT NULL CONSTRAINT [DF_tblMohasebatEzafeKari_TatilKari_fldDarsadBimeKarFarma] DEFAULT ((0)),
[fldDarsadBimeBikari] [decimal] (8, 4) NOT NULL CONSTRAINT [DF_tblMohasebatEzafeKari_TatilKari_fldDarsadBimeBikari] DEFAULT ((0)),
[fldDarsadBimeSakht] [decimal] (8, 4) NOT NULL CONSTRAINT [DF_tblMohasebatEzafeKari_TatilKari_fldDarsadBimeSakht] DEFAULT ((0)),
[fldMashmolBime] [int] NOT NULL,
[fldMashmolMaliyat] [int] NOT NULL,
[fldNobatPardakht] [int] NOT NULL,
[fldType] [tinyint] NOT NULL,
[fldKhalesPardakhti] [int] NOT NULL,
[fldMaliyat] [int] NOT NULL CONSTRAINT [DF_tblMohasebatEzafeKari_TatilKari_fldMaliyat] DEFAULT ((0)),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMohasebatEzafeKari_TatilKari_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMohasebatEzafeKari_TatilKari_fldDate] DEFAULT (getdate()),
[fldHesabTypeId] [tinyint] NULL,
[fldMashmolBimeNaKhales] [int] NULL,
[fldFlag] [bit] NULL
) ON [Personeli]
GO
ALTER TABLE [Pay].[tblMohasebatEzafeKari_TatilKari] ADD CONSTRAINT [PK_tblMohasebatEzafeKari_TatilKari] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Pay].[tblMohasebatEzafeKari_TatilKari] ADD CONSTRAINT [FK_tblMohasebatEzafeKari_TatilKari_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Pay].[tblMohasebatEzafeKari_TatilKari] ADD CONSTRAINT [FK_tblMohasebatEzafeKari_TatilKari_tblHesabType] FOREIGN KEY ([fldHesabTypeId]) REFERENCES [Com].[tblHesabType] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebatEzafeKari_TatilKari] ADD CONSTRAINT [FK_tblMohasebatEzafeKari_TatilKari_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
