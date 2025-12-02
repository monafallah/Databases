CREATE TABLE [Pay].[tblEzafeKari_TatilKari]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldMonth] [tinyint] NOT NULL,
[fldNobatePardakht] [tinyint] NOT NULL,
[fldCount] [decimal] (6, 3) NOT NULL,
[fldType] [tinyint] NOT NULL,
[fldHasBime] [bit] NOT NULL,
[fldHasMaliyat] [bit] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblEzafeKari_TatilKari_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblEzafeKari_TatilKari_fldDesc] DEFAULT (''),
[fldFlag] [bit] NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblEzafeKari_TatilKari] ADD CONSTRAINT [CK_tblEzafeKari_TatilKari] CHECK (([fldType]=(1) AND [fldCount]<=(300.000) OR [fldtype]=(2) AND [fldcount]<=(20.000)))
GO
ALTER TABLE [Pay].[tblEzafeKari_TatilKari] ADD CONSTRAINT [PK_tblEzafeKari_TatilKari] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblEzafeKari_TatilKari] ADD CONSTRAINT [IX_Pay_tblEzafeKari_TatilKari] UNIQUE NONCLUSTERED ([fldMonth], [fldYear], [fldPersonalId], [fldNobatePardakht], [fldType]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblEzafeKari_TatilKari] ADD CONSTRAINT [FK_tblEzafeKari_TatilKari_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Pay].[tblEzafeKari_TatilKari] ADD CONSTRAINT [FK_tblEzafeKari_TatilKari_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
