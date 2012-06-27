C: 
cd\
cd C:\Program Files (x86)\PostgreSQL\8.4\bin
 set pguser=postgres
 set pgpassword=@spartacus201@
 set dataAtual=%DATE:~0,2%-%DATE:~3,2%-%DATE:~6,4% 
pg_dump.exe -i -h localhost -p 5432 -U postgres -F c -b -v -f "C:\Backup_%dataAtual%.backup" banco
 
