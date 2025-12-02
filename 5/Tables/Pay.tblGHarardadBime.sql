CREATE TABLE [Pay].[tblGHarardadBime]
(
[fldId] [int] NOT NULL,
[fldNameBime] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblGHarardadBime_fldNameBime] DEFAULT (''),
[fldTarikhSHoro] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikhPayan] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMablagheBimeSHodeAsli] [int] NOT NULL CONSTRAINT [DF_tblGHarardadBime_fldMablagheBimeSHodeAsli] DEFAULT ((0)),
[fldMablaghe60Sal] [int] NOT NULL CONSTRAINT [DF_tblGHarardadBime_fldMablaghe60Sal] DEFAULT ((0)),
[fldMablaghe70Sal] [int] NOT NULL CONSTRAINT [DF_tblGHarardadBime_fldMablaghe70Sal] DEFAULT ((0)),
[fldMablagheBimeOmr] [int] NOT NULL CONSTRAINT [DF_tblGHarardadBime_fldMablagheBimeOmr] DEFAULT ((0)),
[fldMaxBimeAsli] [tinyint] NOT NULL CONSTRAINT [DF_tblGHarardadBime_fldMaxBimeAsli] DEFAULT ((6)),
[fldDarsadBimeOmr] [int] NOT NULL CONSTRAINT [DF_tblGHarardadBime_fldDarsadBimeOmr] DEFAULT ((0)),
[fldDarsadBimeTakmily] [int] NOT NULL CONSTRAINT [DF_tblGHarardadBime_fldDarsadBimeTakmily] DEFAULT ((0)),
[fldDarsadBime60Sal] [int] NOT NULL CONSTRAINT [DF_tblGHarardadBime_fldDarsadBime60Sal] DEFAULT ((0)),
[fldDarsadBime70Sal] [int] NOT NULL CONSTRAINT [DF_tblGHarardadBime_fldDarsadBime70Sal] DEFAULT ((0)),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblGHarardadBime_fldDate] DEFAULT (getdate()),
[fldMablagheBedonePoshesh] [int] NOT NULL CONSTRAINT [DF_tblGHarardadBime_fldMablaghe70Sal1] DEFAULT ((0)),
[fldDarsadBimeBedonePoshesh] [int] NOT NULL CONSTRAINT [DF_tblGHarardadBime_fldDarsadBime70Sal1] DEFAULT ((0))
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblGHarardadBime] ADD CONSTRAINT [PK_tblGHarardadBime] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblGHarardadBime] ADD CONSTRAINT [FK_tblGHarardadBime_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
