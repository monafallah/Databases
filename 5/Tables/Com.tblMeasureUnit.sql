CREATE TABLE [Com].[tblMeasureUnit]
(
[fldId] [int] NOT NULL,
[fldNameVahed] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblVahedeAndazegiri_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblVahedeAndazegiri_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblMeasureUnit] ADD CONSTRAINT [CK_tblMeasureUnit] CHECK ((len([fldNameVahed])>=(2)))
GO
ALTER TABLE [Com].[tblMeasureUnit] ADD CONSTRAINT [PK_tblVahedeAndazegiri] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblMeasureUnit] ADD CONSTRAINT [IX_tblMeasureUnit] UNIQUE NONCLUSTERED ([fldNameVahed]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblMeasureUnit] ADD CONSTRAINT [FK_tblMeasureUnit_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
