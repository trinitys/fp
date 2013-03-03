mkdir english
cd en
wget -w 2 -m "http://www.gutenberg.org/robot/harvest?filetypes[]=txt&langs[]=en"

for i in `find . -name "*.zip"`; do mv $i . ; done;
cd ..
mkdir en_all
for i in `find english -name "*.zip"`; do unzip $i \*.txt -d en_all/ ; done;
cd en_all
for i in `find . -name "*.txt"`; do mv $i . ; done;
cd ..
for i in `find en_all/ -name "*.txt"`; \
do cat $i | python cleanup.py | \
grep -i -v "project gutenberg" 

cd en_all 
for i in `grep -lir "Character Set : UTF-8"`; do mv $i ../en; done;
