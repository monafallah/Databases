CREATE TABLE [Auto].[tblAshkhaseHoghoghiTitles]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAshkhasHoghoghiId] [int] NOT NULL,
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblAshkhaseHoghoghiTitles] ADD CONSTRAINT [PK_tblAshkhaseHoghoghiTitles] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblAshkhaseHoghoghiTitles] ADD CONSTRAINT [FK_tblAshkhaseHoghoghiTitles_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblAshkhaseHoghoghiTitles] ADD CONSTRAINT [FK_tblAshkhaseHoghoghiTitles_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
