CREATE TABLE [Pay].[tblMaliyatDaraei]
(
[fldId] [int] NOT NULL IDENTITY(1, 1),
[fldCodeMeli] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldMonth] [tinyint] NOT NULL,
[fldMaliyat] [bigint] NOT NULL,
[fldNobatePardakht] [tinyint] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldIp] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMaliyatDaraei] ADD CONSTRAINT [PK_tblMaliyatDaraei] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
