CREATE TABLE [Auto].[tblAssignmentType]
(
[fldID] [int] NOT NULL,
[fldType] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganID] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblAssignmentType_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblAssignmentType_fldDesc] DEFAULT (''),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblAssignmentType] ADD CONSTRAINT [PK_tblAssignmentType] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblAssignmentType] ADD CONSTRAINT [IX_tblAssignmentType] UNIQUE NONCLUSTERED ([fldType]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblAssignmentType] ADD CONSTRAINT [FK_tblAssignmentType_tblAssignmentType] FOREIGN KEY ([fldID]) REFERENCES [Auto].[tblAssignmentType] ([fldID])
GO
ALTER TABLE [Auto].[tblAssignmentType] ADD CONSTRAINT [FK_tblAssignmentType_tblOrganization] FOREIGN KEY ([fldOrganID]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblAssignmentType] ADD CONSTRAINT [FK_tblAssignmentType_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
