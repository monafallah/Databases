CREATE TABLE [Com].[tblSMSSetting]
(
[fldId] [int] NOT NULL,
[fldUserName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPassword] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShomareKhat] [nvarchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIP] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSMSSetting_fldIP] DEFAULT (N'::1'),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSMSSetting_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblSMSSetting_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblSMSSetting] ADD CONSTRAINT [PK_tblSMSSetting] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
