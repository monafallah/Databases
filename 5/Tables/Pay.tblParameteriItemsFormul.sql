CREATE TABLE [Pay].[tblParameteriItemsFormul]
(
[fldId] [int] NOT NULL,
[fldParametrId] [int] NOT NULL,
[fldFormul] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblParameteriItemsFormul_fldFormul] DEFAULT (''),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblParameteriItemsFormul_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblParameteriItemsFormul_fldDate] DEFAULT (getdate())
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblParameteriItemsFormul] ADD CONSTRAINT [PK_tblFormul] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblParameteriItemsFormul] ADD CONSTRAINT [FK_tblParameteriItemsFormul_Pay_tblParametrs] FOREIGN KEY ([fldParametrId]) REFERENCES [Pay].[tblParametrs] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Pay].[tblParameteriItemsFormul] ADD CONSTRAINT [FK_tblParameteriItemsFormul_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
