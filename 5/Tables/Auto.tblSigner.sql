CREATE TABLE [Auto].[tblSigner]
(
[fldId] [int] NOT NULL,
[fldLetterID] [bigint] NOT NULL,
[fldSignerComisionId] [int] NOT NULL,
[fldIndexerID] [int] NOT NULL,
[fldFirstSigner] [int] NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblSigner_fldDate] DEFAULT (getdate()),
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_tblSigner_fldDesc] DEFAULT (''),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblSigner] ADD CONSTRAINT [PK_tblSigner] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblSigner] ADD CONSTRAINT [FK_tblSigner_tblCommision] FOREIGN KEY ([fldSignerComisionId]) REFERENCES [Auto].[tblCommision] ([fldID])
GO
ALTER TABLE [Auto].[tblSigner] ADD CONSTRAINT [FK_tblSigner_tblCommision1] FOREIGN KEY ([fldFirstSigner]) REFERENCES [Auto].[tblCommision] ([fldID])
GO
ALTER TABLE [Auto].[tblSigner] ADD CONSTRAINT [FK_tblSigner_tblLetter] FOREIGN KEY ([fldLetterID]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblSigner] ADD CONSTRAINT [FK_tblSigner_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblSigner] ADD CONSTRAINT [FK_tblSigner_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
