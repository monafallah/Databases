CREATE TABLE [Pay].[tblMohasebat_Eydi]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldMonth] [tinyint] NOT NULL,
[fldDayCount] [int] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldMaliyat] [int] NOT NULL,
[fldKosurat] [int] NOT NULL,
[fldKhalesPardakhti] [int] NOT NULL,
[fldNobatPardakht] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMohasebatEydi_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMohasebatEydi_fldDate] DEFAULT (getdate()),
[fldHesabTypeId] [tinyint] NULL,
[fldFlag] [bit] NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMohasebat_Eydi] ADD CONSTRAINT [PK_tblMohasebatEydi] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMohasebat_Eydi] ADD CONSTRAINT [FK_tblMohasebat_Eydi_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_Eydi] ADD CONSTRAINT [FK_tblMohasebat_Eydi_tblHesabType] FOREIGN KEY ([fldHesabTypeId]) REFERENCES [Com].[tblHesabType] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_Eydi] ADD CONSTRAINT [FK_tblMohasebat_Eydi_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
