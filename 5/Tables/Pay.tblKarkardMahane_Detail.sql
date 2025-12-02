CREATE TABLE [Pay].[tblKarkardMahane_Detail]
(
[fldId] [int] NOT NULL,
[fldKarkardMahaneId] [int] NOT NULL,
[fldKarkard] [int] NOT NULL,
[fldKargahBimeId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblKarkardMahane_Detail_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblKarkardMahane_Detail_fldDate] DEFAULT (getdate())
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblKarkardMahane_Detail] ADD CONSTRAINT [PK_tblKarkardMahane_Detail] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblKarkardMahane_Detail] ADD CONSTRAINT [FK_tblKarkardMahane_Detail_Pay_tblInsuranceWorkshop] FOREIGN KEY ([fldKargahBimeId]) REFERENCES [Pay].[tblInsuranceWorkshop] ([fldId])
GO
ALTER TABLE [Pay].[tblKarkardMahane_Detail] ADD CONSTRAINT [FK_tblKarkardMahane_Detail_Pay_tblKarKardeMahane] FOREIGN KEY ([fldKarkardMahaneId]) REFERENCES [Pay].[tblKarKardeMahane] ([fldId])
GO
ALTER TABLE [Pay].[tblKarkardMahane_Detail] ADD CONSTRAINT [FK_tblKarkardMahane_Detail_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
