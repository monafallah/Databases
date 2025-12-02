CREATE TABLE [BUD].[tblCodingBudje_Header]
(
[fldHedaerId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCodingBudje_Header_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblCodingBudje_Header] ADD CONSTRAINT [PK_tblCodingBudje_Header] PRIMARY KEY CLUSTERED ([fldHedaerId]) ON [PRIMARY]
GO
