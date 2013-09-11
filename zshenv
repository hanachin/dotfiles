# Ubuntu
if [ -d /etc/profile.d ]; then
  for file in /etc/profile.d/*; do
    echo ". $file"
    . $file
  done
fi
