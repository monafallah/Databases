CREATE TABLE [dbo].[tblCalcHeader]
(
[fldId] [int] NOT NULL IDENTITY(1, 1),
[fldYear] [smallint] NOT NULL,
[fldMonth] [tinyint] NOT NULL,
[fldNobatPardakhtId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldStatus] [tinyint] NOT NULL,
[fldIp] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [smalldatetime] NOT NULL,
[fldDesc] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldCalcType] [tinyint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblCalcHeader] ADD CONSTRAINT [PK_tblCalcHeader] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
