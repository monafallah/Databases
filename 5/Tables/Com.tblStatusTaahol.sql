CREATE TABLE [Com].[tblStatusTaahol]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTaaholBazneshastegi] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblStatusTaahol] ADD CONSTRAINT [PK_tblStatusTaahol] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblStatusTaahol] ADD CONSTRAINT [IX_tblStatusTaahol] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
