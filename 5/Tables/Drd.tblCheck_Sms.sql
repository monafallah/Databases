CREATE TABLE [Drd].[tblCheck_Sms]
(
[fldId] [int] NOT NULL,
[fldCheckId] [int] NOT NULL,
[fldStatus] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCheck_Sms_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblCheck_Sms] ADD CONSTRAINT [PK_tblCheck_Sms] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblCheck_Sms] ADD CONSTRAINT [FK_tblCheck_Sms_tblCheck] FOREIGN KEY ([fldCheckId]) REFERENCES [Drd].[tblCheck] ([fldId])
GO
ALTER TABLE [Drd].[tblCheck_Sms] ADD CONSTRAINT [FK_tblCheck_Sms_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
