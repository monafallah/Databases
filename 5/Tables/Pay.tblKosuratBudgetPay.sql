CREATE TABLE [Pay].[tblKosuratBudgetPay]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblKosuratBudgetPay] ADD CONSTRAINT [PK_tblKosuratBudgetPay] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
