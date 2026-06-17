




#!/bin/bash

lista=/data1/elisa/00_2026/04_dromiciops_2026/03_archivosfasta
scripts=/data1/elisa/00_2026/04_dromiciops_2026/scripts/busted

while IFS= read -r i
do
    echo "hyphy busted -CPU 2 --srv Yes --rates 3 --alignment /data1/elisa/00_2026/04_dromiciops_2026/03_archivosfasta/03_modheader/${i}.fasta --tree /data1/elisa/00_2026/03_dromiciops_2026/05_busted/trees/Bozinovici_tree.nwk --branches "Foreground" --output /data1/elisa/00_2026/04_dromiciops_2026/06_busted/Bozinovici/json/${i}.json < <(echo "exit") | tee /data1/elisa/00_2026/04_dromiciops_2026/06_busted/Bozinovici/outfiles/${i}.out"
done < "$lista/listafasta.txt" > $scripts/Bozinovici.txt

echo '#!/bin/bash

source activate /opt/miniconda3/bin/activate/
conda activate elihyphy' | cat - $scripts/Bozinovici.txt > temp_file && mv temp_file $scripts/busted_Bozinovici.sh
