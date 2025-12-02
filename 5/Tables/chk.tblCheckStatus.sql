CREATE TABLE [chk].[tblCheckStatus]
(
[fldId] [int] NOT NULL,
[fldSodorCheckId] [int] NULL,
[fldCheckVaredeId] [int] NULL,
[fldAghsatId] [int] NULL,
[fldvaziat] [tinyint] NOT NULL,
[fldTarikh] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserID] [int] NOT NULL CONSTRAINT [DF_tblCheckStatus_fldUserID] DEFAULT ((1)),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCheckStatus_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCheckStatus_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [chk].[tblCheckStatus] ADD CONSTRAINT [PK_tblCheckStatus] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [chk].[tblCheckStatus] ADD CONSTRAINT [FK_tblCheckStatus_tblAghsatCheckAmani] FOREIGN KEY ([fldAghsatId]) REFERENCES [chk].[tblAghsatCheckAmani] ([fldId])
GO
ALTER TABLE [chk].[tblCheckStatus] ADD CONSTRAINT [FK_tblCheckStatus_tblCheck1] FOREIGN KEY ([fldCheckVaredeId]) REFERENCES [Drd].[tblCheck] ([fldId])
GO
ALTER TABLE [chk].[tblCheckStatus] ADD CONSTRAINT [FK_tblCheckStatus_tblSodorCheck] FOREIGN KEY ([fldSodorCheckId]) REFERENCES [chk].[tblSodorCheck] ([fldId])
GO
ALTER TABLE [chk].[tblCheckStatus] ADD CONSTRAINT [FK_tblCheckStatus_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
