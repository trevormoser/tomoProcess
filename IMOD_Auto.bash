#!/bin/bash

start_time=$(date +%s)

export IMOD_DIR=/opt/apps/imod/imod_4.11.12/

home=$(pwd)
dir=AlignedStacks
yaml="metadata-tomo.yaml"
topazModel=$(cat $yaml | grep topaz_model | awk '{print $2}')
topazDir="denoised"_$topazModel

#For every subdirectory within /AlignedStacks/, run batchruntomo
#Batchruntomo makes another subdirectory within each tilt directory 
#with the same name containing etomo files and output

for entry in $dir/*
do
	tiltName=${entry#*/}
	echo $tiltName

	if [[ "$topazModel" == "NA" ]]
	then
       		target=AlignedStacks/$tiltName
	else
		target=AlignedStacks/$tiltName/$topazDir
	fi

	if [ -d $target/$tiltName ] ;
	then
		echo "IMOD has already been run in "$target/$tiltName/", skipping..."
	else
		batchruntomo -di cryoDirective.adoc -ro $tiltName -cu $target -m -g 1 > $target/${tiltName}_log.out 
		cp $target/$tiltName/*.st $target
		cp $target/$tiltName/*.rawtlt $target
	fi
done

end_time=$(date +%s)
echo "It took $(($end_time - $start_time)) seconds to complete this job..."

