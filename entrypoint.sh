#!/bin/bash

MY_USER=testuser
SCRIPT="/etc/profile.d/custom_vars.sh"

if [ -f $SCRIPT ]; then
  echo -e "\n Script was created before, we won't recreate it"
  exit 0
fi

adduser --shell /bin/bash \
        --home /home/$MY_USER \
        $MY_USER

echo "export MY_BOOLEAN=${MY_BOOLEAN}" > $SCRIPT
echo "export MY_STRING=${MY_STRING}"  >> $SCRIPT

ENV_1=$(sudo -u $MY_USER -i echo $MY_BOOLEAN)
ENV_2=$( sudo -u $MY_USER -i echo $MY_STRING)


if [ ! -z $ENV_1 ] && [ ! -z $ENV_2 ]; then
  echo -e  "${SCRIPT} was built correctly"
  echo -e  "\nvar1 is $ENV_1"
  echo -e  "var2 is $ENV_2"
  echo -e  "\ncat file: ${SCRIPT}\n"
  sudo -u $MY_USER -i cat ${SCRIPT}
  exit 0
fi

echo "something went wrong variables were not set on $MY_USER"
exit 1
