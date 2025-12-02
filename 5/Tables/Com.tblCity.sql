CREATE TABLE [Com].[tblCity]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (150) COLLATE Persian_100_CI_AI NOT NULL,
[fldStateId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCity_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCity_fldDate] DEFAULT (getdate()),
[fldLatitude] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldLongitude] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblCity] ADD CONSTRAINT [CK_tblCity] CHECK ((len([fldName])>=(2)))
GO
ALTER TABLE [Com].[tblCity] ADD CONSTRAINT [PK_tblCity] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblCity] ADD CONSTRAINT [IX_tblCity] UNIQUE NONCLUSTERED ([fldName], [fldStateId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblCity] ADD CONSTRAINT [FK_tblCity_tblState] FOREIGN KEY ([fldStateId]) REFERENCES [Com].[tblState] ([fldId])
GO
ALTER TABLE [Com].[tblCity] ADD CONSTRAINT [FK_tblCity_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
