-- Gets all queries for a given date range
select starttime, endtime, trim(querytxt) as query
from stl_query
where starttime between '2014-11-04' and '2014-11-05'
order by starttime desc;

-- Gets all queries that have been aborted for a given date range
select starttime, endtime, trim(querytxt) as query, aborted
from stl_query 
where aborted=1
and starttime between '2014-11-04' and '2014-11-05'
order by starttime desc;

-- Gets all data loads that have been COMMITed for a given date range
select q.starttime, q.endtime, trim(q.querytxt) as query, rtrim(l.filename) as filename
from stl_load_commits l, stl_query q
where l.query=q.query
and exists
  (select xid from stl_utilitytext where xid=q.xid and rtrim("text")='COMMIT')
and starttime between '2014-11-04' and '2014-11-05'
order by q.starttime desc;

-- Gets load error fields for debugging S3 loads
select starttime, filename, colname, trim(raw_line) as raw_line, trim(raw_field_value) as raw_value, err_reason
from stl_load_errors
where starttime between '2014-11-04' and '2014-11-05'
order by starttime desc;

-- Will get all top level errors, such as .manifest loading failures
select q.starttime, q.endtime, trim(c.error) as error, trim(c.context) as context
from stl_error c, stl_query q
where c.pid=q.pid
and starttime between '2014-11-04' and '2014-11-05'
order by q.starttime;
