CREATE TABLE [Prs].[tblPatternSharhHokm]
(
[fldId] [int] NOT NULL,
[fldPatternText] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldHokmType] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblPatternSharhHokm_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblPatternSharhHokm_fldDesc] DEFAULT ('')
) ON [Personeli]
GO
ALTER TABLE [Prs].[tblPatternSharhHokm] ADD CONSTRAINT [PK_tblPatternSharhHokm] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblPatternSharhHokm] ADD CONSTRAINT [FK_tblPatternSharhHokm_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
