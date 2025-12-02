CREATE TABLE [Prs].[tblAnvaGroupTashvighi]
(
[fldId] [tinyint] NOT NULL,
[fldTitle] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblAnvaGroupTashvighi_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblAnvaGroupTashvighi_fldDesc] DEFAULT ('')
) ON [Personeli]
GO
ALTER TABLE [Prs].[tblAnvaGroupTashvighi] ADD CONSTRAINT [PK_tblAnvaGroupTashvighi] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblAnvaGroupTashvighi] ADD CONSTRAINT [FK_tblAnvaGroupTashvighi_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
