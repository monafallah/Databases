CREATE TABLE [Com].[tblMadrakTahsili]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblMadrakTahsili_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblMadrakTahsili_fldDate] DEFAULT (getdate()),
[fldMadrakIdSina] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblMadrakTahsili] ADD CONSTRAINT [CK_tblMadrakTahsili] CHECK ((len([fldTitle])>=(2)))
GO
ALTER TABLE [Com].[tblMadrakTahsili] ADD CONSTRAINT [PK_tblMadrakTahsili] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblMadrakTahsili] ADD CONSTRAINT [IX_Prs_tblMadrakTahsili] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblMadrakTahsili] ADD CONSTRAINT [FK_tblMadrakTahsili_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
