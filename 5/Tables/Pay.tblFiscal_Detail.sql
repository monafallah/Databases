CREATE TABLE [Pay].[tblFiscal_Detail]
(
[fldId] [int] NOT NULL,
[fldFiscalHeaderId] [int] NOT NULL,
[fldAmountFrom] [int] NOT NULL,
[fldAmountTo] [int] NOT NULL,
[fldPercentTaxOnWorkers] [decimal] (8, 4) NOT NULL CONSTRAINT [DF_tblFiscal_Detail_fldPercentTaxOnWorkers] DEFAULT ((0)),
[fldTaxationOfEmployees] [decimal] (8, 4) NOT NULL CONSTRAINT [DF_tblFiscal_Detail_fldTaxationOfEmployees] DEFAULT ((0)),
[fldTax] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFiscal_Detail_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFiscal_Detail_fldDesc] DEFAULT ('')
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblFiscal_Detail] ADD CONSTRAINT [PK_tblFiscal_Detail] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblFiscal_Detail] WITH NOCHECK ADD CONSTRAINT [FK_tblFiscal_Detail_tblFiscal_Header] FOREIGN KEY ([fldFiscalHeaderId]) REFERENCES [Pay].[tblFiscal_Header] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Pay].[tblFiscal_Detail] ADD CONSTRAINT [FK_tblFiscal_Detail_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
