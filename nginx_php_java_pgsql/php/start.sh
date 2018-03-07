#!/bin/sh

service php-fpm start

cat <<EOF >>~/.bashrc
trap 'service php-fpm stop; exit 0' TERM
EOF
exec /bin/bash
