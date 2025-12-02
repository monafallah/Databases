CREATE TABLE [Auto].[tblBox]
(
[fldID] [int] NOT NULL,
[fldName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldComisionID] [int] NOT NULL,
[fldBoxTypeID] [int] NOT NULL,
[fldPID] [int] NULL,
[fldOrganID] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblBox_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblBox_fldDesc] DEFAULT (''),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblBox] ADD CONSTRAINT [PK_tblBox] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblBox] ADD CONSTRAINT [FK_tblBox_tblBox] FOREIGN KEY ([fldPID]) REFERENCES [Auto].[tblBox] ([fldID])
GO
ALTER TABLE [Auto].[tblBox] ADD CONSTRAINT [FK_tblBox_tblBoxType] FOREIGN KEY ([fldBoxTypeID]) REFERENCES [Auto].[tblBoxType] ([fldID])
GO
ALTER TABLE [Auto].[tblBox] ADD CONSTRAINT [FK_tblBox_tblCommision] FOREIGN KEY ([fldComisionID]) REFERENCES [Auto].[tblCommision] ([fldID])
GO
ALTER TABLE [Auto].[tblBox] ADD CONSTRAINT [FK_tblBox_tblOrganization] FOREIGN KEY ([fldOrganID]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblBox] ADD CONSTRAINT [FK_tblBox_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
