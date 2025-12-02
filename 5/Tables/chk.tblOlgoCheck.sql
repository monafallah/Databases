CREATE TABLE [chk].[tblOlgoCheck]
(
[fldId] [int] NOT NULL,
[fldIdFile] [int] NOT NULL,
[fldIdBank] [int] NOT NULL,
[fldUserID] [int] NOT NULL CONSTRAINT [DF_tblOlgoCheck_fldUserID] DEFAULT ((1)),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblOlgoCheck_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblOlgoCheck_fldDate] DEFAULT (getdate()),
[fldtitle] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganId] [int] NOT NULL
) ON [Check] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [chk].[tblOlgoCheck] ADD CONSTRAINT [PK_tblOlgoCheck] PRIMARY KEY CLUSTERED ([fldId]) ON [Check]
GO
ALTER TABLE [chk].[tblOlgoCheck] ADD CONSTRAINT [FK_tblOlgoCheck_tblBank] FOREIGN KEY ([fldIdBank]) REFERENCES [Com].[tblBank] ([fldId])
GO
ALTER TABLE [chk].[tblOlgoCheck] ADD CONSTRAINT [FK_tblOlgoCheck_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [chk].[tblOlgoCheck] ADD CONSTRAINT [FK_tblOlgoCheck_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
