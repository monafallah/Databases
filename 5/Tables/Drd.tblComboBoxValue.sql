CREATE TABLE [Drd].[tblComboBoxValue]
(
[fldId] [int] NOT NULL,
[fldComboBoxId] [int] NOT NULL,
[fldTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldValue] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblComboBoxValue_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblComboBoxValue_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblComboBoxValue] ADD CONSTRAINT [CK_tblComboBoxValue] CHECK ((len([fldTitle])>=(2)))
GO
ALTER TABLE [Drd].[tblComboBoxValue] ADD CONSTRAINT [PK_tblComboBoxValue] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblComboBoxValue] ADD CONSTRAINT [IX_tblComboBoxValue_3] UNIQUE NONCLUSTERED ([fldComboBoxId], [fldTitle], [fldValue]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblComboBoxValue] ADD CONSTRAINT [FK_tblComboBoxValue_tblComboBox] FOREIGN KEY ([fldComboBoxId]) REFERENCES [Drd].[tblComboBox] ([fldId])
GO
ALTER TABLE [Drd].[tblComboBoxValue] ADD CONSTRAINT [FK_tblComboBoxValue_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
