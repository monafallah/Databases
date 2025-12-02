CREATE TABLE [Com].[tblFile]
(
[fldId] [int] NOT NULL,
[fldImage] [varbinary] (max) NULL,
[fldPasvand] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFile_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFile_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblFile] ADD CONSTRAINT [PK_tblFile] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblFile] ADD CONSTRAINT [FK_tblFile_tblFile] FOREIGN KEY ([fldId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [Com].[tblFile] ADD CONSTRAINT [FK_tblFile_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
