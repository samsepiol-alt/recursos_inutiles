#este es un comentario

echo "texto que imprime"


#declaracion condicional
echo "Introduce un número" 
read a #El input del usuario se almacena en una variable de nombre a
b=50 #variable b con valor 50
if [ $a -eq $b ]; then
echo "Mismo número"
else
echo "Número diferente"
fi


#declaracion de bucles

for i in {1..5}; do
    echo "Número $i"
done

while [ false ]; do
    echo "infinito"
done
