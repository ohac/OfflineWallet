#!/bin/sh
site=http://offlinewallet.info/
githome=../../
curl -s $site | sha1sum
sha1sum ${githome}index.html

urls=`egrep -o '(src|href)="[^\"#]+' $githome/index.html | cut -d\" -f2 | sort -u`
for url in $urls
do
  url2=
  localfile=
  case "$url" in
    http://bitcore.io/)
    ;;
    https://pages.github.com/)
    ;;
    http://offlinewallet.info/)
    ;;
    https://github.com/monatr/OfflineWallet/)
    ;;
    https://github.com/monatr/OfflineWallet/archive/gh-pages.zip)
    ;;
    javascript:\;)
    ;;
    *gif)
    ;;
    http*)
    url2=$url
    ;;
    *)
    url2=$site$url
    localfile=$githome$url
    ;;
  esac
  if [ ! -z $url2 ]; then
    curl -s $url2 | sha1sum
    if [ ! -z $localfile ]; then
      sha1sum $localfile
    else
      case "$url2" in
        https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js)
        echo "3c7b369485cadd585d24be44701e459c8aa54d60  3.7.0/html5shiv.js"
        ;;
        https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js)
        echo "b5aba40d65b0d6f85859db47f757ea971a0efd30  1.4.2/respond.min.js"
        ;;
      esac
    fi
  fi
done
