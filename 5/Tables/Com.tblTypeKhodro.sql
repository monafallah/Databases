CREATE TABLE [Com].[tblTypeKhodro]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTypeKhodro_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTypeKhodro_fldDate] DEFAULT (getdate()),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrder] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblTypeKhodro] ADD CONSTRAINT [PK_tblTypeKhodro] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblTypeKhodro] ADD CONSTRAINT [IX_tblTypeKhodro] UNIQUE NONCLUSTERED ([fldName]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblTypeKhodro] ADD CONSTRAINT [FK_tblTypeKhodro_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
