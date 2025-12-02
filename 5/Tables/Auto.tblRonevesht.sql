CREATE TABLE [Auto].[tblRonevesht]
(
[fldID] [int] NOT NULL,
[fldLetterID] [bigint] NOT NULL,
[fldAshkhasHoghoghiId] [int] NULL,
[fldCommisionId] [int] NULL,
[fldAssignmentTypeId] [int] NULL,
[fldText] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblRonevesht_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblRonevesht_fldDesc] DEFAULT (''),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAshkhasHoghoghiTitlesId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblRonevesht] ADD CONSTRAINT [PK_tblRonevesht] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblRonevesht] ADD CONSTRAINT [FK_tblRonevesht_tblAshkhaseHoghoghiTitles] FOREIGN KEY ([fldAshkhasHoghoghiTitlesId]) REFERENCES [Auto].[tblAshkhaseHoghoghiTitles] ([fldId])
GO
ALTER TABLE [Auto].[tblRonevesht] ADD CONSTRAINT [FK_tblRonevesht_tblAssignmentType] FOREIGN KEY ([fldAssignmentTypeId]) REFERENCES [Auto].[tblAssignmentType] ([fldID])
GO
ALTER TABLE [Auto].[tblRonevesht] ADD CONSTRAINT [FK_tblRonevesht_tblCommision] FOREIGN KEY ([fldCommisionId]) REFERENCES [Auto].[tblCommision] ([fldID])
GO
ALTER TABLE [Auto].[tblRonevesht] ADD CONSTRAINT [FK_tblRonevesht_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblRonevesht] ADD CONSTRAINT [FK_tblRonevesht_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
