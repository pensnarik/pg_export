usage: pg_export [--help] [--clean] [-h HOST] [-p PORT] [-U USERNAME]
                 [-W PASSWORD]
                 dbname out_dir

Export structure of databese to object files for control version system

positional arguments:
  dbname                source databese name
  out_dir               directory for object files

optional arguments:
  --help                show this help message and exit
  --clean               clean out_dir if not empty
  -h HOST, --host HOST  host for connect db
  -p PORT, --port PORT  port for connect db
  -U USERNAME, --username USERNAME
                        user for connect db
  -W PASSWORD, --password PASSWORD
                        password for connect db
