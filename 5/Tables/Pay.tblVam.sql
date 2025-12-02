CREATE TABLE [Pay].[tblVam]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldTarikhDaryaft] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTypeVam] [tinyint] NOT NULL,
[fldMablaghVam] [int] NOT NULL,
[fldStartDate] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldCount] [smallint] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldMandeVam] [int] NOT NULL,
[fldStatus] [bit] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblVam_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblVam_fldDesc] DEFAULT ('')
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblVam] ADD CONSTRAINT [PK_tblVam] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblVam] ADD CONSTRAINT [FK_tblVam_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Pay].[tblVam] ADD CONSTRAINT [FK_tblVam_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
