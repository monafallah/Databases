CREATE TABLE [Auto].[tblAssignmentStatus]
(
[fldID] [int] NOT NULL,
[fldName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblAssignmentStatus_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_tblAssignmentStatus_fldDesc] DEFAULT (''),
[fldOrganId] [int] NOT NULL,
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblAssignmentStatus] ADD CONSTRAINT [PK_tblAssignmentStatus] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblAssignmentStatus] ADD CONSTRAINT [FK_tblAssignmentStatus_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblAssignmentStatus] ADD CONSTRAINT [FK_tblAssignmentStatus_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
