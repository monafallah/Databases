CREATE TABLE [Pay].[tblMamuriyat]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldMonth] [tinyint] NOT NULL,
[fldNobatePardakht] [tinyint] NOT NULL,
[fldBaBeytute] [tinyint] NOT NULL,
[fldBeduneBeytute] [tinyint] NOT NULL,
[fldBa10] [tinyint] NOT NULL,
[fldBa20] [tinyint] NOT NULL,
[fldBa30] [tinyint] NOT NULL,
[fldBe10] [tinyint] NOT NULL,
[fldBe20] [tinyint] NOT NULL,
[fldBe30] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMamuriyat_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMamuriyat_fldDesc] DEFAULT (''),
[fldFlag] [bit] NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMamuriyat] ADD CONSTRAINT [CK_tblMamuriyat] CHECK (([fldBaBeytute]+[fldBeduneBeytute]<=(50)))
GO
ALTER TABLE [Pay].[tblMamuriyat] ADD CONSTRAINT [PK_tblMamuriyat] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMamuriyat] ADD CONSTRAINT [IX_Pay_tblMamuriyat] UNIQUE NONCLUSTERED ([fldPersonalId], [fldYear], [fldMonth], [fldNobatePardakht]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMamuriyat] ADD CONSTRAINT [FK_tblMamuriyat_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Pay].[tblMamuriyat] ADD CONSTRAINT [FK_tblMamuriyat_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
