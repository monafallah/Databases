CREATE TABLE [Prs].[tblTasviehHesab]
(
[fldId] [int] NOT NULL,
[fldPrsPersonalInfoId] [int] NOT NULL,
[fldTarikh] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTasviehHesab_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTasviehHesab_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Prs].[tblTasviehHesab] ADD CONSTRAINT [PK_tblTasviehHesab] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Prs].[tblTasviehHesab] ADD CONSTRAINT [IX_tblTasviehHesab] UNIQUE NONCLUSTERED ([fldPrsPersonalInfoId], [fldTarikh]) ON [PRIMARY]
GO
ALTER TABLE [Prs].[tblTasviehHesab] ADD CONSTRAINT [FK_tblTasviehHesab_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
