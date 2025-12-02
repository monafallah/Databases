CREATE TABLE [Pay].[tblDisket]
(
[fldId] [int] NOT NULL,
[fldMarhale] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikh] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTedad] [int] NOT NULL,
[fldType] [bit] NOT NULL,
[fldJam] [bigint] NULL,
[fldTypePardakht] [tinyint] NOT NULL,
[fldShobeCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFileId] [int] NOT NULL,
[fldNameFile] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldBankFixId] [int] NOT NULL,
[fldNameShobe] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblDisket_fldNameShobe] DEFAULT (''),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL,
[fldTimeEdit] [timestamp] NOT NULL,
[fldEdit] AS (CONVERT([bigint],[fldTimeEdit],(0))) PERSISTED,
[fldOrganId] [int] NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblDisket] ADD CONSTRAINT [PK_tblDisket] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblDisket] ADD CONSTRAINT [FK_tblDisket_Pay_tblBank] FOREIGN KEY ([fldBankFixId]) REFERENCES [Com].[tblBank] ([fldId])
GO
ALTER TABLE [Pay].[tblDisket] ADD CONSTRAINT [FK_tblDisket_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [Pay].[tblDisket] ADD CONSTRAINT [FK_tblDisket_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Pay].[tblDisket] ADD CONSTRAINT [FK_tblDisket_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
