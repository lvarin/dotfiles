#!/usr/bin/bash
#

OS_PROJECT_NAME=$1
OS_USERNAME=$2

if [ -z "$OS_PROJECT_NAME" ];
then
    echo "Use: $0 <PROJECT_NAME> [USERNAME]"
    exit
fi

if [ -z "$OS_USERNAME" ];
then
  export OS_USERNAME="agonzale"
fi

unset OS_AUTH_URL OS_PROJECT_ID OS_PROJECT_NAME OS_USER_DOMAIN_NAME OS_PROJECT_DOMAIN_ID OS_PASSWORD OS_REGION_NAME OS_INTERFACE OS_IDENTITY_API_VERSION

export OS_AUTH_URL=https://pouta.csc.fi:5001/v3
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_ID=default
export OS_REGION_NAM=regionOne
export OS_INTERFACE=public
export OS_IDENTITY_API_VERSION=3

echo "Please enter your OpenStack Password for project $PROJECT_NAME as user $OS_USERNAME: "
read -sr OS_PASSWORD_INPUT
export OS_PASSWORD=$OS_PASSWORD_INPUT


