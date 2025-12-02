CREATE TABLE [Pay].[tblKomakGheyerNaghdi]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldMonth] [tinyint] NOT NULL,
[fldNoeMostamer] [bit] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldKhalesPardakhti] [int] NOT NULL,
[fldMaliyat] [int] NOT NULL,
[fldShomareHesabId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblKomakGheyerNaghdi_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblKomakGheyerNaghdi_fldDate] DEFAULT (getdate()),
[fldFlag] [bit] NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblKomakGheyerNaghdi] ADD CONSTRAINT [PK_tblKomakGheyerNaghdi] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblKomakGheyerNaghdi] ADD CONSTRAINT [FK_tblKomakGheyerNaghdi_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Pay].[tblKomakGheyerNaghdi] ADD CONSTRAINT [FK_tblKomakGheyerNaghdi_Pay_tblShomareHesabeOmoomi] FOREIGN KEY ([fldShomareHesabId]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
