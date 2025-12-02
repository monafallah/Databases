CREATE TABLE [Auto].[tblInternalAssignmentReceiver]
(
[fldID] [int] NOT NULL,
[fldAssignmentID] [int] NOT NULL,
[fldReceiverComisionId] [int] NOT NULL,
[fldAssignmentStatusId] [int] NOT NULL,
[fldAssignmentTypeID] [int] NOT NULL,
[fldBoxId] [int] NOT NULL,
[fldLetterReadDate] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldShowTypeT_F] [bit] NOT NULL,
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_tblInternalAssignmentReceiver_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblInternalAssignmentReceiver_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL,
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblInternalAssignmentReceiver] ADD CONSTRAINT [PK_tblInternalAssignmentReceiver] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblInternalAssignmentReceiver] ADD CONSTRAINT [IX_tblInternalAssignmentReceiver] UNIQUE NONCLUSTERED ([fldReceiverComisionId], [fldAssignmentID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblInternalAssignmentReceiver] ADD CONSTRAINT [FK_tblInternalAssignmentReceiver_tblAssignment] FOREIGN KEY ([fldAssignmentID]) REFERENCES [Auto].[tblAssignment] ([fldID])
GO
ALTER TABLE [Auto].[tblInternalAssignmentReceiver] ADD CONSTRAINT [FK_tblInternalAssignmentReceiver_tblAssignmentStatus] FOREIGN KEY ([fldAssignmentStatusId]) REFERENCES [Auto].[tblAssignmentStatus] ([fldID])
GO
ALTER TABLE [Auto].[tblInternalAssignmentReceiver] ADD CONSTRAINT [FK_tblInternalAssignmentReceiver_tblAssignmentType] FOREIGN KEY ([fldAssignmentTypeID]) REFERENCES [Auto].[tblAssignmentType] ([fldID])
GO
ALTER TABLE [Auto].[tblInternalAssignmentReceiver] ADD CONSTRAINT [FK_tblInternalAssignmentReceiver_tblBox] FOREIGN KEY ([fldBoxId]) REFERENCES [Auto].[tblBox] ([fldID])
GO
ALTER TABLE [Auto].[tblInternalAssignmentReceiver] ADD CONSTRAINT [FK_tblInternalAssignmentReceiver_tblCommision] FOREIGN KEY ([fldReceiverComisionId]) REFERENCES [Auto].[tblCommision] ([fldID])
GO
ALTER TABLE [Auto].[tblInternalAssignmentReceiver] ADD CONSTRAINT [FK_tblInternalAssignmentReceiver_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblInternalAssignmentReceiver] ADD CONSTRAINT [FK_tblInternalAssignmentReceiver_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
