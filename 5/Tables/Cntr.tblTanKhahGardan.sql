CREATE TABLE [Cntr].[tblTanKhahGardan]
(
[fldId] [int] NOT NULL,
[fldEmployeeId] [int] NOT NULL,
[fldStatus] [bit] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTanKhah_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTanKhah_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblTanKhahGardan] ADD CONSTRAINT [PK_tblTanKhahGardan] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblTanKhahGardan] ADD CONSTRAINT [FK_tblTanKhah_tblEmployee] FOREIGN KEY ([fldEmployeeId]) REFERENCES [Com].[tblEmployee] ([fldId])
GO
ALTER TABLE [Cntr].[tblTanKhahGardan] ADD CONSTRAINT [FK_tblTanKhah_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Cntr].[tblTanKhahGardan] ADD CONSTRAINT [FK_tblTanKhah_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
