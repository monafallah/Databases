CREATE TABLE [Com].[tblInputInfo]
(
[fldId] [int] NOT NULL,
[fldDateTime] [datetime] NOT NULL,
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMACAddress] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldLoginType] [bit] NOT NULL CONSTRAINT [DF_tblInputInfo_fldLoginType] DEFAULT ((1)),
[fldUserID] [int] NOT NULL CONSTRAINT [DF_tblInputInfo_fldUserID] DEFAULT ((1)),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblInputInfo_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblInputInfo_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblInputInfo] ADD CONSTRAINT [PK_tblInputInfo] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
