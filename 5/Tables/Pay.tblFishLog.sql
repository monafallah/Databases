CREATE TABLE [Pay].[tblFishLog]
(
[fldId] [int] NOT NULL,
[fldType] [tinyint] NOT NULL,
[fldPersonalId] [int] NULL,
[fldOrganId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldMonth] [tinyint] NOT NULL,
[fldNobatPardakht] [tinyint] NOT NULL CONSTRAINT [DF_Table_1_fldDesc] DEFAULT (''),
[fldFilterType] [tinyint] NULL,
[fldFishType] [tinyint] NULL,
[fldCostCenterId] [int] NULL,
[fldMahaleKhedmat] [int] NULL,
[fldCalcType] [tinyint] NOT NULL,
[fldMostamar] [tinyint] NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFishLog_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldQRCode] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblFishLog] ADD CONSTRAINT [PK_tblFishLog] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
