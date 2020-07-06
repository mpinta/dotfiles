#!/bin/bash

ROUTE='/usr/share/fonts'
SITE='https://www.jetbrains.com/lp/mono/'

wget -O /tmp/index.html $SITE
URL=$(xmllint --html --xpath "(//a[contains(text(),'Download font')])[1]/@href" /tmp/index.html)
URL=${URL:7:-1}
sudo wget -O $ROUTE/temp.zip $URL
sudo unzip -d $ROUTE $ROUTE/temp.zip
rm /tmp/index.html
sudo rm $ROUTE/temp.zip

