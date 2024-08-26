#!/bin/bash
#
# Script to do the necessary changes to make the transition from 'gitlab.csc.fi' to 'gitlab.ci.csc.fi'
#   At the moment the only change is to replace the usernames and user ids
#

function rename_username() {
  JSON=$1
  USER_OLD=$2
  USER_NEW=$3

  if [ -z "$USER_NEW" ];
  then
    echo "Use: $0 <PROJECT.JSON> <OLD USER> <NEW USER>" >&2
    return 2
  fi

  echo "Renaming user '$USER_OLD' to '$USER_NEW'"

  sed -i "s#$USER_OLD#$USER_NEW#g" "$JSON"
}

function renumber_userid() {
  JSON=$1
  ID_OLD=$2
  ID_NEW=$3

  if [ -z "$ID_NEW" ];
  then
    echo "Use: $0 <PROJECT.JSON> <OLD ID> <NEW ID>" >&2
    return 3
  fi

  echo "Renaming user '$ID_OLD' to '$ID_NEW'"

  echo "  ... doing 'user_id'"
  sed -i "s#\(\"user_id\":\)\s*${ID_OLD},#\1 ${ID_NEW},#g" "$JSON"

  echo "  ... doing 'author_id'"
  sed -i "s#\(\"author_id\":\)\s*${ID_OLD},#\1 ${ID_NEW},#g" "$JSON"

  echo "  ... doing 'created_by_id'"
  sed -i "s#\(\"created_by_id\":\)\s*${ID_OLD},#\1 ${ID_NEW},#g" "$JSON"

  echo "  ... doing 'last_edited_by_id'"
  sed -i "s#\(\"last_edited_by_id\":\)\s*${ID_OLD},#\1 ${ID_NEW},#g" "$JSON"

  echo "  ... doing 'updated_by_id'"
  sed -i "s#\(\"updated_by_id\":\)\s*${ID_OLD},#\1 ${ID_NEW},#g" "$JSON"
}
#
# #######
#

PROJECT_JSON=$1

if [ -z "$PROJECT_JSON" ];
then
  echo "Use: $0 <PROJECT.JSON>" >&2
  exit 1
fi

DATE=$(date +%Y%m%d-%H%M%S)
PROJECT_JSON_SUFIX="${PROJECT_JSON}-${DATE}"

echo " * Reading file '${PROJECT_JSON}'. We will create file: '${PROJECT_JSON_SUFIX}' first."
cp "${PROJECT_JSON}" "${PROJECT_JSON_SUFIX}"

echo "   DONE";echo
echo " * Renaming user names"
set -e
rename_username "${PROJECT_JSON_SUFIX}" alvaro.gonzalez galvaro
rename_username "${PROJECT_JSON_SUFIX}" sami.ilvonen silvonen
rename_username "${PROJECT_JSON_SUFIX}" shubham.kapoor skapoor
rename_username "${PROJECT_JSON_SUFIX}" kalle.happonen khappone
#rename_username "${PROJECT_JSON_SUFIX}" juhani.kataja "Juhani.Kataja"       # Juhani has no account in the new GitLab CI

echo "   DONE";echo

echo " * Renumering user ids"
renumber_userid "${PROJECT_JSON_SUFIX}" 37 28
renumber_userid "${PROJECT_JSON_SUFIX}" 42 55
#renumber_userid "${PROJECT_JSON_SUFIX}" 54 54
renumber_userid "${PROJECT_JSON_SUFIX}" 58 51
renumber_userid "${PROJECT_JSON_SUFIX}" 258 42

echo "# In order to see differences between the two files do:"
echo "#   diff -y --suppress-common-lines <(jq . ${PROJECT_JSON}) <(jq . ${PROJECT_JSON_SUFIX})"

echo " * Creating TAR file"
TMPD=$(mktemp -d)
cp -r project.bundle project.wiki.bundle uploads "$TMPD"
cp "project.json-${DATE}" "${TMPD}/project.json"

pushd $TMPD
echo '0.2.4' >VERSION
tar czvf "gitlab-${DATE}.tar.gz" *
popd
cp "${TMPD}/gitlab-${DATE}.tar.gz" .
rm -rf ${TPMD}

echo "   DONE";echo

echo "END"
