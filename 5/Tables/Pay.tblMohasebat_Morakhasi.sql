CREATE TABLE [Pay].[tblMohasebat_Morakhasi]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldTedad] [tinyint] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldMonth] [tinyint] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldNobatPardakht] [tinyint] NOT NULL,
[fldSalHokm] [smallint] NOT NULL,
[fldHokmId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMohasebat_Morakhasi_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMohasebat_Morakhasi_fldDate] DEFAULT (getdate()),
[fldHesabTypeId] [tinyint] NULL,
[fldFlag] [bit] NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMohasebat_Morakhasi] ADD CONSTRAINT [PK_tblMohasebat_Morakhasi] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMohasebat_Morakhasi] ADD CONSTRAINT [FK_tblMohasebat_Morakhasi_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_Morakhasi] ADD CONSTRAINT [FK_tblMohasebat_Morakhasi_tblHesabType] FOREIGN KEY ([fldHesabTypeId]) REFERENCES [Com].[tblHesabType] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_Morakhasi] ADD CONSTRAINT [FK_tblMohasebat_Morakhasi_tblPersonalHokm] FOREIGN KEY ([fldHokmId]) REFERENCES [Prs].[tblPersonalHokm] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_Morakhasi] ADD CONSTRAINT [FK_tblMohasebat_Morakhasi_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
