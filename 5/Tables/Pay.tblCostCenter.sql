CREATE TABLE [Pay].[tblCostCenter]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldReportTypeId] [int] NOT NULL,
[fldTypeOfCostCenterId] [int] NOT NULL,
[fldEmploymentCenterId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCostCenter_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCostCenter_fldDesc] DEFAULT (''),
[fldOrganId] [int] NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblCostCenter] ADD CONSTRAINT [PK_tblCostCenter] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblCostCenter] ADD CONSTRAINT [FK_tblCostCenter_Pay_tblReportType] FOREIGN KEY ([fldReportTypeId]) REFERENCES [Pay].[tblReportType] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Pay].[tblCostCenter] ADD CONSTRAINT [FK_tblCostCenter_Pay_tblTypeOfCostCenters] FOREIGN KEY ([fldTypeOfCostCenterId]) REFERENCES [Pay].[tblTypeOfCostCenters] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Pay].[tblCostCenter] ADD CONSTRAINT [FK_tblCostCenter_Pay_tblTypeOfEmploymentCenter] FOREIGN KEY ([fldEmploymentCenterId]) REFERENCES [Pay].[tblTypeOfEmploymentCenter] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Pay].[tblCostCenter] ADD CONSTRAINT [FK_tblCostCenter_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Pay].[tblCostCenter] ADD CONSTRAINT [FK_tblCostCenter_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
