#!/bin/bash

# modo de uso
# descargar el script
# asignarle permisos de ejecucion:  chmod +x script.sh
# ejecutar el script con output a un archivo:  ./script.sh >output.txt

# Vars
t1="#################################################\n##"
t2="##########\n#################################################"

echo -e "$t1 URLs DE EMPLEO  - $(date +%d-%m-%Y) $t2 "

lista_tecnologias=("cisco" "juniper" "devops" "linux")


for i in "${lista_tecnologias[@]}"
do
	sitios=(
	"http://www.universobit.com.ar/empleos-busqueda-$i.html"
	"https://www.computrabajo.com.ar/ofertas-de-trabajo/?q=$i"
        "http://www.bumeran.com.ar/buenos-aires/empleos-busqueda-$i.html"
        "https://www.zonajobs.com.ar/resultados?palabra=$i"
        "http://www.bolsatrabajo.com.ar/buscar-empleo/#region=distrito-federal&page=1&job=$i"
        "http://ar.jobomas.com/Trabajo-de-$i"
        "https://ar.indeed.com/trabajo?q=$i&l=Ciudad+Aut%C3%B3noma+de+Buenos+Aires%2C+Buenos+Aires"
	)
	for x in "${sitios[@]}"
	do
		numero=$(curl --silent -R $x | grep -i $i | wc -l )
		resultado="$x  =======>$numero"
		echo $resultado; echo $resultado 
	done
done


echo -e "$t1 ESTADISTICAS EN PAGINAS DE EMPLEO  - $(date +%d-%m-%Y) $t2 "
for z in "${lista_tecnologias[@]}"
do
        cat tendencias.txt | sort -n | grep $z | cut -d'>' -f2 | awk '{sum += $1}END{print sum}' | sed 's/$/ '$z' /g' 
done
echo -e "\n"

echo -e "$t1 POPULARDAD EN INSTAGRAM - $(date +%d-%m-%Y) $t2 "
for r in "${lista_tecnologias[@]}"
do
	echo "URL: https://www.instagram.com/$i "; curl -s https://www.instagram.com/$r/?hl=es-la |grep '<link' | grep publicaciones |cut -d'=' -f5 - |cut -d'-' -f1; echo -e '\n'
done
echo -e "\n"

echo -e "$t1 POPULARDAD EN TWITTER - $(date +%d-%m-%Y) $t2"
for w in "${lista_tecnologias[@]}"
do
	echo "URL: https://twitter.com/$i "; curl -s https://twitter.com/$w| grep "Siguiendo\|Seguidores\|Tweets\|Me gusta" |grep title |cut -d"=" -f3 -| cut -d" " -f1,2 |grep -v ">\|init-data\|Profile"; echo -e "\n"
done
