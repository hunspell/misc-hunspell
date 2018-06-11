#!/usr/bin/env bash

if [ ! -d ../1-support/files -o ! -d ../1-support/utf8 ]; then
	echo 'ERROR: Run the scripts in ../1-support/ first.'
    exit 1
fi
if [ ! -d ../2-word-lists/files -o ! -d ../2-word-lists/utf8 ]; then
	echo 'ERROR: Run the scripts in ../2-word-lists/ first.'
    exit 1
fi

platform=`../0-tools/platform.sh`
hostname=`hostname`

if [ -e words/$platform ]; then
	rm -rf words/$platform/*
else
	mkdir -p words/$platform
fi

# Crude filtering by skipping:
# 1. first line of dic file with list size
# 2. everything after a slash, but not a slash which is escaped by backslash, that one is unescaped
# 3. comment including and after #

# Crude splitting for:
# 4. whitespace
# 5. comma ,
# 6. hyphen - (only for certain languages)

# Crude filtering by skipping:
# 7. emtpy line

total_start=`date +%s`

for path in `find ../1-support/files -type f -name '*.aff'|sort`; do
	package=`echo $path|awk -F '/' '{print $4}'`
	version=`echo $path|awk -F '/' '{print $5}'`
	affix=`echo $path|awk -F '/' '{print $9}'`
	language=`basename $affix .aff`

if [ $language != an_ES -a $language != bg_BG -a $language != cs_CZ -a $language != el_GR -a $language != en_MED -a $language != es_ES -a $language != sl_SI -a $language != hr_HR -a $language != kk_KZ -a $language != pt_BR -a $language != th_TH -a $language != pl_PL -a $language != ko -a $language != lt_LT -a $language != nn_NO -a $language != te_IN ]; then # errors that need fixing

	echo -n 'Gathering words for '$language
	mkdir -p words/$platform/$language
	start=`date +%s`

	if [ $language = br_FR -o $language = en_CA -o $language = en_GB -o $language = en_US -o $language = en_ZA -o $language = eo -o $language = et_EE -o $language = gv_GB -o $language = nn_NO -o $language = nb_NO -o $language = oc_FR -o $language = ro_RO -o $language = tl -o $language = lv_LV -o $language = sv_SE -o $language = sv_FI -o $language = sk_SK -o $language = sw_TZ -o $language = fo -o $language = ga_IE -o $language = se -o $language = af_ZA ];then # split on hyphen
		tail -n +2 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'| sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|sed -e 's/-/\n/g'|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	elif [ $language = gd_GB ];then # split on NON-BREAKING HYPHEN' (U+2011)
		tail -n +2 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'| sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|sed -e 's/‑/\n/g'|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	elif [ $language = fr ];then # split on hyphen and ndash and underscore
		tail -n +2 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'|sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|sed -e 's/[_–-]/\n/g'|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	elif [ $language = ar ];then # custom # and ::
		tail -n +2 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'|sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|grep -v \# |grep -v :: |sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	elif [ $language = de_AT_frami -o $language = de_AT -o $language = de_CH_frami -o $language = de_CH -o $language = de_DE_frami -o $language = de_DE ];then # also license # also '(STp'
		tail -n +18 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'|sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|grep -v '^$'|grep -v '(STp' |sort|uniq > words/$platform/$language/dict_$version
	elif [ $language = it_IT ];then # also license
		tail -n +35 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'|sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	else # default
		tail -n +2 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'|sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|grep -v '^$'|sort|uniq > words/$platform/$language/dict_$version
	fi

	word_list=`../0-tools/hunspell_language_support_to_word_list_name.sh $language`
	if [ `echo $word_list|grep -c ERROR` == 0 ]; then
		wordpackage=`echo $word_list|awk '{print $2}'`
		wordfile=`echo $word_list|awk '{print $3}'`
#		echo -e '\t\twordpackage '$wordpackage
#		echo -e '\t\twordfile '$wordfile
		for list in ../2-word-lists/files/$wordpackage/*/usr/share/dict/$wordfile; do
			wordversion=`echo $list|awk -F '/' '{print $5}'`
			if [ $language = br_FR -o $language = en_CA -o $language = en_GB -o $language = en_US -o $language = en_ZA -o $language = nn_NO -o $language = nb_NO -o $language = oc_FR -o $language = ro_RO -o $language = sv_SE -o $language = sv_FI -o $language = sk_SK -o $language = sw_TZ -o $language = ga_IE -o $language = fo -o $language = eo ]; then # split on hyphen
				cat ../2-word-lists/utf8/$wordfile.txt|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|sed -e 's/-/\n/g'|grep -v [_\&]|grep -v '^$'|sort|uniq > words/$platform/$language/list_$wordversion
			elif [ $language = fr ]; then # split on hyphen and ndash and underscore
				cat ../2-word-lists/utf8/$wordfile.txt|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|sed -e 's/[_–-]/\n/g'|grep -v '^$'|sort|uniq > words/$platform/$language/list_$wordversion
			else
				cat ../2-word-lists/utf8/$wordfile.txt|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|grep -v [_\&]|grep -v '^$'|sort|uniq > words/$platform/$language/list_$wordversion
			fi
		done
	fi

	#TODO for testing, limit via "sort -R|head -n 4096"
