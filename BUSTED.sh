## English:
## Generates a script to run BUSTED for each gene in a specific list.
## Some guidelines:
##   - listafasta.txt = A list containing the names of all the genes to be analyzed. Names should not include the file extension.
##   - Keep in mind that the directory structure is as follows:
##     - Bozinovici -> Parent directory (In my case, named after one of the branches I wanted to evaluate for selection; here, it was the "Foreground" branch).
##       - json -> Directory within "Bozinovici". It will contain a folder for each gene in the run, where the analysis results will be saved.
##       - outfiles -> Directory within "Bozinovici". It will contain the log summaries for all runs. These files are later used to "extract" candidate genes under selection.
##   - It is worth mentioning that the same FASTA files are used to run both CodeML and BUSTED.

# Español:
## Genera un script que corre CodeML para cada gen de una lista determinada.
## Algunas indicaciones:
##   - listafasta.txt = Lista con los nombres de todos los genes sobre los que se quiere correr el análisis. Los nombres no debe incluir la extensión del archivo.
##   - Considerar que la estructura de los directorios es la siguiente:
##     - Bozinovici -> Directorio "parental" (En mi caso, es el nombre de una de las ramas sobre la que quería evaluar selección. En este caso, fue la rama "Foreground).
##       - json -> Directorio dentro de "Bozinovici". Es el que tendrá una carpeta para cada gen de la corrida, donde quedarán los resultados del análisis.
##       - outfiles -> Directorio dentro de "Bozinovici". Es el que tendrá los resumenes para todas las corridas. Sobre estos archivos luego se "extraen" los genes candidatos a selección.
##    - Es relevante mencionar que los archivos fasta utlizados para correr CodeML y BUSTED son los mismos.


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
