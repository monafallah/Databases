CREATE TABLE [BUD].[tblEtebarType]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldEnName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldOrganId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblEtebarType_flddate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblEtebarType_fldDesc] DEFAULT (''),
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblEtebarType] ADD CONSTRAINT [PK_tblEtebarType] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblEtebarType] ADD CONSTRAINT [IX_tblEtebarType] UNIQUE NONCLUSTERED ([fldTitle], [fldOrganId]) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblEtebarType] ADD CONSTRAINT [FK_tblEtebarType_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [BUD].[tblEtebarType] ADD CONSTRAINT [FK_tblEtebarType_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
