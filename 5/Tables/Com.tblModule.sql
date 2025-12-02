CREATE TABLE [Com].[tblModule]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblModule_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblModule_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblModule] ADD CONSTRAINT [PK_tblModule] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblModule] ADD CONSTRAINT [IX_tblModule] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblModule] ADD CONSTRAINT [FK_tblModule_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
