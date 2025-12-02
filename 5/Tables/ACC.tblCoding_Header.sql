CREATE TABLE [ACC].[tblCoding_Header]
(
[fldId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCoding_Header_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCoding_Header_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCoding_Header] ADD CONSTRAINT [PK_tblCoding_Header] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCoding_Header] ADD CONSTRAINT [IX_tblCoding_Header] UNIQUE NONCLUSTERED ([fldOrganId], [fldYear]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCoding_Header] ADD CONSTRAINT [FK_tblCoding_Header_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [ACC].[tblCoding_Header] ADD CONSTRAINT [FK_tblCoding_Header_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
