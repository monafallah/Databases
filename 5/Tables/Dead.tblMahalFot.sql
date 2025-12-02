CREATE TABLE [Dead].[tblMahalFot]
(
[fldId] [int] NOT NULL,
[fldNameMahal] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMahalFot_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMahalFot_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblMahalFot] ADD CONSTRAINT [PK_tblMahalFot] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblMahalFot] ADD CONSTRAINT [IX_tblMahalFot] UNIQUE NONCLUSTERED ([fldNameMahal]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblMahalFot] ADD CONSTRAINT [FK_tblMahalFot_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
