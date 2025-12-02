CREATE TABLE [Auto].[tblSubstitute]
(
[fldID] [int] NOT NULL,
[fldSenderComisionID] [int] NOT NULL,
[fldReceiverComisionID] [int] NOT NULL,
[fldStartDate] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldEndDate] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldStartTime] [time] NOT NULL,
[fldEndTime] [time] NOT NULL,
[fldIsSigner] [bit] NOT NULL,
[fldShowReceiverName] [bit] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblSubstitute_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSubstitute_fldDesc] DEFAULT (''),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblSubstitute] ADD CONSTRAINT [PK_tblSubstitute] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
