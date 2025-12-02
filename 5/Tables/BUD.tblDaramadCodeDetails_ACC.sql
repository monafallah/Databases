CREATE TABLE [BUD].[tblDaramadCodeDetails_ACC]
(
[fldId] [int] NOT NULL,
[fldCodingAcc_DetailsId] [int] NOT NULL,
[fldType] [tinyint] NOT NULL,
[fldTypeID] [int] NOT NULL,
[fldUserId] [int] NOT NULL CONSTRAINT [DF_tblDaramadCodeDetails_ACC_fldUserId] DEFAULT ((1)),
[fldIp] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblDaramadCodeDetails_ACC_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblDaramadCodeDetails_ACC] ADD CONSTRAINT [PK_tblDaramadCodeDetails_ACC] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblDaramadCodeDetails_ACC] ADD CONSTRAINT [FK_tblDaramadCodeDetails_ACC_tblCoding_Details] FOREIGN KEY ([fldCodingAcc_DetailsId]) REFERENCES [ACC].[tblCoding_Details] ([fldId])
GO
ALTER TABLE [BUD].[tblDaramadCodeDetails_ACC] ADD CONSTRAINT [FK_tblDaramadCodeDetails_ACC_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
