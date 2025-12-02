CREATE TABLE [Pay].[tblEtelaatEydi]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldDayCount] [int] NOT NULL CONSTRAINT [DF_tblEtelaatEydi_fldDayCount] DEFAULT ((0)),
[fldKosurat] [int] NOT NULL CONSTRAINT [DF_tblEtelaatEydi_fldKosurat] DEFAULT ((0)),
[fldNobatePardakht] [tinyint] NOT NULL CONSTRAINT [DF_tblEtelaatEydi_fldNobatePardakht] DEFAULT ((1)),
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblEtelaatEydi_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblEtelaatEydi_fldDesc] DEFAULT (''),
[fldFlag] [bit] NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblEtelaatEydi] ADD CONSTRAINT [PK_tblEtelaatEydi] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblEtelaatEydi] ADD CONSTRAINT [FK_tblEtelaatEydi_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Pay].[tblEtelaatEydi] ADD CONSTRAINT [FK_tblEtelaatEydi_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
