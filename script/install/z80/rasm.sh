mkdir -p lib/bin
wget https://github.com/EdouardBERGE/rasm/archive/refs/tags/v2.3.5.zip
mv v2.3.5.zip rasm.zip
unzip rasm.zip
mv rasm-2.3.5 rasm
cd rasm
make
cd ..
mv rasm/rasm.exe lib/bin/rasm
rm -rf rasm rasm.zip