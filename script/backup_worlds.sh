#!/bin/bash
set -u
################################################################################

WORK_DIR=/opt/minecraft
BACKUP_DIR=${WORK_DIR}/backup
TODAY=$(date +%Y%m%d)

echo "backup..."
cd ${WORK_DIR}
find -L . \
  -maxdepth 1 \
  -type d \
  -not -iregex "\\(.\\|.*script.*\\|.*backup.*\\)" \
  -print0 \
| xargs -0 -I{} \
  tar -zcf ${BACKUP_DIR}/{}-${TODAY}.tgz {}
echo "backup... done!"

echo "clean up old backup..."
cd ${BACKUP_DIR}
find -L . \
  -maxdepth 1 \
  -type f \
  -name "*.tgz" \
  -mtime +7 \
  -delete
echo "clean up old backup... done!"
