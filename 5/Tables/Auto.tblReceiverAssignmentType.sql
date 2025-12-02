CREATE TABLE [Auto].[tblReceiverAssignmentType]
(
[fldID] [int] NOT NULL,
[fldAssignmentID] [int] NOT NULL,
[fldReceiverComisionID] [int] NOT NULL,
[fldAssignmentStatusID] [int] NOT NULL,
[fldAssignmentTypeID] [int] NOT NULL,
[fldBoxID] [int] NOT NULL,
[fldLetterReadDate] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShowTypeT_F] [bit] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblReceiverAssignmentType_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblReceiverAssignmentType_fldDesc] DEFAULT (''),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblReceiverAssignmentType] ADD CONSTRAINT [PK_tblReceiverAssignmentType] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblReceiverAssignmentType] ADD CONSTRAINT [FK_tblReceiverAssignmentType_tblAssignment] FOREIGN KEY ([fldAssignmentID]) REFERENCES [Auto].[tblAssignment] ([fldID])
GO
ALTER TABLE [Auto].[tblReceiverAssignmentType] ADD CONSTRAINT [FK_tblReceiverAssignmentType_tblAssignmentStatus] FOREIGN KEY ([fldAssignmentStatusID]) REFERENCES [Auto].[tblAssignmentStatus] ([fldID])
GO
ALTER TABLE [Auto].[tblReceiverAssignmentType] ADD CONSTRAINT [FK_tblReceiverAssignmentType_tblAssignmentType] FOREIGN KEY ([fldAssignmentTypeID]) REFERENCES [Auto].[tblAssignmentType] ([fldID])
GO
ALTER TABLE [Auto].[tblReceiverAssignmentType] ADD CONSTRAINT [FK_tblReceiverAssignmentType_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblReceiverAssignmentType] ADD CONSTRAINT [FK_tblReceiverAssignmentType_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
