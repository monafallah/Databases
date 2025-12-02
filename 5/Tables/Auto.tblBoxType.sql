CREATE TABLE [Auto].[tblBoxType]
(
[fldID] [int] NOT NULL,
[fldType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganID] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblBoxType_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblBoxType_fldDesc] DEFAULT (''),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblBoxType] ADD CONSTRAINT [CK_tblBoxType] CHECK ((len([fldType])>=(2)))
GO
ALTER TABLE [Auto].[tblBoxType] ADD CONSTRAINT [PK_tblBoxType] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblBoxType] ADD CONSTRAINT [IX_tblBoxType] UNIQUE NONCLUSTERED ([fldType]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblBoxType] ADD CONSTRAINT [FK_tblBoxType_tblOrganization] FOREIGN KEY ([fldOrganID]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblBoxType] ADD CONSTRAINT [FK_tblBoxType_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
