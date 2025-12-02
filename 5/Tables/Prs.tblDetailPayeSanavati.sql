CREATE TABLE [Prs].[tblDetailPayeSanavati]
(
[fldId] [int] NOT NULL,
[fldPayeSanavatiId] [int] NOT NULL,
[fldGroh] [tinyint] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblDetailPayeSanavati_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblDetailPayeSanavati_fldDesc] DEFAULT ('')
) ON [Personeli]
GO
ALTER TABLE [Prs].[tblDetailPayeSanavati] ADD CONSTRAINT [PK_tblDetailPayeSanavati] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblDetailPayeSanavati] ADD CONSTRAINT [FK_tblDetailPayeSanavati_PayeSanavati] FOREIGN KEY ([fldPayeSanavatiId]) REFERENCES [Prs].[tblPayeSanavati] ([fldId])
GO
ALTER TABLE [Prs].[tblDetailPayeSanavati] ADD CONSTRAINT [FK_tblDetailPayeSanavati_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
