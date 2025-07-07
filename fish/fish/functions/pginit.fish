function pginit -d "create a postgres dbconfig.yml file for sql-migrate" -a dbname dir
    switch (count $argv)
        case 1
            set dir migrations
        case 2
            true
        case '*'
            echo "Usage: pginit <dbname> [dir]"
    end

    echo "---
development:
    dialect: postgres
    datasource: >-
        dbname=$dbname
        user=postgres
        sslmode=disable
    dir: $dir
    table: migrations
" >dbconfig.yml
end
