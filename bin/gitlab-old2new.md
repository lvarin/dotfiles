```
$ jq . project.json | grep author_id | sed -e 's#.*\s\([0-9]*\),#\1#' | sort -u

37  # sami.ilvonen    -> 28 silvonen
42  # shubham.kapoor  -> 55 skapoor
54  # juhani.kataja   -> ???
58  # kalle.happonen  -> 51 khappone
258 # alvaro.gonzalez -> 42 galvaro
```

```
$ jq . project.json| grep -w 42 | sed -e 's#\s*\([^:]*\):.*#\1#' | sort|uniq -c | grep -v _at | grep -v iid | grep -v note
   1870 "author_id"
      1 "created_by_id"
     23 "last_edited_by_id"
    230 "updated_by_id"
    113 "user_id"

```
