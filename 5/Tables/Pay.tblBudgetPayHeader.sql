CREATE TABLE [Pay].[tblBudgetPayHeader]
(
[fldId] [int] NOT NULL,
[fldFiscalYearId] [int] NOT NULL,
[fldItemsHoghughiId] [int] NULL,
[fldParametrId] [int] NULL,
[fldkosuratBudgetPayId] [int] NULL,
[fldBudgetCode] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblBudgetPay_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblBudgetPay_fldDesc] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblBudgetPayHeader] ADD CONSTRAINT [PK_tblBudgetPay] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblBudgetPayHeader] ADD CONSTRAINT [FK_tblBudgetPay_tblItemsHoghughi] FOREIGN KEY ([fldItemsHoghughiId]) REFERENCES [Com].[tblItemsHoghughi] ([fldId])
GO
ALTER TABLE [Pay].[tblBudgetPayHeader] ADD CONSTRAINT [FK_tblBudgetPay_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Pay].[tblBudgetPayHeader] ADD CONSTRAINT [FK_tblBudgetPayHeader_tblCoding_Details] FOREIGN KEY ([fldBudgetCode]) REFERENCES [ACC].[tblCoding_Details] ([fldId])
GO
ALTER TABLE [Pay].[tblBudgetPayHeader] ADD CONSTRAINT [FK_tblBudgetPayHeader_tblFiscalYear] FOREIGN KEY ([fldFiscalYearId]) REFERENCES [ACC].[tblFiscalYear] ([fldId])
GO
ALTER TABLE [Pay].[tblBudgetPayHeader] ADD CONSTRAINT [FK_tblBudgetPayHeader_tblKosuratBudgetPay] FOREIGN KEY ([fldkosuratBudgetPayId]) REFERENCES [Pay].[tblKosuratBudgetPay] ([fldId])
GO
ALTER TABLE [Pay].[tblBudgetPayHeader] ADD CONSTRAINT [FK_tblBudgetPayHeader_tblParametrs] FOREIGN KEY ([fldParametrId]) REFERENCES [Pay].[tblParametrs] ([fldId])
GO
