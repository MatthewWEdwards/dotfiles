#######################################
# Open a file in Google Chrome
# Globals:
#   None
# Arguments:
#   file - The relative path of the file the open in Chrome
#######################################
bopen() {
  file=$1
  google-chrome $1
}
