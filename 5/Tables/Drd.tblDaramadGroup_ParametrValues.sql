CREATE TABLE [Drd].[tblDaramadGroup_ParametrValues]
(
[fldId] [int] NOT NULL,
[fldElamAvarezId] [int] NOT NULL,
[fldParametrGroupDaramadId] [int] NOT NULL,
[fldValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblGroupDaramad_ParametrValues_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblGroupDaramad_ParametrValues_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblDaramadGroup_ParametrValues] ADD CONSTRAINT [PK_tblGroupDaramad_ParametrValues] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblDaramadGroup_ParametrValues] ADD CONSTRAINT [FK_tblDaramadGroup_ParametrValues_tblDaramadGroup_Parametr] FOREIGN KEY ([fldParametrGroupDaramadId]) REFERENCES [Drd].[tblDaramadGroup_Parametr] ([fldId])
GO
ALTER TABLE [Drd].[tblDaramadGroup_ParametrValues] ADD CONSTRAINT [FK_tblDaramadGroup_ParametrValues_tblElamAvarez] FOREIGN KEY ([fldElamAvarezId]) REFERENCES [Drd].[tblElamAvarez] ([fldId])
GO
ALTER TABLE [Drd].[tblDaramadGroup_ParametrValues] ADD CONSTRAINT [FK_tblGroupDaramad_ParametrValues_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
