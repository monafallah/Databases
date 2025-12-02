CREATE TABLE [Pay].[tblKosuratBank]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldShobeId] [int] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldCount] [smallint] NOT NULL,
[fldTarikhPardakht] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShomareHesab] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldStatus] [bit] NOT NULL,
[fldDeactiveDate] [int] NOT NULL,
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblKosuratBank_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblKosuratBank_fldDate] DEFAULT (getdate()),
[fldMandeAzGhabl] [int] NOT NULL CONSTRAINT [DF_tblKosuratBank_fldMandeAzGhabl] DEFAULT ((0)),
[fldMandeDarFish] [bit] NOT NULL CONSTRAINT [DF_tblKosuratBank_fldMandeDarFish] DEFAULT ((0)),
[fldShomareSheba] [nvarchar] (27) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblKosuratBank_fldShomareSheba] DEFAULT ('')
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblKosuratBank] ADD CONSTRAINT [PK_tblKosuratBank] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblKosuratBank] ADD CONSTRAINT [FK_tblKosuratBank_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Pay].[tblKosuratBank] ADD CONSTRAINT [FK_tblKosuratBank_tblSHobe] FOREIGN KEY ([fldShobeId]) REFERENCES [Com].[tblSHobe] ([fldId])
GO
ALTER TABLE [Pay].[tblKosuratBank] ADD CONSTRAINT [FK_tblKosuratBank_tblUsers] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
