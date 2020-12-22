#!/bin/bash
ORIGDIR=$(pwd)
figlet Making Book $1
wget https://github.com/rust-lang/book/archive/nostarch-second-printing.zip
unzip nostarch-second-printing.zip
rm nostarch-second-printing.zip
for file in $(ls scripts)
do
ln -s `pwd`/scripts/$file $3/$4/$file
done
cd $3/$4
LIST=$(cat SUMMARY.md|grep -oe "[^(]*md"|sed ':a;N;$!ba;s/\n/ /g'|sed 's/ ^//')
mkdir tmp
for file in $(echo $LIST)
do
mkdir -p tmp/$(dirname $file) && cp $file tmp/$file
done
mv $(echo $LIST|python3 map.py) tmp/dmp.json
cp -r img tmp/
cd tmp
sed -i "s#\.\./#https://doc.rust-lang.org/#g" $LIST
for file in $(echo $LIST)
do
  sed -E -i 's:(('$(echo $LIST|sed 's: :)|(:g'|sed 's:md:html:g')'))#:#:g' $file
  sed -E -i 's:('$(echo $LIST|sed 's: :)|(:g'|sed 's:md:html:g')'):!!REPLACE!!\0!!REPLACE!!:g' $file
  sed -E -i 's:```rust.*:```rust:g' $file
done
python3 ../prep.py
cp ../metadata_TRPL.txt .
cp ../Rust2018_front.png .
pandoc -o "$1.epub" metadata_TRPL.txt $(echo $LIST)
cp "$1.epub" $ORIGDIR/Books
cd $ORIGDIR
rm -rf $3
