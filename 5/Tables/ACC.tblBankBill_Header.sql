CREATE TABLE [ACC].[tblBankBill_Header]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShomareHesabId] [int] NOT NULL,
[fldFiscalYearId] [int] NOT NULL,
[fldJsonFile] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblBankBill_Header_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblBankBill_Header_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldPatternId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblBankBill_Header] ADD CONSTRAINT [PK_tblBankBill_Header] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblBankBill_Header] ADD CONSTRAINT [FK_tblBankBill_Header_tblBankTemplate_Header] FOREIGN KEY ([fldPatternId]) REFERENCES [ACC].[tblBankTemplate_Header] ([fldId])
GO
ALTER TABLE [ACC].[tblBankBill_Header] ADD CONSTRAINT [FK_tblBankBill_Header_tblFiscalYear] FOREIGN KEY ([fldFiscalYearId]) REFERENCES [ACC].[tblFiscalYear] ([fldId])
GO
ALTER TABLE [ACC].[tblBankBill_Header] ADD CONSTRAINT [FK_tblBankBill_Header_tblShomareHesabeOmoomi] FOREIGN KEY ([fldShomareHesabId]) REFERENCES [Com].[tblShomareHesabeOmoomi] ([fldId])
GO
ALTER TABLE [ACC].[tblBankBill_Header] ADD CONSTRAINT [FK_tblBankBill_Header_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
