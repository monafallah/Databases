CREATE TABLE [Auto].[tblAssignment]
(
[fldID] [int] NOT NULL,
[fldLetterID] [bigint] NULL,
[fldMessageId] [int] NULL,
[fldAssignmentDate] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAnswerDate] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldSourceAssId] [int] NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblAssignment_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_tblAssignment_fldDesc] DEFAULT (''),
[fldOrganId] [int] NOT NULL,
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblAssignment] ADD CONSTRAINT [PK_tblAssignment] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblAssignment] ADD CONSTRAINT [FK_tblAssignment_tblAssignment1] FOREIGN KEY ([fldSourceAssId]) REFERENCES [Auto].[tblAssignment] ([fldID])
GO
ALTER TABLE [Auto].[tblAssignment] ADD CONSTRAINT [FK_tblAssignment_tblLetter] FOREIGN KEY ([fldLetterID]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblAssignment] ADD CONSTRAINT [FK_tblAssignment_tblMessage] FOREIGN KEY ([fldMessageId]) REFERENCES [Auto].[tblMessage] ([fldId])
GO
ALTER TABLE [Auto].[tblAssignment] ADD CONSTRAINT [FK_tblAssignment_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblAssignment] ADD CONSTRAINT [FK_tblAssignment_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
