CREATE TABLE [dbo].[tblTicketCategoryHistory]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldType] [bit] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NOT NULL,
[StartTime] [datetime2] NOT NULL,
[EndTime] [datetime2] NOT NULL,
[fldOrder] [int] NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ix_tblTicketCategoryHistory] ON [dbo].[tblTicketCategoryHistory] ([EndTime], [StartTime]) ON [PRIMARY]
GO
CREATE TABLE [dbo].[tblTicketCategory]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldType] [bit] NOT NULL CONSTRAINT [DF_tblTicketCategory_fldType] DEFAULT ((0)),
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTicketCategory_fldDesc] DEFAULT (''),
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NOT NULL,
[StartTime] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL CONSTRAINT [DF__tblTicket__Start__679F3DB8] DEFAULT (getutcdate()),
[EndTime] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL CONSTRAINT [DF__tblTicket__EndTi__689361F1] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')),
[fldOrder] [int] NULL,
PERIOD FOR SYSTEM_TIME (StartTime, EndTime),
CONSTRAINT [PK_tblTicketCategory] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[tblTicketCategoryHistory])
)
GO
ALTER TABLE [dbo].[tblTicketCategory] ADD CONSTRAINT [IX_tblTicketCategory] UNIQUE NONCLUSTERED ([fldTitle], [fldType]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblTicketCategory] ADD CONSTRAINT [FK_tblTicketCategory_tblInputInfo] FOREIGN KEY ([fldInputId]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'موضوع گفتگو', 'SCHEMA', N'dbo', 'TABLE', N'tblTicketCategory', NULL, NULL
GO
EXEC sp_addextendedproperty N'PersianName', N'موضوع گفتگو', 'SCHEMA', N'dbo', 'TABLE', N'tblTicketCategory', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblTicketCategory', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد', 'SCHEMA', N'dbo', 'TABLE', N'tblTicketCategory', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ترتیب', 'SCHEMA', N'dbo', 'TABLE', N'tblTicketCategory', 'COLUMN', N'fldOrder'
GO
EXEC sp_addextendedproperty N'MS_Description', N'فیلد مربوط به ویرایش', 'SCHEMA', N'dbo', 'TABLE', N'tblTicketCategory', 'COLUMN', N'fldTimeStamp'
GO
EXEC sp_addextendedproperty N'MS_Description', N'عنوان', 'SCHEMA', N'dbo', 'TABLE', N'tblTicketCategory', 'COLUMN', N'fldTitle'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نوع تیکت', 'SCHEMA', N'dbo', 'TABLE', N'tblTicketCategory', 'COLUMN', N'fldType'
GO
