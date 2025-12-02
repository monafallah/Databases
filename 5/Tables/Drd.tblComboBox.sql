CREATE TABLE [Drd].[tblComboBox]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblComboBox_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblComboBox_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblComboBox] ADD CONSTRAINT [CK_tblComboBox] CHECK ((len([fldTitle])>=(2)))
GO
ALTER TABLE [Drd].[tblComboBox] ADD CONSTRAINT [PK_tblComboBox] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblComboBox] ADD CONSTRAINT [IX_tblComboBox] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblComboBox] ADD CONSTRAINT [FK_tblComboBox_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
