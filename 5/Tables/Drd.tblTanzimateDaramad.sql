CREATE TABLE [Drd].[tblTanzimateDaramad]
(
[fldId] [int] NOT NULL,
[fldAvarezId] [int] NULL,
[fldMaliyatId] [int] NULL,
[fldTakhirId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTanzimateDaramad_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTanzimateDaramad_fldDate] DEFAULT (getdate()),
[fldMablaghGerdKardan] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldShomareHesabIdPishfarz] [int] NOT NULL,
[fldNerkh] [decimal] (5, 2) NOT NULL,
[fldChapShenaseGhabz_Pardakht] [bit] NOT NULL,
[fldShorooshenaseGhabz] [tinyint] NOT NULL,
[fldFormul] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldSumMaliyat_Avarez] [bit] NOT NULL CONSTRAINT [DF_tblTanzimateDaramad_fldSeeDetail] DEFAULT ((0))
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblTanzimateDaramad] ADD CONSTRAINT [PK_tblTanzimateDaramad] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblTanzimateDaramad] ADD CONSTRAINT [IX_tblTanzimateDaramad_1] UNIQUE NONCLUSTERED ([fldOrganId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblTanzimateDaramad] ADD CONSTRAINT [FK_tblTanzimateDaramad_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Drd].[tblTanzimateDaramad] ADD CONSTRAINT [FK_tblTanzimateDaramad_tblShomareHesabeOmoomi1] FOREIGN KEY ([fldShomareHesabIdPishfarz]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
ALTER TABLE [Drd].[tblTanzimateDaramad] ADD CONSTRAINT [FK_tblTanzimateDaramad_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
