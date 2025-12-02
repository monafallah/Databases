CREATE TABLE [Auto].[tblInternalAssignmentSender]
(
[fldID] [int] NOT NULL,
[fldAssignmentID] [int] NOT NULL,
[fldSenderComisionID] [int] NOT NULL,
[fldBoxID] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblInternalAssignmentSender_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_tblInternalAssignmentSender_fldDesc] DEFAULT (''),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblInternalAssignmentSender] ADD CONSTRAINT [PK_tblInternalAssignmentSender] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblInternalAssignmentSender] ADD CONSTRAINT [FK_tblInternalAssignmentSender_tblAssignment] FOREIGN KEY ([fldAssignmentID]) REFERENCES [Auto].[tblAssignment] ([fldID])
GO
ALTER TABLE [Auto].[tblInternalAssignmentSender] ADD CONSTRAINT [FK_tblInternalAssignmentSender_tblBox] FOREIGN KEY ([fldBoxID]) REFERENCES [Auto].[tblBox] ([fldID])
GO
ALTER TABLE [Auto].[tblInternalAssignmentSender] ADD CONSTRAINT [FK_tblInternalAssignmentSender_tblCommision] FOREIGN KEY ([fldSenderComisionID]) REFERENCES [Auto].[tblCommision] ([fldID])
GO
ALTER TABLE [Auto].[tblInternalAssignmentSender] ADD CONSTRAINT [FK_tblInternalAssignmentSender_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblInternalAssignmentSender] ADD CONSTRAINT [FK_tblInternalAssignmentSender_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
