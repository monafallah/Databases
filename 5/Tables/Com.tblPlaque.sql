CREATE TABLE [Com].[tblPlaque]
(
[fldId] [int] NOT NULL,
[fldSerialPlaque] [tinyint] NOT NULL,
[fldPlaque] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPlaque_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPlaque_fldDate] DEFAULT (getdate()),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblPlaque] ADD CONSTRAINT [PK_tblPlaque] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblPlaque] ADD CONSTRAINT [FK_tblPlaque_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
