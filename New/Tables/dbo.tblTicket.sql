CREATE TABLE [dbo].[tblTicket]
(
[fldId] [int] NOT NULL,
[fldHTML] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTicketCategoryId] [int] NOT NULL CONSTRAINT [DF_tblTicket_fldTicketCategoryId] DEFAULT ((1)),
[fldAshkhasId] [int] NULL,
[fldSeenDate] [datetime] NULL,
[fldSeen] [bit] NOT NULL CONSTRAINT [DF_tblTicket_fldSeen] DEFAULT ((0)),
[fldFileId] [int] NULL,
[fldUserId] [int] NULL,
[fldDesc] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTicket_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTicket_fldDate] DEFAULT (getdate()),
[fldInputID] [int] NOT NULL,
[fldUserSeen] [int] NULL,
[fldSourceForwardId] [int] NULL,
[fldUserForwarded] [int] NULL,
[fldSourceReplyId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblTicket] ADD CONSTRAINT [PK_tblTicket] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblTicket] ADD CONSTRAINT [FK_tblTicket_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [dbo].[tblFile] ([fldId])
GO
ALTER TABLE [dbo].[tblTicket] ADD CONSTRAINT [FK_tblTicket_tblInputInfo] FOREIGN KEY ([fldInputID]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
ALTER TABLE [dbo].[tblTicket] ADD CONSTRAINT [FK_tblTicket_tblTicket] FOREIGN KEY ([fldSourceForwardId]) REFERENCES [dbo].[tblTicket] ([fldId])
GO
ALTER TABLE [dbo].[tblTicket] ADD CONSTRAINT [FK_tblTicket_tblTicket1] FOREIGN KEY ([fldSourceReplyId]) REFERENCES [dbo].[tblTicket] ([fldId])
GO
ALTER TABLE [dbo].[tblTicket] ADD CONSTRAINT [FK_tblTicket_tblTicketCategory] FOREIGN KEY ([fldTicketCategoryId]) REFERENCES [dbo].[tblTicketCategory] ([fldId])
GO
ALTER TABLE [dbo].[tblTicket] ADD CONSTRAINT [FK_tblTicket_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [dbo].[tblUser] ([fldId])
GO
ALTER TABLE [dbo].[tblTicket] ADD CONSTRAINT [FK_tblTicket_tblUser1] FOREIGN KEY ([fldUserSeen]) REFERENCES [dbo].[tblUser] ([fldId])
GO
ALTER TABLE [dbo].[tblTicket] ADD CONSTRAINT [FK_tblTicket_tblUser2] FOREIGN KEY ([fldUserForwarded]) REFERENCES [dbo].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'گفتگو ها', 'SCHEMA', N'dbo', 'TABLE', N'tblTicket', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد اشخاص', 'SCHEMA', N'dbo', 'TABLE', N'tblTicket', 'COLUMN', N'fldAshkhasId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ و زمان', 'SCHEMA', N'dbo', 'TABLE', N'tblTicket', 'COLUMN', N'fldDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblTicket', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد فایل', 'SCHEMA', N'dbo', 'TABLE', N'tblTicket', 'COLUMN', N'fldFileId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'متن', 'SCHEMA', N'dbo', 'TABLE', N'tblTicket', 'COLUMN', N'fldHTML'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد', 'SCHEMA', N'dbo', 'TABLE', N'tblTicket', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون ورود و خروج', 'SCHEMA', N'dbo', 'TABLE', N'tblTicket', 'COLUMN', N'fldInputID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نمایش', 'SCHEMA', N'dbo', 'TABLE', N'tblTicket', 'COLUMN', N'fldSeen'
GO
EXEC sp_addextendedproperty N'MS_Description', N'تارخ نمایش', 'SCHEMA', N'dbo', 'TABLE', N'tblTicket', 'COLUMN', N'fldSeenDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد لیست گفتگوها', 'SCHEMA', N'dbo', 'TABLE', N'tblTicket', 'COLUMN', N'fldTicketCategoryId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربر', 'SCHEMA', N'dbo', 'TABLE', N'tblTicket', 'COLUMN', N'fldUserId'
GO
