CREATE TABLE [Com].[tblZirListHa]
(
[fldId] [int] NOT NULL,
[fldReportId] [int] NOT NULL,
[fldMasuolin_DetailId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblZirListHa_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblZirListHa_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblZirListHa] ADD CONSTRAINT [PK_tblZirListHa] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblZirListHa] ADD CONSTRAINT [FK_tblZirListHa_tblMasuolin_Detail] FOREIGN KEY ([fldMasuolin_DetailId]) REFERENCES [Com].[tblMasuolin_Detail] ([fldId])
GO
ALTER TABLE [Com].[tblZirListHa] ADD CONSTRAINT [FK_tblZirListHa_tblReports] FOREIGN KEY ([fldReportId]) REFERENCES [Com].[tblReports] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Com].[tblZirListHa] ADD CONSTRAINT [FK_tblZirListHa_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
