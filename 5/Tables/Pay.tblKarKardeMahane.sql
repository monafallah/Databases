CREATE TABLE [Pay].[tblKarKardeMahane]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldMah] [tinyint] NOT NULL,
[fldKarkard] [tinyint] NOT NULL,
[fldGheybat] [tinyint] NOT NULL,
[fldNobateKari] [tinyint] NOT NULL,
[fldEzafeKari] [decimal] (6, 3) NOT NULL,
[fldTatileKari] [decimal] (6, 3) NOT NULL,
[fldMamoriatBaBeitote] [tinyint] NOT NULL,
[fldMamoriatBedoneBeitote] [tinyint] NOT NULL,
[fldMosaedeh] [int] NOT NULL,
[fldNobatePardakht] [tinyint] NOT NULL,
[fldFlag] [bit] NOT NULL CONSTRAINT [DF_tblKarKardeMahane_fldFlag] DEFAULT ((0)),
[fldGhati] [bit] NOT NULL CONSTRAINT [DF_tblKarKardeMahane_fldGhati] DEFAULT ((0)),
[fldBa10] [tinyint] NOT NULL CONSTRAINT [DF_tblKarKardeMahane_fldBa10] DEFAULT ((0)),
[fldBa20] [tinyint] NOT NULL CONSTRAINT [DF_tblKarKardeMahane_fldBa20] DEFAULT ((0)),
[fldBa30] [tinyint] NOT NULL CONSTRAINT [DF_tblKarKardeMahane_fldBa30] DEFAULT ((0)),
[fldBe10] [tinyint] NOT NULL CONSTRAINT [DF_tblKarKardeMahane_fldBe10] DEFAULT ((0)),
[fldBe20] [tinyint] NOT NULL CONSTRAINT [DF_tblKarKardeMahane_fldBe20] DEFAULT ((0)),
[fldBe30] [tinyint] NOT NULL CONSTRAINT [DF_tblKarKardeMahane_fldBe30] DEFAULT ((0)),
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblKarkardeMahane_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblKarkardeMahane_fldDesc] DEFAULT (''),
[fldShift] [int] NOT NULL CONSTRAINT [DF_tblKarKardeMahane_fldShift] DEFAULT ((0)),
[fldMoavaghe] [bit] NULL,
[fldAzTarikhMoavaghe] [int] NULL,
[fldTaTarikhMoavaghe] [int] NULL,
[fldMeetingCount] [smallint] NOT NULL CONSTRAINT [DF_tblKarKardeMahane_fldMeetingCount] DEFAULT ((0)),
[fldEstelagi] [tinyint] NOT NULL CONSTRAINT [DF_tblKarKardeMahane_fldEstelagi] DEFAULT ((0))
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblKarKardeMahane] ADD CONSTRAINT [PK_tblKarkardeMahane] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblKarKardeMahane] ADD CONSTRAINT [IX_tblKarKardeMahane] UNIQUE NONCLUSTERED ([fldPersonalId], [fldMah], [fldYear], [fldNobatePardakht]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20251022-145614] ON [Pay].[tblKarKardeMahane] ([fldYear] DESC, [fldMah] DESC, [fldPersonalId], [fldFlag]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblKarKardeMahane] ADD CONSTRAINT [FK_tblKarKardeMahane_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Pay].[tblKarKardeMahane] ADD CONSTRAINT [FK_tblKarKardeMahane_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
