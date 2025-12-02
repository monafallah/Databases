CREATE TABLE [Pay].[tblSpecialPermission]
(
[fldId] [int] NOT NULL,
[fldUserSelectId] [int] NOT NULL,
[fldChartOrganId] [int] NOT NULL,
[fldOpertionId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSpecialPermission_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblSpecialPermission_fldDate] DEFAULT (getdate())
) ON [PayRoll] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblSpecialPermission] ADD CONSTRAINT [PK_tblSpecialPermission] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblSpecialPermission] ADD CONSTRAINT [FK_tblSpecialPermission_tblChartOrgan] FOREIGN KEY ([fldChartOrganId]) REFERENCES [Com].[tblChartOrgan] ([fldId])
GO
ALTER TABLE [Pay].[tblSpecialPermission] ADD CONSTRAINT [FK_tblSpecialPermission_tblOperation] FOREIGN KEY ([fldOpertionId]) REFERENCES [Pay].[tblOperation] ([fldId])
GO
ALTER TABLE [Pay].[tblSpecialPermission] ADD CONSTRAINT [FK_tblSpecialPermission_tblUser] FOREIGN KEY ([fldUserSelectId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Pay].[tblSpecialPermission] ADD CONSTRAINT [FK_tblSpecialPermission_tblUser1] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
