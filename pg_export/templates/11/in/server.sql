select json_agg(x)
  from (select quote_ident(s.srvname) as name,
               quote_ident(w.fdwname) as wrapper,
               s.srvacl as acl,
               quote_literal(s.srvtype) as type,
               quote_literal(s.srvversion) as version,
               (select coalesce(
                         json_agg(
                           json_build_object(
                             'name', quote_ident(sp.name),
                             'value', quote_literal(ss.value))),
                         '[]')
                  from unnest(s.srvoptions) u(str)
                 cross join split_part(u.str, '=', 1) sp(name)
                 cross join substr(u.str, length(sp.name) + 2) ss(value)) as options,
               (select coalesce(
                         json_agg(
                           json_build_object(
                             'role', quote_ident(a.rolname),
                             'options', (select coalesce(
                                                  json_agg(
                                                    json_build_object(
                                                      'name', quote_ident(sp.name),
                                                      'value', quote_literal(ss.value))),
                                                  '[]')
                                           from unnest(m.umoptions) u(str)
                                          cross join split_part(u.str, '=', 1) sp(name)
                                          cross join substr(u.str, length(sp.name) + 2) ss(value))) order by a.rolname nulls last),
                         '[]')
                  from pg_user_mappings m
                  left join pg_authid a
                         on a.oid = m.umuser
                 where m.srvid = s.oid) as user_mappings
          from pg_foreign_server s
         inner join pg_foreign_data_wrapper w
                 on w.oid = s.srvfdw
         order by 1) as x
