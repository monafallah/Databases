CREATE TABLE [Auto].[tblTabagheBandi]
(
[fldID] [int] NOT NULL,
[fldName] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPID] [int] NULL,
[fldComisionID] [int] NOT NULL,
[fldUserID] [int] NOT NULL,
[fldOrganID] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTabagheBandi_fldDesc] DEFAULT (''),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTabagheBandi_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblTabagheBandi] ADD CONSTRAINT [PK_tblTabagheBandi] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblTabagheBandi] ADD CONSTRAINT [FK_tblTabagheBandi_tblCommision] FOREIGN KEY ([fldComisionID]) REFERENCES [Auto].[tblCommision] ([fldID])
GO
ALTER TABLE [Auto].[tblTabagheBandi] ADD CONSTRAINT [FK_tblTabagheBandi_tblOrganization] FOREIGN KEY ([fldOrganID]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblTabagheBandi] ADD CONSTRAINT [FK_tblTabagheBandi_tblTabagheBandi] FOREIGN KEY ([fldPID]) REFERENCES [Auto].[tblTabagheBandi] ([fldID])
GO
ALTER TABLE [Auto].[tblTabagheBandi] ADD CONSTRAINT [FK_tblTabagheBandi_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