#	cat words/$platform/$language/*|sort|uniq|sort -R|head -n 4096 >words/$platform/$language/gathered
	if [ $language = br_FR ]; then # period colon
		cat words/$platform/$language/*|grep -v [:.] |sort|uniq >words/$platform/$language/gathered
	elif [ $language = da_DK ]; then # numerals (also in subscript and superscript) and apostrophe and hyphen begin of word
		cat words/$platform/$language/*|grep -v "[0-9¹²³₁₂₃']" |grep -v "^-" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = fr ]; then # numerals in subscript and superscript and apostrophe and opening and closing braces and hyphen end of word and &
		cat words/$platform/$language/*|grep -v "[&¹²³₁₂₃'()]" |grep -v "\-$" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = ro_RO ]; then # numerals
		cat words/$platform/$language/*|grep -v "[0-9]" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = nl ]; then # subscriptnumerals plus -BOL
		cat words/$platform/$language/*|grep -v "[+₁₂₃]" |grep -v "^-" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = sv_SE -o $language = sv_FI ]; then # subscriptnumerals plus -BOL
		cat words/$platform/$language/*|grep -v "[:']" |grep -v "^-" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = en_GB ]; then # omit period apostrophe plus
		cat words/$platform/$language/*|grep -v "[+.']" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = en_US ]; then # omit period apostrophe
		cat words/$platform/$language/*|grep -v "[.']" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = gl_ES ]; then # period numerals
		cat words/$platform/$language/*|grep -v "[0-9.]" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = nb_NO -o $language = et_EE ]; then # period
		cat words/$platform/$language/*|grep -v "\." |sort|uniq >words/$platform/$language/gathered
	elif [ $language = sw_TZ ]; then # period apostrophe numerals
		cat words/$platform/$language/*|grep -v "[0-9.']" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = en_ZA -o $language = af_ZA ]; then # omit period apostrophe numerals exclamationmark
		cat words/$platform/$language/*|grep -v "[0-9.']" |grep -v ! |sort|uniq >words/$platform/$language/gathered
	elif [ $language = sr_RS ]; then # period specialapostrophe
		cat words/$platform/$language/*|grep -v "[.’]" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = gd_GB ]; then # period and ⁊ TIRONIAN SIGN ET and equals and numerals underscore
		cat words/$platform/$language/*|grep -v "[0-9⁊.=_]"|grep -v "!" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = it_IT -o $language = tl -o $language = ga_IE -o $language = kmr_Latn -o $language = fo -o $language = en_CA -o $language = en_AU -o $language = eo -o $language = gv_GB -o $language = oc_FR ]; then # apostrophe
		cat words/$platform/$language/*|grep -v "'" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = de_CH_frami -o $language = de_AT_frami ]; then # apostrophe plus
		cat words/$platform/$language/*|grep -v "[+']" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = lv_LV ]; then # period braceopen braceclose
		cat words/$platform/$language/*|grep -v "[.()]" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = hu_HU ]; then # omit misc
		cat words/$platform/$language/*|grep -v "[@$€}:=§%{|±+'()]" |grep -v "^-"|grep -v "\-$"|sort|uniq >words/$platform/$language/gathered
	elif [ $language = de_DE_frami ]; then # apostrophe
# Trög°litz is probably an error
		cat words/$platform/$language/*|grep -v "[+'°]" |sort|uniq >words/$platform/$language/gathered
	elif [ $language = ca -o $language = ca_ES-valencia ]; then # numerals subscriptnumerals superscriptnumerals apostrophe plus
		cat words/$platform/$language/*|grep -v "[0-9¹²³₁₂₃+']" |sort|uniq >words/$platform/$language/gathered
#	elif [ $language = te_IN ]; then # Uxc02 ం
#		cat words/$platform/$language/*|grep -v "[ ంు]"  |sort|uniq >words/$platform/$language/gathered
	elif [ $language = se ]; then # -BOL EOL- underscore ampersand
		cat words/$platform/$language/*|grep -v [_\&²³] |grep -v "^-"|grep -v "\-$"|sort|uniq >words/$platform/$language/gathered
	else
		cat words/$platform/$language/*|sort|uniq >words/$platform/$language/gathered
	fi
	for file in words/$platform/$language/*; do
		../0-tools/histogram.py $file > words/$platform/$language/`basename $file`-histogram.md
	done
	wc -l words/$platform/$language/gathered|awk '{print $1}' > words/$platform/$language/gathered.total

	echo ', totaling '`cat words/$platform/$language/gathered.total`
	end=`date +%s`
	echo $end-$start|bc > words/$platform/$language/time-$hostname

fi # errors that need fixing
done

total_end=`date +%s`
echo $total_end-$total_start|bc > words/$platform/time-$hostname
