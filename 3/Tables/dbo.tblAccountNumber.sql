CREATE TABLE [dbo].[tblAccountNumber]
(
[fldId] [int] NOT NULL,
[fldShobeId] [int] NOT NULL,
[fldAshkhasId] [int] NOT NULL,
[fldShomareHesab] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShomareSheba] [varchar] (27) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldCardNumber] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE Persian_100_CI_AI NOT NULL CONSTRAINT [DF_tblAccountNumber_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblAccountNumber_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblAccountNumber] ADD CONSTRAINT [CK_CardNumber] CHECK (([dbo].[fn_CheckValidCreditCard]([fldCardNumber])=(1)))
GO
ALTER TABLE [dbo].[tblAccountNumber] ADD CONSTRAINT [CK_IBAN] CHECK (([dbo].[FormatIBAN]([fldShomareSheba])=(1)))
GO
ALTER TABLE [dbo].[tblAccountNumber] ADD CONSTRAINT [PK_tblAccountNumber] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblAccountNumber] ADD CONSTRAINT [FK_tblAccountNumber_tblAshkhas] FOREIGN KEY ([fldAshkhasId]) REFERENCES [dbo].[tblAshkhas] ([fldId])
GO
ALTER TABLE [dbo].[tblAccountNumber] ADD CONSTRAINT [FK_tblAccountNumber_tblSHobe] FOREIGN KEY ([fldShobeId]) REFERENCES [dbo].[tblSHobe] ([fldId])
GO
ALTER TABLE [dbo].[tblAccountNumber] ADD CONSTRAINT [FK_tblAccountNumber_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [dbo].[tblUser] ([fldId])
GO
