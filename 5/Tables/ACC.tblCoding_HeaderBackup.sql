CREATE TABLE [ACC].[tblCoding_HeaderBackup]
(
[fldId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL,
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCoding_HeaderBackup] ADD CONSTRAINT [PK_tblCoding_Headerb] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
