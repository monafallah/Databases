CREATE TABLE [Cntr].[tblTankhah_Group]
(
[fldId] [int] NOT NULL,
[fldTankhahId] [int] NOT NULL,
[fldTitle] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTankhah_Group_fldIP] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTankhah_Group_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblTankhah_Group] ADD CONSTRAINT [PK_tblTankhah_Group] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblTankhah_Group] ADD CONSTRAINT [FK_tblTankhah_Group_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Cntr].[tblTankhah_Group] ADD CONSTRAINT [FK_tblTankhah_Group_tblTanKhahGardan] FOREIGN KEY ([fldTankhahId]) REFERENCES [Cntr].[tblTanKhahGardan] ([fldId])
GO
ALTER TABLE [Cntr].[tblTankhah_Group] ADD CONSTRAINT [FK_tblTankhah_Group_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
