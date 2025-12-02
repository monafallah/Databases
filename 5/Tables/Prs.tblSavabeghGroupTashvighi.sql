CREATE TABLE [Prs].[tblSavabeghGroupTashvighi]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldAnvaGroupId] [tinyint] NOT NULL,
[fldTedadGroup] [tinyint] NOT NULL,
[fldTarikh] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblSavabeghGroupTashvighi_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblSavabeghGroupTashvighi_fldDate] DEFAULT (getdate())
) ON [Personeli]
GO
ALTER TABLE [Prs].[tblSavabeghGroupTashvighi] ADD CONSTRAINT [PK_tblSavabeghGroupTashvighi] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblSavabeghGroupTashvighi] ADD CONSTRAINT [FK_tblSavabeghGroupTashvighi_Prs_PersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Prs].[Prs_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Prs].[tblSavabeghGroupTashvighi] ADD CONSTRAINT [FK_tblSavabeghGroupTashvighi_tblAnvaGroupTashvighi] FOREIGN KEY ([fldAnvaGroupId]) REFERENCES [Prs].[tblAnvaGroupTashvighi] ([fldId])
GO
ALTER TABLE [Prs].[tblSavabeghGroupTashvighi] ADD CONSTRAINT [FK_tblSavabeghGroupTashvighi_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
