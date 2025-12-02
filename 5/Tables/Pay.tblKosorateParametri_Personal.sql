CREATE TABLE [Pay].[tblKosorateParametri_Personal]
(
[fldId] [int] NOT NULL CONSTRAINT [DF_tblKosorateParametriPersonal_fldId] DEFAULT ((1)),
[fldPersonalId] [int] NOT NULL,
[fldParametrId] [int] NOT NULL,
[fldNoePardakht] [bit] NOT NULL,
[fldMablagh] [int] NOT NULL CONSTRAINT [DF_tblKosorateParametriPersonal_fldMablagh] DEFAULT ((0)),
[fldTedad] [int] NOT NULL CONSTRAINT [DF_tblKosorateParametriPersonal_fldTedad] DEFAULT ((0)),
[fldTarikhePardakht] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldSumFish] [bit] NOT NULL,
[fldMondeFish] [bit] NOT NULL,
[fldSumPardakhtiGHabl] [int] NOT NULL CONSTRAINT [DF_tblKosorateParametriPersonal_fldSumPardakhtiGHabl] DEFAULT ((0)),
[fldMondeGHabl] [int] NOT NULL CONSTRAINT [DF_tblKosorateParametriPersonal_fldMondeGHabl] DEFAULT ((0)),
[fldStatus] [bit] NOT NULL,
[fldDateDeactive] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblKosorateParametri_Personal_fldDate] DEFAULT (getdate())
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblKosorateParametri_Personal] ADD CONSTRAINT [PK_tblKosorateParametriPersonal] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblKosorateParametri_Personal] ADD CONSTRAINT [IX_Pay_tblKosorateParametri_Personal] UNIQUE NONCLUSTERED ([fldParametrId], [fldMablagh], [fldTarikhePardakht], [fldPersonalId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblKosorateParametri_Personal] ADD CONSTRAINT [FK_tblKosorateParametri_Personal_Pay_tblParametrs] FOREIGN KEY ([fldParametrId]) REFERENCES [Pay].[tblParametrs] ([fldId])
GO
ALTER TABLE [Pay].[tblKosorateParametri_Personal] ADD CONSTRAINT [FK_tblKosorateParametri_Personal_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Pay].[tblKosorateParametri_Personal] ADD CONSTRAINT [FK_tblKosorateParametriPersonal_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
