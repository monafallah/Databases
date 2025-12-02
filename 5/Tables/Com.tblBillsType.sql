CREATE TABLE [Com].[tblBillsType]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (200) COLLATE Persian_100_CI_AI NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblBillsType_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblBillsType_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER DeleteTriggerBillsType ON RasaNewFMS.Com.tblBillsType
FOR DELETE
AS
BEGIN

    SET NOCOUNT ON;

    IF EXISTS (
        SELECT *
        FROM deleted
        WHERE fldId in (select fldSourceId from ACC.tblCase where fldSourceId=deleted.fldId and fldCaseTypeId=4)
    )
    BEGIN
        ROLLBACK;
        THROW 50001, 'Cannot delete,conflict ACC.tblCase, fldSourceId column', 1;
    END
END;
GO
ALTER TABLE [Com].[tblBillsType] ADD CONSTRAINT [PK_tblBillsType] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblBillsType] ADD CONSTRAINT [IX_tblBillsType] UNIQUE NONCLUSTERED ([fldName]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblBillsType] ADD CONSTRAINT [FK_tblBillsType_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
