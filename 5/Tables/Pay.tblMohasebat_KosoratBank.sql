CREATE TABLE [Pay].[tblMohasebat_KosoratBank]
(
[fldId] [int] NOT NULL,
[fldMohasebatId] [int] NOT NULL,
[fldKosoratBankId] [int] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMohasebat_KosoratBank_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMohasebat_KosoratBank_fldDesc] DEFAULT ('')
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMohasebat_KosoratBank] ADD CONSTRAINT [PK_tblMohasebat_KosoratBank] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMohasebat_KosoratBank] ADD CONSTRAINT [FK_tblMohasebat_KosoratBank_Pay_tblKosuratBank] FOREIGN KEY ([fldKosoratBankId]) REFERENCES [Pay].[tblKosuratBank] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_KosoratBank] ADD CONSTRAINT [FK_tblMohasebat_KosoratBank_Pay_tblMohasebat] FOREIGN KEY ([fldMohasebatId]) REFERENCES [Pay].[tblMohasebat] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_KosoratBank] ADD CONSTRAINT [FK_tblMohasebat_KosoratBank_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
