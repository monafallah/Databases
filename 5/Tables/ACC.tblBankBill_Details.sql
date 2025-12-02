CREATE TABLE [ACC].[tblBankBill_Details]
(
[fldId] [int] NOT NULL IDENTITY(1, 1),
[fldHedearId] [int] NOT NULL,
[fldBedehkar] [bigint] NOT NULL,
[fldBestankar] [bigint] NOT NULL,
[fldMandeh] [bigint] NOT NULL,
[fldTarikh] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTime] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldCodePeygiri] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Table_1_fldDesc] DEFAULT (''),
[fldBankId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblBankBill_Details] ADD CONSTRAINT [PK_tblBankBill_Details] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblBankBill_Details] ON [ACC].[tblBankBill_Details] ([fldBankId], [fldCodePeygiri], [fldTarikh], [fldBedehkar], [fldBestankar]) WITH (IGNORE_DUP_KEY=ON) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblBankBill_Details] WITH NOCHECK ADD CONSTRAINT [FK_tblBankBill_Details_tblBank] FOREIGN KEY ([fldBankId]) REFERENCES [Com].[tblBank] ([fldId])
GO
ALTER TABLE [ACC].[tblBankBill_Details] WITH NOCHECK ADD CONSTRAINT [FK_tblBankBill_Details_tblBankBill_Header] FOREIGN KEY ([fldHedearId]) REFERENCES [ACC].[tblBankBill_Header] ([fldId])
GO
