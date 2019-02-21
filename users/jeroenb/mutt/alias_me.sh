#!/bin/sh

MESSAGE=$(cat)

NEWALIAS=$(echo "${MESSAGE}" | grep ^"From: " | sed s/[\,\"\']//g | awk '{$1=""; if (NF == 3) {print "alias" $0;} else if (NF == 2) {print "alias" $0 $0;} else if (NF > 3) {print "alias", tolower($(NF-2))"-"tolower($1) $0;}}')

if grep -Fxq "$NEWALIAS" $TRMU/mutt/aliases; then
    :
else
    echo "$NEWALIAS" >> $TRMU/mutt/aliases
fi

echo "${MESSAGE}"
