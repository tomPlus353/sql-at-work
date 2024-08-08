# Randomize db
### Step 1 
- import DB to mysql client

```bash
mysql -u root -p NEW_DB_NAME < db_file_name.sql
```


### Step 2
- enter mysql client and run randomize script

```bash
mysql -u root -p NEW_DB_NAME
```

```sql
source randomize.sql; -- path to randomize script
```

### Step 3
- exit client and use mysqldump utility to export the db

```bash
mysqldump -u root -p NEW_DB_NAME > db_file_name.sql
```

### Step 4
- Zip the final sql file

```bash
zip newziparchive.zip db_file_name.sql 
```
