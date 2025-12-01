CREATE TABLE [dbo].[tblTicketPermission]
(
[fldId] [int] NOT NULL,
[fldCategoryId] [int] NOT NULL,
[fldTicketUserId] [int] NOT NULL,
[fldSee] [bit] NOT NULL,
[fldAnswer] [bit] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTicketPermission_fldDesc] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblTicketPermission] ADD CONSTRAINT [PK_tblTicketPermission] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblTicketPermission] ADD CONSTRAINT [FK_tblTicketPermission_tblTicketCategory] FOREIGN KEY ([fldCategoryId]) REFERENCES [dbo].[tblTicketCategory] ([fldId])
GO
ALTER TABLE [dbo].[tblTicketPermission] ADD CONSTRAINT [FK_tblTicketPermission_tblUser1] FOREIGN KEY ([fldTicketUserId]) REFERENCES [dbo].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'دسترسی گفتگوها', 'SCHEMA', N'dbo', 'TABLE', N'tblTicketPermission', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'پاسخ', 'SCHEMA', N'dbo', 'TABLE', N'tblTicketPermission', 'COLUMN', N'fldAnswer'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد لیست گفتگوها', 'SCHEMA', N'dbo', 'TABLE', N'tblTicketPermission', 'COLUMN', N'fldCategoryId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblTicketPermission', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد', 'SCHEMA', N'dbo', 'TABLE', N'tblTicketPermission', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نمایش', 'SCHEMA', N'dbo', 'TABLE', N'tblTicketPermission', 'COLUMN', N'fldSee'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربر تیکت', 'SCHEMA', N'dbo', 'TABLE', N'tblTicketPermission', 'COLUMN', N'fldTicketUserId'
GO
