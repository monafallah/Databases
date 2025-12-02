CREATE TABLE [Com].[tblState]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (150) COLLATE Persian_100_CI_AI NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblState_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblState_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblState] ADD CONSTRAINT [PK_tblState] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblState] ADD CONSTRAINT [IX_tblState] UNIQUE NONCLUSTERED ([fldName]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblState] ADD CONSTRAINT [FK_tblState_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
