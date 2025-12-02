CREATE TABLE [Cntr].[tblFactorDetail]
(
[fldId] [int] NOT NULL,
[fldHeaderId] [int] NOT NULL,
[fldMablagh] [bigint] NOT NULL,
[fldMablaghMaliyat] [bigint] NOT NULL,
[fldCodingDetailId] [int] NOT NULL,
[fldSharhArtikl] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTax] [bit] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFactorDetail_fldIP] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFactorDetail_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblFactorDetail] ADD CONSTRAINT [PK_tblFactorDetail] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblFactorDetail] ADD CONSTRAINT [FK_tblFactorDetail_tblCoding_Details] FOREIGN KEY ([fldCodingDetailId]) REFERENCES [ACC].[tblCoding_Details] ([fldId])
GO
ALTER TABLE [Cntr].[tblFactorDetail] ADD CONSTRAINT [FK_tblFactorDetail_tblFactor] FOREIGN KEY ([fldHeaderId]) REFERENCES [Cntr].[tblFactor] ([fldId])
GO
ALTER TABLE [Cntr].[tblFactorDetail] ADD CONSTRAINT [FK_tblFactorDetail_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Cntr].[tblFactorDetail] ADD CONSTRAINT [FK_tblFactorDetail_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
