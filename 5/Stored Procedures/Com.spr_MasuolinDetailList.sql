SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Com].[spr_MasuolinDetailList]
@fldHeaderId int
as

declare @temp as table(fldId INT,fldEmployeeId INT,fldNameEmployee nvarchar(200),fldOrganId INT,fldNameOrgan nvarchar(200),fldOrderId int)

    
 declare @I int=1
     while @I<=5
 begin
 insert into @temp
       
        select  ISNULL
					( (SELECT tblMasuolin_Detail.fldId
			FROM     tblMasuolin_Detail INNER JOIN
               Com.tblMasuolin ON tblMasuolin_Detail.fldMasuolinId = tblMasuolin.fldId
               where  tblMasuolin.fldId= @fldHeaderId and tblMasuolin_Detail.fldOrderId=@I),0),
		isnull((SELECT        tblMasuolin_Detail.fldEmployId
FROM            tblMasuolin_Detail INNER JOIN
                         tblMasuolin ON tblMasuolin_Detail.fldMasuolinId = tblMasuolin.fldId
               where  tblMasuolin.fldId= @fldHeaderId and tblMasuolin_Detail.fldOrderId=@I	) , 0) ,	   
		isnull((SELECT         tblEmployee.fldName+' '+ tblEmployee.fldFamily
FROM            tblMasuolin_Detail INNER JOIN
                         tblMasuolin ON tblMasuolin_Detail.fldMasuolinId = tblMasuolin.fldId INNER JOIN
                         tblEmployee ON tblMasuolin_Detail.fldEmployId = tblEmployee.fldId
               where  tblMasuolin.fldId= @fldHeaderId and tblMasuolin_Detail.fldOrderId=@I	) , ISNULL((select N'کاربر سیستم' where @I=1),'')) ,
               
      ISNULL
					( (SELECT     fldOrganId
FROM         tblMasuolin_Detail INNER JOIN
                      tblMasuolin ON tblMasuolin_Detail.fldMasuolinId = tblMasuolin.fldId INNER JOIN
                      tblOrganizationalPosts ON tblMasuolin_Detail.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                      tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId
               where  tblMasuolin.fldId= @fldHeaderId and tblMasuolin_Detail.fldOrderId=@I),0) ,

	ISNULL(( SELECT     tblOrganization.fldName
FROM         tblChartOrgan INNER JOIN
                      tblOrganization ON tblChartOrgan.fldOrganId = tblOrganization.fldId INNER JOIN
                      tblMasuolin_Detail INNER JOIN
                      tblMasuolin ON tblMasuolin_Detail.fldMasuolinId = tblMasuolin.fldId INNER JOIN
                      tblOrganizationalPosts ON tblMasuolin_Detail.fldOrganPostId = tblOrganizationalPosts.fldId ON tblChartOrgan.fldId = tblOrganizationalPosts.fldChartOrganId
                         WHERE  tblMasuolin.fldId= @fldHeaderId and tblMasuolin_Detail.fldOrderId=@I ),''),
        fldOrderId=@I
         set @I=@I+1
  end
          select  *,@fldHeaderId AS fldMasuolinId from @temp
GO
