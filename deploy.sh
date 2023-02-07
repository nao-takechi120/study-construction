#! /usr/bin/bash

cd /var/www/;
#rm dist.tar.gz;
mv ~/dist.tar.gz .;
tar xvzf dist.tar.gz;
mv  html html.bak
mv dist html
