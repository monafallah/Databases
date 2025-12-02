CREATE TABLE [Prs].[tblSavabeghJebhe_Personal]
(
[fldId] [int] NOT NULL,
[fldItemId] [int] NOT NULL,
[fldPrsPersonalId] [int] NOT NULL,
[fldAzTarikh] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTaTarikh] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSavabeghJebhe_Personal_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblSavabeghJebhe_Personal_fldDate] DEFAULT (getdate())
) ON [Personeli] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Prs].[tblSavabeghJebhe_Personal] ADD CONSTRAINT [PK_tblSavabeghJebhe_Personal] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblSavabeghJebhe_Personal] ADD CONSTRAINT [FK_tblSavabeghJebhe_Personal_Prs_tblPersonalInfo] FOREIGN KEY ([fldPrsPersonalId]) REFERENCES [Prs].[Prs_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Prs].[tblSavabeghJebhe_Personal] ADD CONSTRAINT [FK_tblSavabeghJebhe_Personal_tblSavabeghJebhe_Items] FOREIGN KEY ([fldItemId]) REFERENCES [Prs].[tblSavabeghJebhe_Items] ([fldId])
GO
ALTER TABLE [Prs].[tblSavabeghJebhe_Personal] ADD CONSTRAINT [FK_tblSavabeghJebhe_Personal_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
