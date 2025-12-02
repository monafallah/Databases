CREATE TABLE [Prs].[tblHistoryNoeEstekhdam]
(
[fldId] [int] NOT NULL,
[fldNoeEstekhdamId] [int] NOT NULL,
[fldPrsPersonalInfoId] [int] NOT NULL,
[fldTarikh] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblHistoryNoeEstekhdam_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblHistoryNoeEstekhdam_fldDate] DEFAULT (getdate())
) ON [Personeli]
GO
ALTER TABLE [Prs].[tblHistoryNoeEstekhdam] ADD CONSTRAINT [PK_tblHistoryNoeEstekhdam] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblHistoryNoeEstekhdam] ADD CONSTRAINT [IX_Prs_tblHistoryNoeEstekhdam] UNIQUE NONCLUSTERED ([fldNoeEstekhdamId], [fldPrsPersonalInfoId], [fldTarikh]) ON [PRIMARY]
GO
ALTER TABLE [Prs].[tblHistoryNoeEstekhdam] ADD CONSTRAINT [FK_tblHistoryNoeEstekhdam_Prs_tblPersonalInfo] FOREIGN KEY ([fldPrsPersonalInfoId]) REFERENCES [Prs].[Prs_tblPersonalInfo] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Prs].[tblHistoryNoeEstekhdam] ADD CONSTRAINT [FK_tblHistoryNoeEstekhdam_tblAnvaEstekhdam] FOREIGN KEY ([fldNoeEstekhdamId]) REFERENCES [Com].[tblAnvaEstekhdam] ([fldId])
GO
ALTER TABLE [Prs].[tblHistoryNoeEstekhdam] ADD CONSTRAINT [FK_tblHistoryNoeEstekhdam_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
