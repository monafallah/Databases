CREATE TABLE [Pay].[tblInsuranceWorkshop]
(
[fldId] [int] NOT NULL,
[fldWorkShopName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldEmployerName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldWorkShopNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPersent] [decimal] (8, 4) NOT NULL,
[fldAddress] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_tblInsuranceWorkshop_fldAddress] DEFAULT (''),
[fldPeyman] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblInsuranceWorkshop_fldPeyman] DEFAULT ('000'),
[fldOrganId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblInsuranceWorkshop_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblInsuranceWorkshop_fldDesc] DEFAULT ('')
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblInsuranceWorkshop] ADD CONSTRAINT [PK_tblInsuranceWorkshop] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblInsuranceWorkshop] ADD CONSTRAINT [IX_tblInsuranceWorkshop] UNIQUE NONCLUSTERED ([fldWorkShopNum], [fldPeyman]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblInsuranceWorkshop] ADD CONSTRAINT [FK_tblInsuranceWorkshop_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Pay].[tblInsuranceWorkshop] ADD CONSTRAINT [FK_tblInsuranceWorkshop_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
