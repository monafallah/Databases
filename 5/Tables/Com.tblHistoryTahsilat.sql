CREATE TABLE [Com].[tblHistoryTahsilat]
(
[fldId] [int] NOT NULL,
[fldEmployeeId] [int] NOT NULL,
[fldMadrakId] [int] NOT NULL,
[fldReshteId] [int] NOT NULL,
[fldTarikh] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblHistoryTahsilat_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblHistoryTahsilat_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblHistoryTahsilat] ADD CONSTRAINT [PK_tblHistoryTahsilat] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblHistoryTahsilat] ADD CONSTRAINT [FK_tblHistoryTahsilat_tblEmployee] FOREIGN KEY ([fldEmployeeId]) REFERENCES [Com].[tblEmployee] ([fldId])
GO
ALTER TABLE [Com].[tblHistoryTahsilat] ADD CONSTRAINT [FK_tblHistoryTahsilat_tblMadrakTahsili] FOREIGN KEY ([fldMadrakId]) REFERENCES [Com].[tblMadrakTahsili] ([fldId])
GO
ALTER TABLE [Com].[tblHistoryTahsilat] ADD CONSTRAINT [FK_tblHistoryTahsilat_tblReshteTahsili] FOREIGN KEY ([fldReshteId]) REFERENCES [Com].[tblReshteTahsili] ([fldId])
GO
ALTER TABLE [Com].[tblHistoryTahsilat] ADD CONSTRAINT [FK_tblHistoryTahsilat_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
