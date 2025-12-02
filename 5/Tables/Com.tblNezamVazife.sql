CREATE TABLE [Com].[tblNezamVazife]
(
[fldId] [tinyint] NOT NULL,
[fldTitle] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblNezamVazife_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblNezamVazife_fldDate] DEFAULT (getdate()),
[fldTitleBazneshastegi] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblNezamVazife] ADD CONSTRAINT [PK_tblNezamVazife] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblNezamVazife] ADD CONSTRAINT [IX_Prs_tblNezamVazife] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblNezamVazife] ADD CONSTRAINT [FK_tblNezamVazife_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
