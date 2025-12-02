CREATE TABLE [BUD].[tblMasrafType]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMasrafType_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMasrafType_fldDesc] DEFAULT (''),
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblMasrafType] ADD CONSTRAINT [PK_tblMasrafType] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblMasrafType] ADD CONSTRAINT [FK_tblMasrafType_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [BUD].[tblMasrafType] ADD CONSTRAINT [FK_tblMasrafType_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
