CREATE TABLE [ACC].[tblTypeHesab]
(
[fldId] [tinyint] NOT NULL,
[fldName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblTypeHesab] ADD CONSTRAINT [PK_tblTypeHesab] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblTypeHesab] ADD CONSTRAINT [FK_tblTypeHesab_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
