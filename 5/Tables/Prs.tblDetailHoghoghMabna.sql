CREATE TABLE [Prs].[tblDetailHoghoghMabna]
(
[fldId] [int] NOT NULL,
[fldHoghoghMabnaId] [int] NOT NULL,
[fldGroh] [tinyint] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblDetailHoghoghMabna_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblDetailHoghoghMabna_fldDesc] DEFAULT ('')
) ON [Personeli]
GO
ALTER TABLE [Prs].[tblDetailHoghoghMabna] ADD CONSTRAINT [PK_tblDetailHoghoghMabna] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblDetailHoghoghMabna] ADD CONSTRAINT [FK_tblDetailHoghoghMabna_Prs_tblHoghoghMabna] FOREIGN KEY ([fldHoghoghMabnaId]) REFERENCES [Prs].[tblHoghoghMabna] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Prs].[tblDetailHoghoghMabna] ADD CONSTRAINT [FK_tblDetailHoghoghMabna_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
