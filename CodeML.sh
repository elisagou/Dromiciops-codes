
## English:
## Generates a script to run CodeML for each gene in a specific list.
## Some guidelines:
##   - listafasta.txt = A list containing the names of all the genes to be analyzed. Names should not include the file extension.
##   - Keep in mind that the directory structure is as follows:
##     - 05_Bozinovici -> Parent directory (In my case, named after one of the branches I wanted to evaluate for selection; here, it was the "Foreground" branch).
##       - resultados_codeml -> Directory within "05_Bozinovici". It will contain a folder for each gene in the run, where the analysis results will be saved.
##       - stdout -> Directory within "05_Bozinovici". It will contain the log summaries for all runs. These files are later used to "extract" candidate genes under selection.


# Español:
## Genera un script que corre CodeML para cada gen de una lista determinada.
## Algunas indicaciones:
##   - listafasta.txt = Lista con los nombres de todos los genes sobre los que se quiere correr el análisis. Los nombres no debe incluir la extensión del archivo.
##   - Considerar que la estructura de los directorios es la siguiente:
##     - 05_Bozinovici -> Directorio "parental" (En mi caso, es el nombre de una de las ramas sobre la que quería evaluar selección. En este caso, fue la rama "Foreground).
##       - resultados_codeml -> Directorio dentro de "05_Bozinovici". Es el que tendrá una carpeta para cada gen de la corrida, donde quedarán los resultados del análisis.
##       - stdout -> Directorio dentro de "05_Bozinovici". Es el que tendrá los resumenes para todas las corridas. Sobre estos archivos luego se "extraen" los genes candidatos a selección.


#!/bin/bash

lista=/data1/elisa/00_2026/04_dromiciops_2026/03_archivosfasta
scripts=/data1/elisa/00_2026/04_dromiciops_2026/scripts/codeml

while IFS= read -r i
do
    mkdir /data1/elisa/00_2026/04_dromiciops_2026/04_codeml_branchsite/05_Bozinovici/resultados_codeml/${i}
done < "$lista/listafasta.txt"

while IFS= read -r i
do
    echo "ete3 evol -t /data1/elisa/00_2026/03_dromiciops_2026/04_codeml/05_Bozinovici/trees/tree.nwk --alg /data1/elisa/00_2026/04_dromiciops_2026/03_archivosfasta/03_modheader/${i}.fasta --models bsA bsA1 --clear_all -v 3 -o /data1/elisa/00_2026/04_dromiciops_2026/04_codeml_branchsite/05_Bozinovici/resultados_codeml/${i} --cpu 3 | tee /data1/elisa/00_2026/04_dromiciops_2026/04_codeml_branchsite/05_Bozinovici/stdout/${i}.stdout.txt"
done < "$lista/listafasta.txt" > $scripts/b_Bozinovici.txt

echo '#!/bin/bash

source activate /opt/miniconda3/bin/activate/
conda activate etetoolkit' | cat - $scripts/b_Bozinovici.txt > temp_file && mv temp_file $scripts/b_Bozinovici.sh
