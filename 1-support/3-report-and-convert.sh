#!/usr/bin/env bash

if [ -e packages ]; then
	cd packages
	echo 'This page has been generated on '`date +%Y-%m-%d`' at '`date +%H:%M`' by `misc-hunspell/1-support/3-report.sh`. Do not edit this page manually. See also many other markdown documentation.' > ../Dictionary-Files.md #TODO

	echo >> ../Dictionary-Files.md

	echo '## Affix files' >> ../Dictionary-Files.md
	echo >> ../Dictionary-Files.md
	echo 'A total of '`find . -type f -name '*.aff'|wc -l`' different affix files are available for Hunspell. Affix files which are made available via symbolic links are excluded. Note that each affix file has a unique name. Normally, these are installed in `/usr/share/hunspell/`.' >> ../Dictionary-Files.md
	echo >> ../Dictionary-Files.md
	echo 'Some available packages are omitted from this overview and testing framework. Package `hunspell-fr` is only a dependency package. Packages `hunspell-fr-classical`, `hunspell-fr-modern` and `hunspell-fr-revised` conflict with `hunspell-fr-comprehensive`, which has a bigger affix file. Package `hunspell-gl` conflicts with `hunspell-gl-es`, which has a bigger affix file.' >> ../Dictionary-Files.md
	echo >> ../Dictionary-Files.md
	echo '| Package | Version | Filename | Type | Lines |' >> ../Dictionary-Files.md
	echo '|---|---|---|---|--:|' >> ../Dictionary-Files.md
	for file in `find . -type f -name '*.aff'|sort`; do
		echo -n $file|sed -e 's/\/usr\/share\/hunspell//'|sed -e 's/^\.\//| `hunspell-/'|sed -e 's/\//` | `/g'|sed -e 's/$/` | /' >> ../Dictionary-Files.md
		echo -n `file $file|sed -e 's/^.*: //'`' | `' >> ../Dictionary-Files.md
		echo `wc -l $file|awk '{print $1}'`'` |' >> ../Dictionary-Files.md
	done

	echo >> ../Dictionary-Files.md

	echo '## Dictionary files' >> ../Dictionary-Files.md
	echo >> ../Dictionary-Files.md
	echo 'A total of '`find . -type f -name '*.dic'|wc -l`' different dictionary files are available for Hunspell. Dictionary files which are made available via symbolic links are excluded. Note that each dictionary file has a unique name. Normally, these are installed in `/usr/share/hunspell/`. Note that medical extention dictionary files, see `-med`, `_med` and `_MED`, do not have their own affix file. These dictionaries can be loaded additionally.' >> ../Dictionary-Files.md
	echo >> ../Dictionary-Files.md
	rm -rf ../utf8
	mkdir ../utf8
	echo '| Package | Version | Filename | Type | Lines |' >> ../Dictionary-Files.md
	echo '|---|---|---|---|--:|' >> ../Dictionary-Files.md
	for file in `find . -type f -name '*.dic'|sort`; do
		echo -n $file|sed -e 's/\/usr\/share\/hunspell//'|sed -e 's/^\.\//| `hunspell-/'|sed -e 's/\//` | `/g'|sed -e 's/$/` | /' >> ../Dictionary-Files.md
		filename=`basename $file .dic`
		echo $filename
		encoding=`file $file|sed -e 's/^.*: //'`
		echo -n $encoding' | `' >> ../Dictionary-Files.md
		echo `wc -l $file|awk '{print $1}'`'` |' >> ../Dictionary-Files.md
		if [ $filename != en_MED -a $filename != de_med -a $filename != kk_KZ ]; then # bug with kk_KZ
			if [ $filename = ar -o $filename = be_BY -o $filename = bn_BD -o $filename = bo -o $filename = br_FR -o $filename = ca -o $filename = ca_ES-valencia -o $filename = da_DK -o $filename = dz -o $filename = en_AU -o $filename = en_CA -o $filename = en_GB -o $filename = en_US -o $filename = en_ZA -o $filename = es_ES -o $filename = fa_IR -o $filename = fr -o $filename = gd_GB -o $filename = gl_ES -o $filename = gu_IN -o $filename = gug_PY -o $filename = he_IL -o $filename = hi_IN -o $filename = hr_HR -o $filename = hu_HU -o $filename = is_IS -o $filename = kk_KZ -o $filename = kmr_Latn -o $filename = ko -o $filename = lo_LA -o $filename = ml_IN -o $filename = ne_NP -o $filename = nl -o $filename = pt_PT -o $filename = ro_RO -o $filename = se -o $filename = si_LK -o $filename = sk_SK -o $filename = sr_Latn_RS -o $filename = sr_RS -o $filename = sv_FI -o $filename = sv_SE -o $filename = te_IN -o $filename = uk_UA -o $filename = uz_UZ -o $filename = vi_VN ]; then
				cp $file ../utf8/$filename.txt
			elif [ $filename = af_ZA -o $filename = an_ES -o $filename = de_AT -o $filename = de_AT_frami -o $filename = de_CH -o $filename = de_CH_frami -o $filename = de_DE -o $filename = de_DE_frami -o $filename = eu -o $filename = fo -o $filename = ga_IE -o $filename = gv_GB -o $filename = nb_NO -o $filename = nn_NO -o $filename = pt_BR -o $filename = tl -o $filename = sw_TZ ]; then
				iconv -f ISO-8859-1 -t UTF-8//IGNORE $file -o ../utf8/$filename.txt
			elif [ $filename = bs_BA -o $filename = cs_CZ -o $filename = pl_PL -o $filename = sl_SI ]; then
				iconv -f ISO-8859-2 -t UTF-8//IGNORE $file -o ../utf8/$filename.txt
			elif [ $filename = eo ]; then
				iconv -f ISO8859-3 -t UTF-8//IGNORE $file -o ../utf8/$filename.txt
			elif [ $filename = el_GR ]; then
				iconv -f ISO-8859-7 -t UTF-8//IGNORE $file -o ../utf8/$filename.txt
			elif [ $filename = lt_LT -o $filename = lv_LV ]; then
				iconv -f ISO-8859-13 -t UTF-8//IGNORE $file -o ../utf8/$filename.txt
			elif [ $filename = it_IT -o $filename = oc_FR -o $filename = et_EE ]; then
				iconv -f ISO-8859-15 -t UTF-8//IGNORE $file -o ../utf8/$filename.txt
			elif [ $filename = bg_BG ]; then
				iconv -f CP1251 -t UTF-8//IGNORE $file -o ../utf8/$filename.txt
			elif [ $filename = th_TH ]; then
				iconv -f TIS-620 -t UTF-8//IGNORE $file -o ../utf8/$filename.txt
			elif [ $filename = ru_RU ]; then
				iconv -f KOI8-R -t UTF-8//IGNORE $file -o ../utf8/$filename.txt
			else
				echo 'ERROR: Unsupported file encoding '$encoding' for file '$file
				exit 1
			fi

			new_encoding=`file ../utf8/$filename.txt|sed -e 's/^.*: //'`
			if [ "$new_encoding" = 'UTF-8 Unicode text, with CRLF line terminators' -o "$new_encoding" = 'UTF-8 Unicode text, with CRLF, LF line terminators' ]; then
				flip -b -u ../utf8/$filename.txt
			fi

			new_encoding=`file ../utf8/$filename.txt|sed -e 's/^.*: //'`
			if [ $filename != an_ES ] && [ "$new_encoding" != 'UTF-8 Unicode text' -a "$new_encoding" != 'ASCII text' -a "$new_encoding" != 'UTF-8 Unicode text, with very long lines' ]; then
				echo 'ERROR: File enconding conversion from '$encoding' for '$file' to '$new_encoding' for file '$filename' failed'
				exit 1
			fi

			../../0-tools/histogram.py ../utf8/$filename.txt > ../utf8/$filename-historgram.md
			#bug: remove license in dic files, especially with incorrect coding, see all german dic files
		fi
	done

	sed -i -e 's/hunspell-eo/myspell-eo/' ../Dictionary-Files.md
	sed -i -e 's/hunspell-fo/myspell-fo/' ../Dictionary-Files.md
	sed -i -e 's/hunspell-ga/myspell-ga/' ../Dictionary-Files.md

	echo '## File types' >> ../Dictionary-Files.md
	echo >> ../Dictionary-Files.md
	echo 'The following pairs of affix file and dictionary file have a different file type. This might be a problem in some cases.' >> ../Dictionary-Files.md
	echo >> ../Dictionary-Files.md
	echo '| Language | Affix file type | Dictionary file type |' >> ../Dictionary-Files.md
	echo '|---|---|---|' >> ../Dictionary-Files.md
	for aff in `find . -type f -name '*.aff'|sort`; do
		language=`basename $aff .aff`
		aff_type=`file $aff|sed -e 's/^.*: //'|sed -e 's/, with very long lines//'`
		dic=`echo $aff|sed -e 's/\.aff$/\.dic/'`
		dic_type=`file $dic|sed -e 's/^.*: //'|sed -e 's/, with very long lines//'`
		if [ "$aff_type" != "$dic_type" ]; then
			if [ "$aff_type" = 'ASCII text' -a "$dic_type" = 'UTF-8 Unicode text' ] || [ "$aff_type" = 'UTF-8 Unicode text' -a "$dic_type" = 'ASCII text' ]; then
				echo -n
			else
				echo '| `'$language'` | '$aff_type' | '$dic_type' |' >> ../Dictionary-Files.md
			fi
		fi
	done


	echo '## Encodings mentioned' >> ../Dictionary-Files.md
	echo >> ../Dictionary-Files.md
	echo 'TODO' >> ../Dictionary-Files.md
	echo >> ../Dictionary-Files.md
	echo '| File | Encoding |' >> ../Dictionary-Files.md
	echo '|--|---|' >> ../Dictionary-Files.md
	for aff in `find . -name '*aff' -type f|sort`; do
		filename=`basename $aff .aff`
		enc=`grep SET $aff|sed -e 's/^.*SET //'`
		echo '| `'$filename'` | '$enc' |' >> ../Dictionary-Files.md
	done
fi

#TODO header gv_GB.dic
#TODO missing header ga_IE
