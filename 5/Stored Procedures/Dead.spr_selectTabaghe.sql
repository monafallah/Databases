SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Dead].[spr_selectTabaghe](@shomareId int,@Id int)
as
;with cte as 
(select row_number()over (order by (select 1))id,fldTedadTabaghat from dead.tblShomare
where fldid=@shomareId
union all
select id+1,fldTedadTabaghat from cte
where cte.id<fldTedadTabaghat
)
select cast(id as tinyint) ShomareTabaghe,case id when 1 then N'طبقه اول' when 2 then N'طبقه دوم' when 3 then N'طبقه سوم' end as Tabaghe  from cte
--where not exists ()
GO
