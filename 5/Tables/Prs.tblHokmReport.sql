CREATE TABLE [Prs].[tblHokmReport]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFileId] [int] NOT NULL,
[fldAnvaEstekhdamId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_HokmReport_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_HokmReport_fldDate] DEFAULT (getdate())
) ON [Personeli]
GO
ALTER TABLE [Prs].[tblHokmReport] ADD CONSTRAINT [PK_Prs_HokmReport] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblHokmReport] ADD CONSTRAINT [IX_tblHokmReport] UNIQUE NONCLUSTERED ([fldAnvaEstekhdamId]) ON [PRIMARY]
GO
ALTER TABLE [Prs].[tblHokmReport] ADD CONSTRAINT [FK_HokmReport_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Prs].[tblHokmReport] ADD CONSTRAINT [FK_tblHokmReport_tblAnvaEstekhdam] FOREIGN KEY ([fldAnvaEstekhdamId]) REFERENCES [Com].[tblAnvaEstekhdam] ([fldId])
GO
ALTER TABLE [Prs].[tblHokmReport] ADD CONSTRAINT [FK_tblHokmReport_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
