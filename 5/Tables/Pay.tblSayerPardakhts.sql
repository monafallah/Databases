CREATE TABLE [Pay].[tblSayerPardakhts]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL CONSTRAINT [DF_tblSayerPardakhts_fldYear] DEFAULT ((1394)),
[fldMonth] [tinyint] NOT NULL CONSTRAINT [DF_tblSayerPardakhts_fldMonth] DEFAULT ((1)),
[fldAmount] [int] NOT NULL CONSTRAINT [DF_tblSayerPardakhts_fldAmount] DEFAULT ((0)),
[fldTitle] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSayerPardakhts_fldTitle] DEFAULT (''),
[fldNobatePardakt] [tinyint] NOT NULL CONSTRAINT [DF_tblSayerPardakhts_fldNobatePardakt] DEFAULT ((1)),
[fldMarhalePardakht] [tinyint] NOT NULL CONSTRAINT [DF_tblSayerPardakhts_fldMarhalePardakht] DEFAULT ((1)),
[fldHasMaliyat] [bit] NOT NULL,
[fldMaliyat] [int] NOT NULL,
[fldKhalesPardakhti] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblSayerPardakhts_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSayerPardakhts_fldDesc] DEFAULT (''),
[fldFlag] [bit] NULL,
[fldMostamar] [tinyint] NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblSayerPardakhts] ADD CONSTRAINT [PK_tblSayerPardakhtha] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblSayerPardakhts] ADD CONSTRAINT [IX_Pay_tblSayerPardakhts] UNIQUE NONCLUSTERED ([fldPersonalId], [fldYear], [fldMonth], [fldNobatePardakt], [fldMarhalePardakht]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblSayerPardakhts] ADD CONSTRAINT [FK_tblSayerPardakhts_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Pay].[tblSayerPardakhts] ADD CONSTRAINT [FK_tblSayerPardakhts_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
