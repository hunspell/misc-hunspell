#!/usr/bin/env bash

# Name: test_hunspell_language_support_to_word_list_name.sh
# Description: Test the script hunspell_language_support_to_word_list_name.sh
# License: MPL 1.1/GPL 2.0/LGPL 2.1
# Author: Pander <pander@users.sourceforge.net>

#TODO Optimise this script, also add echo for input.

./hunspell_language_support_to_word_list_name.sh bg_BG
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh ca
if [ $? -ne 0 ]
then
    exit 1
fi
#FIXME ./hunspell_language_support_to_word_list_name.sh ca_ES
if [ $? -ne 0 ]
then
    exit 1
fi
#FIXME ./hunspell_language_support_to_word_list_name.sh ca_ES-valencia
#FIXME ca_ES-valencia should be ca_ES_valencia
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh da_DK
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh de_CH
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh de_CH_frami
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh de_DE
if [ $? -ne 0 ]
then
    exit 1
fi
#FIXME ./hunspell_language_support_to_word_list_name.sh de_BE
if [ $? -ne 0 ]
then
    exit 1
fi
#FIXME ./hunspell_language_support_to_word_list_name.sh de_LU
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh de_DE_frami
if [ $? -ne 0 ]
then
    exit 1
fi
#./hunspell_language_support_to_word_list_name.sh de_DE
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh en_CA
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh en_GB
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh en_US
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh es_ES
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh fo
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh fr
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh gd_GB
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh gl_ES
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh it_IT
if [ $? -ne 0 ]
then
    exit 1
fi
#FIXME ./hunspell_language_support_to_word_list_name.sh it_CH
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh nl_NL
if [ $? -ne 0 ]
then
    exit 1
fi
#FIXME ./hunspell_language_support_to_word_list_name.sh nl_BE
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh nn_NO
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh nb_NO
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh pl_PL
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh pt_BR
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh pt_PT
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_word_list_name.sh sv_SE
if [ $? -ne 0 ]
then
    exit 1
fi
#FIXME ./hunspell_language_support_to_word_list_name.sh sv_FI
if [ $? -ne 0 ]
then
    exit 1
fi