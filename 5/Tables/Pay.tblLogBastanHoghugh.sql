CREATE TABLE [Pay].[tblLogBastanHoghugh]
(
[fldId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldMonth] [tinyint] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldType] [tinyint] NOT NULL CONSTRAINT [DF_tblLogBastanHoghugh_fldType] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblLogBastanHoghugh_fldDate] DEFAULT (getdate()),
[fldIp] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldTypePardakht] [tinyint] NULL,
[fldNobatPardkht] [tinyint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblLogBastanHoghugh] ADD CONSTRAINT [PK_tblLogBastanHoghugh] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblLogBastanHoghugh] ADD CONSTRAINT [FK_tblLogBastanHoghugh_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Pay].[tblLogBastanHoghugh] ADD CONSTRAINT [FK_tblLogBastanHoghugh_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
