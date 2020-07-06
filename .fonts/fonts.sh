#!/bin/bash

ROUTE='/usr/share/fonts'
JETBRAINS='https://www.jetbrains.com/lp/mono/'

wget -O /tmp/index.html $JETBRAINS
URL=$(xmllint --html --xpath "(//a[contains(text(),'Download font')])[1]/@href" /tmp/index.html)
URL=${URL:7:-1}
sudo wget -O $ROUTE/temp.zip $URL
sudo unzip -d $ROUTE $ROUTE/temp.zip
rm /tmp/index.html
sudo rm $ROUTE/temp.zip

