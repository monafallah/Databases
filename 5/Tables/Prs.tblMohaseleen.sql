CREATE TABLE [Prs].[tblMohaseleen]
(
[fldId] [int] NOT NULL,
[fldAfradTahtePoosheshId] [int] NOT NULL,
[fldTarikh] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMohaseleen_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Prs].[tblMohaseleen] ADD CONSTRAINT [PK_tblMohaseleen] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Prs].[tblMohaseleen] ADD CONSTRAINT [IX_tblMohaseleen] UNIQUE NONCLUSTERED ([fldAfradTahtePoosheshId], [fldTarikh]) ON [PRIMARY]
GO
ALTER TABLE [Prs].[tblMohaseleen] ADD CONSTRAINT [FK_tblMohaseleen_tblAfradTahtePooshesh] FOREIGN KEY ([fldAfradTahtePoosheshId]) REFERENCES [Prs].[tblAfradTahtePooshesh] ([fldId])
GO
ALTER TABLE [Prs].[tblMohaseleen] ADD CONSTRAINT [FK_tblMohaseleen_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
