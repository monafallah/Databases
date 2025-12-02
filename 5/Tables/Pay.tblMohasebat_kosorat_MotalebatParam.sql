CREATE TABLE [Pay].[tblMohasebat_kosorat/MotalebatParam]
(
[fldId] [int] NOT NULL,
[fldMohasebatId] [int] NOT NULL,
[fldKosoratId] [int] NULL,
[fldMotalebatId] [int] NULL,
[fldMablagh] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMohasebat_kosorat/MotalebatParam_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMohasebat_kosorat/MotalebatParam_fldDesc] DEFAULT (''),
[fldHesabTypeParamId] [tinyint] NULL,
[fldShomareHesabParamId] [int] NULL,
[fldIsMostamar] [tinyint] NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMohasebat_kosorat/MotalebatParam] ADD CONSTRAINT [PK_tblMohasebat_kosorat/MotalebatParam] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
CREATE NONCLUSTERED INDEX [indexMaliyat] ON [Pay].[tblMohasebat_kosorat/MotalebatParam] ([fldHesabTypeParamId], [fldIsMostamar]) INCLUDE ([fldMohasebatId], [fldMotalebatId], [fldMablagh]) ON [PayRoll]
GO
CREATE NONCLUSTERED INDEX [IX_tblMohasebat_kosorat/MotalebatParam] ON [Pay].[tblMohasebat_kosorat/MotalebatParam] ([fldMohasebatId], [fldKosoratId]) INCLUDE ([fldMablagh]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMohasebat_kosorat/MotalebatParam] ADD CONSTRAINT [FK_tblMohasebat_kosorat/MotalebatParam_Pay_tblKosorateParametri_Personal] FOREIGN KEY ([fldKosoratId]) REFERENCES [Pay].[tblKosorateParametri_Personal] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_kosorat/MotalebatParam] ADD CONSTRAINT [FK_tblMohasebat_kosorat/MotalebatParam_Pay_tblMohasebat] FOREIGN KEY ([fldMohasebatId]) REFERENCES [Pay].[tblMohasebat] ([fldId])
GO
ALTER TABLE [Pay].[tblMohasebat_kosorat/MotalebatParam] ADD CONSTRAINT [FK_tblMohasebat_kosorat/MotalebatParam_Pay_tblMotalebateParametri_Personal] FOREIGN KEY ([fldMotalebatId]) REFERENCES [Pay].[tblMotalebateParametri_Personal] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Pay].[tblMohasebat_kosorat/MotalebatParam] ADD CONSTRAINT [FK_tblMohasebat_kosorat/MotalebatParam_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
