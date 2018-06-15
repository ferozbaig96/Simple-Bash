#/bin/bash
# remote-backup.sh : backup a local file into a remote server

# Notice the trailing / in source
# Otherwise whole folder will be included for processing
SOURCE="path/to/source/file/"
DEST="path/to/destination/folder"

echo "Starting"

# -a : The  files  are  transferred in "archive" mode, which ensures that symbolic links, devices, attributes,  permissions,  ownerships,  etc.  are preserved  in  the transfer.
# -v : Verbose
# -z : Compression will be used to reduce the size of data portions of the transfer.
rsync -avz -e "ssh" $SOURCE $DEST

# NOTE : Safer to dry-run first!
rsync -avz $SOURCE $DEST --dry-run

# delete marker will delete extraneous files from dest dirs (not in source)
rsync -avz $SOURCE $DEST --dry-run --delete
