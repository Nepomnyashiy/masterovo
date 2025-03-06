#!/bin/bash
TIMESTAMP=2025-03-06_21-43-39
pg_dumpall -U postgres > /home/master/masterovo/backup/postgres_backup_$TIMESTAMP.sql
tar -czf /home/master/masterovo/backup/logs_backup_$TIMESTAMP.tar.gz /home/master/masterovo/logs
echo '✅ Бэкап завершен: $TIMESTAMP'
