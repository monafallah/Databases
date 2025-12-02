CREATE TABLE [Auto].[tblInternalLetterReceiver]
(
[fldID] [int] NOT NULL,
[fldLetterId] [bigint] NULL,
[fldMessageId] [int] NULL,
[fldReceiverComisionId] [int] NOT NULL,
[fldAssignmentStatusId] [int] NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblInternalLetterReceiver_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblInternalLetterReceiver_fldDesc] DEFAULT (''),
[fldOrganId] [int] NOT NULL,
[fldIP] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblInternalLetterReceiver] ADD CONSTRAINT [PK_tblInternalLetterReceiver] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblInternalLetterReceiver] ADD CONSTRAINT [FK_tblInternalLetterReceiver_tblAssignmentStatus] FOREIGN KEY ([fldAssignmentStatusId]) REFERENCES [Auto].[tblAssignmentStatus] ([fldID])
GO
ALTER TABLE [Auto].[tblInternalLetterReceiver] ADD CONSTRAINT [FK_tblInternalLetterReceiver_tblCommision] FOREIGN KEY ([fldReceiverComisionId]) REFERENCES [Auto].[tblCommision] ([fldID])
GO
ALTER TABLE [Auto].[tblInternalLetterReceiver] ADD CONSTRAINT [FK_tblInternalLetterReceiver_tblLetter] FOREIGN KEY ([fldLetterId]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblInternalLetterReceiver] ADD CONSTRAINT [FK_tblInternalLetterReceiver_tblMessage] FOREIGN KEY ([fldMessageId]) REFERENCES [Auto].[tblMessage] ([fldId])
GO
ALTER TABLE [Auto].[tblInternalLetterReceiver] ADD CONSTRAINT [FK_tblInternalLetterReceiver_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Auto].[tblInternalLetterReceiver] ADD CONSTRAINT [FK_tblInternalLetterReceiver_tblUser1] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
