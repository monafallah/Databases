CREATE TABLE [Prs].[tblHoghoghMabna]
(
[fldId] [int] NOT NULL,
[fldYear] [int] NOT NULL,
[fldType] [bit] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblHoghoghMabna_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblHoghoghMabna_fldDesc] DEFAULT ('')
) ON [Personeli]
GO
ALTER TABLE [Prs].[tblHoghoghMabna] ADD CONSTRAINT [PK_tblHoghoghMabna] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblHoghoghMabna] ADD CONSTRAINT [FK_tblHoghoghMabna_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
