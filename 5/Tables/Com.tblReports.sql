CREATE TABLE [Com].[tblReports]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMasirReport] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldModuleId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblReports_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblReports_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblReports] ADD CONSTRAINT [PK_tblReports] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblReports] ADD CONSTRAINT [IX_tblReports] UNIQUE NONCLUSTERED ([fldModuleId], [fldTitle]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblReports] ADD CONSTRAINT [FK_tblReports_tblModule] FOREIGN KEY ([fldModuleId]) REFERENCES [Com].[tblModule] ([fldId])
GO
ALTER TABLE [Com].[tblReports] ADD CONSTRAINT [FK_tblReports_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
