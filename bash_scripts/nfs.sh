### Mount NFS
alias mnfs="sudo mkdir -p $NFS_ROOT ; sudo mount $SERVER_IP:/media/5TB /mnt/nfs ; "
alias mirrors="cd $MIRRORS"

nfs() {
 cd $NFS_DIR
}

save_to_mirrors() {
  file=$1
  loc=$2
  mkdir -p $MIRRORS/$loc
  cp -r $file $MIRRORS/$loc
}
alias stm="save_to_mirrors"

save_to_nfs() {
  file=$1
  loc=$2
  mkdir -p $NFS_DIR/$loc
  cp -r $file $NFS_DIR/$loc/
}
alias stn="save_to_nfs"

nfs_open() {
  file=$1
  bopen $NFS_DIR/$file
}
alias nopen="nfs_open"

nfs_ls() {
  ls -lh $NFS_DIR/$@
}
alias lsnfs="nfs_ls"

nfs_ln() {
  file=$1
  linkname=$2
  ln -s $NFS_DIR/$file $linkname
}
alias lnnfs="nfs_ln"

nfs_mirrors_ln() {
  file=$1
  linkname=$2
  ln -s $MIRRORS/$file $linkname
}
alias lnmnfs="nfs_mirrors_ln"

nfs_dir_backup() {
  (
    dir=$1
    cd $NFS_DIR
    d=$(mktemp -d)
    tar -czf $d/$dir.tgz $dir
    echo "Created backup $d/$dir.tgz"
  )
}

mirrors_backup() {
  nfs_dir_backup mirrors
}
