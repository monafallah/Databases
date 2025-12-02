CREATE TABLE [Pay].[tblMorakhasi]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL CONSTRAINT [DF_tblMorakhasi_fldYear] DEFAULT ((1394)),
[fldMonth] [tinyint] NOT NULL CONSTRAINT [DF_tblMorakhasi_fldMonth] DEFAULT ((1)),
[fldNobatePardakht] [tinyint] NOT NULL CONSTRAINT [DF_tblMorakhasi_fldNobatePardakht] DEFAULT ((1)),
[fldSalAkharinHokm] [smallint] NOT NULL CONSTRAINT [DF_tblMorakhasi_fldSalAkharinHokm] DEFAULT ((1394)),
[fldTedad] [int] NOT NULL CONSTRAINT [DF_tblMorakhasi_fldTedad] DEFAULT ((0)),
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMorakhasi_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMorakhasi_fldDesc] DEFAULT (''),
[fldFlag] [bit] NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMorakhasi] ADD CONSTRAINT [PK_tblMorakhasi] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMorakhasi] ADD CONSTRAINT [IX_Pay_tblMorakhasi] UNIQUE NONCLUSTERED ([fldPersonalId], [fldYear], [fldMonth], [fldNobatePardakht]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMorakhasi] ADD CONSTRAINT [FK_tblMorakhasi_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Pay].[tblMorakhasi] ADD CONSTRAINT [FK_tblMorakhasi_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
