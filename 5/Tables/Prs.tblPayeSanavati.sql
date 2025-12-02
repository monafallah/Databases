CREATE TABLE [Prs].[tblPayeSanavati]
(
[fldId] [int] NOT NULL,
[fldYear] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblPayeSanvati_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblPayeSanvati_fldDesc] DEFAULT ('')
) ON [Personeli]
GO
ALTER TABLE [Prs].[tblPayeSanavati] ADD CONSTRAINT [PK_tblPayeSanvati] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblPayeSanavati] ADD CONSTRAINT [FK_tblPayeSanavati_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
