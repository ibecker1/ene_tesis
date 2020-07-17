# Bienvenidxs! *Léeme*

Este repositorio constituye la base del proyecto para el análisis de datos en el marco del curso _Herramientas para la Investigación Social Cuantitativa: Ciencia Abierta y Software Libre_ del Magíster en Ciencias Sociales de la Universidad de Chile.

En la carpeta _Scripts_ podrás encontrar un archivo llamado `master_script`. Con él podrás replicar y reproducir todo el informe de resultados!

En base a las constantes problemáticas de inserción laboral juvenil en las últimas décadas, además de una subutilización de las fuentes de datos disponibles para medir sus condiciones, el presente proyecto busca aportar en una cuantificación de este fenómeno, mediante el uso de la Encuesta Nacional de Empleo del Instituto Nacional de Estadísticas.

# Objetivos proyecto

## Objetivo general

Caracterizar la temporalidad contractual de la población joven en Chile en base al trimestre marzo-abril-mayo 2019 de la Encuesta Nacional de Empleo.

## Objetivos específicos

* Describir la temporalidad contractual de las y los jóvenes asalariados en Chile, según variables sociodemográficas (como sexo, edad, región de residencia) y educativa.
* Identificar la temporalidad de la ocupación según las ramas de empleo de la población joven ocupada.
* Caracterizar la posesión de contrato por variables sociodemográficas.

# Variables a utilizar

Dada la magnitud del fenómeno, y ya que solo cuento con un semestre para su trabajo, he decidido hacer un ejercicio resumido pero que logre entregar información sustantiva sobre el fenómeno. En este sentido, he decidido usar tanto variables de empleo como sociodemográficas, las cuales describiré a continuación (entre paréntesis el nombre de la variable en la base de datos):

Variables de empleo: 
+ Situación de empleo a nivel desagregado: permite filtrar la base de datos para trabajar solo con quienes están ocupadxs.
+ Posesión de contrato: permite filtrar por quienes poseen o no contrato (b8).
+ Temporalidad contractual: variable categórica que nos muestra la duración de este contrato (definido o indefinido) (b9).
+ Factor de expansión: variable que permite expandir resultados a nivel poblacional, bajo diseño muestral complejo (fact_cal).

Variables sociodemográficas:
+ Sexo: para identificar las desiguales condiciones por sexo registral (sexo).
+ Edad: edad simple **numérica** (edad).
+ Región de residencia: para saber cómo se comportan las variables a nivel local (region).
+ Nivel educativo: como gran indicador de desigualdades sociales (cine).

# Estructura del proyecto

En base a lo que señalaba en un comienzo, la idea de este proyecto es que lo puedas replicar y reproducir para quien desee investigar sobre inserción laboral juvenil. Así, se basa en la estructura del [Protocolo TIER](https://www.projecttier.org/tier-protocol/demo-project/), conteniendo carpetas donde encontrarás:
+ Datos: contiene las bases de datos ocupadas en las diversas etapas de la investigación (Análisis, Iniciales e intermedias).
+ Resultados: acá agregué los gráficos y tablas.
+ Script: son las hojas de trabajo para los procesamientos en R, diferenciadas según cada etapa. En la carpeta de Procesamiento encontrarás las selección de base y recodificaciones varias. En el de Análisis encontrarás los relativos a la producción de resultados. Con el `master_script` de la carpeta inicial podrás replicar todo el `reporte_reproducible.pdf` con unos pocos _clicks_.

# Autor

Mi nombre es Ignacio Becker Bozo, y el proyecto se enmarca en el desarrollo de mi tesis: "Segmentación del mercado laboral juvenil en Chile: tendencias y modalidades de la década 2010-2020", para optar al grado de Magíster en Ciencias Sociales de la Universidad de Chile.
