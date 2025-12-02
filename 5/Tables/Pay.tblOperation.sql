CREATE TABLE [Pay].[tblOperation]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblOperation_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblOperation_fldDate] DEFAULT (getdate())
) ON [PayRoll] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblOperation] ADD CONSTRAINT [PK_tblOperation] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblOperation] ADD CONSTRAINT [FK_tblOperation_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
