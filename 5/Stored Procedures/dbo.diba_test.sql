SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [dbo].[diba_test]
as
begin
	DECLARE @T TABLE
	(
			[fldsh] [int] NOT NULL,
			[fldName] [nvarchar](50) NULL,
			[fldfamily] [nvarchar](50) NOT NULL,
			[fldmobile] [bigint] NULL,
			[flddate] [datetime] NULL,
			[fldid] [int] IDENTITY(100,1) NOT NULL
	)
	DECLARE @sql NVARCHAR(100)='select * from rabieetest.dbo.tbltest'
	insert into @t
	EXEC sp_executesql @sql
end
GO
