To create a new education database locally...

- Install Postgresql
- Create a new database
- From the command line run `python build.py`
- Connect to the database and run the install file: `psql -d [database_name] -a -f install.sql`