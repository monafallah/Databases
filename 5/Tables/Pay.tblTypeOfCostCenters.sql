CREATE TABLE [Pay].[tblTypeOfCostCenters]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCostCenters_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCostCenters_fldDesc] DEFAULT ('')
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblTypeOfCostCenters] ADD CONSTRAINT [PK_tblCostCenters] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblTypeOfCostCenters] ADD CONSTRAINT [FK_tblTypeOfCostCenters_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
