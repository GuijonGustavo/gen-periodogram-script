#!/bin/bash
# Made by:
# Gustavo Magallanes-Guijón <gustavo.magallanes.guijon@ciencias.unam.mx>
# Instituto de Astronomia UNAM
# Ciudad Universitaria
# Ciudad de Mexico
# Mexico
object=AO0235+164
freq=gamma

touch sequece-rp.sh
chmod u+x sequece-rp.sh

touch all-rp.sh
chmod u+x final-rp.sh


echo "#!/usr/bin/env Rscript" > sequece-rp.sh
echo "#!/bin/sh " > final-rp.sh

echo "library(RobPer)" >> sequece-rp.sh

echo "data = read.table('data/${object}-${freq}-clean.dat',header = FALSE)" >> sequece-rp.sh
echo "rp<- RobPer(data,model='sine', regression='tau', weighting = FALSE, var1=FALSE, periods = 1:100)" >> sequece-rp.sh
echo "write.csv(rp, '${object}-${freq}-rp-1-100.dat', row.names = FALSE)" >> sequece-rp.sh
echo "write.csv(max(rp), '${object}-${freq}-max-1-100.dat', row.names = FALSE)" >> sequece-rp.sh
echo -e '\n' >> sequece-rp.sh
echo -e '\n' >> sequece-rp.sh

echo "cat ${object}-${freq}-rp-1-100.dat > ${object}-${freq}-rp-all.dat" >> final-rp.sh

for i in $(seq 1 21);
do

#i=$((i));
j=$((i+1));
echo "data = read.table('data/${object}-${freq}-clean.dat',header = FALSE)" >> sequece-rp.sh
echo "rp<- RobPer(data,model='sine', regression='tau', weighting = FALSE, var1=FALSE, periods = ${i}01:${j}00)" >> sequece-rp.sh
echo "write.csv(rp, '${object}-${freq}-rp-${i}01-${j}00.dat', row.names = FALSE)" >> sequece-rp.sh
echo "write.csv(max(rp), '${object}-${freq}-max-${i}01-${j}00.dat', row.names = FALSE)">> sequece-rp.sh
echo -e '\n' >> sequece-rp.sh
echo -e '\n' >> sequece-rp.sh


echo "cat ${object}-${freq}-rp-${i}01-${j}00.dat >> ${object}-${freq}-rp-all.dat" >> final-rp.sh

i=$((i+i));
j=$((i+j));
done

echo "sed -E '/\"x\"|NA/d' ${object}-${freq}-rp-all.dat > ${object}-${freq}-rp-final.dat" >> final-rp.sh
