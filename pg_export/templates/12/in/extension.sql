select json_agg(x)
  from (select quote_ident(e.extname) as name,
               quote_ident(n.nspname) as with_schema,
               quote_literal(e.extversion) as with_version,
               quote_literal(d.description) as comment
          from pg_extension e
          left join pg_namespace n
                 on n.oid = e.extnamespace
          {% with objid='e.oid', objclass='pg_extension' -%} {% include '12/in/_join_description_as_d.sql' %} {% endwith %}
         where e.oid > {{ last_builin_oid }}
         order by 1, 2) as x
