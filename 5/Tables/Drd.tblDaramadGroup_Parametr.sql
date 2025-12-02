CREATE TABLE [Drd].[tblDaramadGroup_Parametr]
(
[fldId] [int] NOT NULL,
[fldDaramadGroupId] [int] NOT NULL,
[fldEnName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFnName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldStatus] [bit] NOT NULL CONSTRAINT [DF_tblDaramadGroup_Parametr_fldStatus] DEFAULT ((0)),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblDaramadGroup_Parametr_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblDaramadGroup_Parametr_fldDate] DEFAULT (getdate()),
[fldNoeField] [tinyint] NOT NULL,
[fldComboBoxId] [int] NULL,
[fldFormuleId] [int] NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblDaramadGroup_Parametr] ADD CONSTRAINT [PK_tblDaramadGroup_Parametr] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblDaramadGroup_Parametr] ADD CONSTRAINT [FK_tblDaramadGroup_Parametr_tblComboBox] FOREIGN KEY ([fldComboBoxId]) REFERENCES [Drd].[tblComboBox] ([fldId])
GO
ALTER TABLE [Drd].[tblDaramadGroup_Parametr] ADD CONSTRAINT [FK_tblDaramadGroup_Parametr_tblComputationFormula] FOREIGN KEY ([fldFormuleId]) REFERENCES [Com].[tblComputationFormula] ([fldId])
GO
ALTER TABLE [Drd].[tblDaramadGroup_Parametr] ADD CONSTRAINT [FK_tblDaramadGroup_Parametr_tblDaramadGroup_Parametr] FOREIGN KEY ([fldDaramadGroupId]) REFERENCES [Drd].[tblDaramadGroup] ([fldId])
GO
ALTER TABLE [Drd].[tblDaramadGroup_Parametr] ADD CONSTRAINT [FK_tblDaramadGroup_Parametr_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
