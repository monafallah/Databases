CREATE TABLE [ACC].[tblBankTemplate_Header]
(
[fldId] [int] NOT NULL,
[fldNamePattern] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldStartRow] [smallint] NOT NULL,
[fldDesc] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblBankTemplate_Header_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblBankTemplate_Header_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldFileId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblBankTemplate_Header] ADD CONSTRAINT [PK_tblBankTemplate_Header] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblBankTemplate_Header] ADD CONSTRAINT [FK_tblBankTemplate_Header_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [ACC].[tblBankTemplate_Header] ADD CONSTRAINT [FK_tblBankTemplate_Header_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
