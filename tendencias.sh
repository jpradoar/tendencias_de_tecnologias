#!/bin/bash
>tendencias.txt
clear
date=$(date)
echo -e "================================= \n" $date "\n=================================\n " >> tendencias.txt

lista_tecnologias=("devops" "sysadmin" "linux" "python" "bash" "ansible" "git" "docker" "jenkins" "aws" "virtualizacion" "mysql" "ingles")


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
		echo $resultado; echo $resultado >> tendencias.txt
	done
done


echo -e "\n================================= \n" ESTADISTICAS "\n=================================\n " >> tendencias.txt
for z in "${lista_tecnologias[@]}"
do
        cat tendencias.txt | sort -n | grep $z | cut -d'>' -f2 | awk '{sum += $1}END{print sum}' | sed 's/$/ '$z' /g' >> tendencias.txt
done

cat tendencias.txt
