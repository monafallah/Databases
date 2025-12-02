CREATE TABLE [Pay].[tblMoteghayerhayeEydi]
(
[fldId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeEydi_fldYear] DEFAULT ((1394)),
[fldMaxEydiKarmand] [int] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeEydi_fldMaxEydiKarmand] DEFAULT ((0)),
[fldMaxEydiKargar] [int] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeEydi_fldMaxEydiKargar] DEFAULT ((0)),
[fldZaribEydiKargari] [decimal] (8, 3) NOT NULL CONSTRAINT [DF_tblMoteghayerhayeEydi_fldZaribEydiKargari] DEFAULT ((0)),
[fldTypeMohasebatMaliyat] [bit] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeEydi_fldTypeMohasebatMaliyat] DEFAULT ((0)),
[fldMablaghMoafiatKarmand] [int] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeEydi_fldMablaghMoafiatKarmand] DEFAULT ((0)),
[fldMablaghMoafiatKargar] [int] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeEydi_fldMablaghMoafiatKargar] DEFAULT ((0)),
[fldDarsadMaliyatKarmand] [decimal] (5, 2) NOT NULL CONSTRAINT [DF_tblMoteghayerhayeEydi_fldDarsadMaliyatKarmand] DEFAULT ((0)),
[fldDarsadMaliyatKargar] [decimal] (5, 2) NOT NULL CONSTRAINT [DF_tblMoteghayerhayeEydi_fldDarsadMaliyatKargar] DEFAULT ((0)),
[fldTypeMohasebe] [bit] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeEydi_fldTypeMohasebe] DEFAULT ((0)),
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMoteghayerhayeEydi_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMoteghayerhayeEydi_fldDesc] DEFAULT (''),
[fldMablaghHamsar] [int] NULL CONSTRAINT [DF_tblMoteghayerhayeEydi_fldMablaghHamsar] DEFAULT ((0)),
[fldMablaghFarzand] [int] NULL CONSTRAINT [DF_tblMoteghayerhayeEydi_fldMablaghFarzand] DEFAULT ((0))
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMoteghayerhayeEydi] ADD CONSTRAINT [PK_tblMoteghayerhayeEydi] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMoteghayerhayeEydi] ADD CONSTRAINT [IX_Pay_tblMoteghayerhayeEydi] UNIQUE NONCLUSTERED ([fldYear]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMoteghayerhayeEydi] ADD CONSTRAINT [FK_tblMoteghayerhayeEydi_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
