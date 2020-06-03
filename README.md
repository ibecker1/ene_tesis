# Bienvenidxs!

Este repositorio constituye la base del proyecto para el análisis de datos en el marco del curso _Herramientas para la Investigación Social Cuantitativa: Ciencia Abierta y Software Libre_ del Magíster en Ciencias Sociales de la Universidad de Chile.

Acá iré subiendo material de manera continua para que puedas replicar y reproducir la investigación que estoy realizando.

En base a las constantes problemáticas de inserción laboral juvenil en las últimas décadas, además de una subutilización de las fuentes de datos disponibles para medir sus condiciones, el presente proyecto busca aportar en una cuantificación de este fenómeno, mediante el uso de la Encuesta Nacional de Empleo del Instituto Nacional de Estadísticas.

# Objetivos proyecto

## Objetivo general

Caracterizar la temporalidad contractual de la población joven en Chile en base al trimestre marzo-abril-mayo 2019 de la Encuesta Nacional de Empleo.

## Objetivos específicos

* Describir la temporalidad contractual de las y los jóvenes asalariados en Chile, según variables sociodemográficas (como sexo, edad, región de residencia).
* Identificar la temporalidad de la ocupación según las ramas de empleo de la población joven ocupada.
* Caracterizar la temporalidad contractual según el nivel educativo de la persona joven asalariada.

# Variables a utilizar

Dada la magnitud del fenómeno, y ya que solo cuento con un semestre para su trabajo, he decidido hacer un ejercicio resumido pero que logre entregar información sustantiva sobre el fenómeno. En este sentido, he decidido usar tanto variables de empleo como sociodemográficas, las cuales describiré a continuación (entre paréntesis el nombre de la variable en la base de datos):

Variables de empleo: 
+ Situación de empleo a nivel desagregado: permite filtrar la base de datos para trabajar solo con quienes están ocupadxs.
+ Rama de actividad: permite conocer el área de actividad económica donde está empleada la persona (r_p_rev4cl_caenes).
+ Formalidad ocupacional: permite saber si la ocupación es de caracter formal o informal, siendo un buen proxy de calidad del empleo (ocup_form).
+ Posesión de contrato: permimte filtrar por quienes poseen o no contrato (b8).
+ Temporalidad contractual: variable categórica que nos muestra la duración de este contrato (definido o indefinido) (b9).

Variables sociodemográficas:
+ Sexo: para identificar las desiguales condiciones por sexo registral (sexo).
+ Edad: edad simple **numérica** (edad).
+ Región de residencia: para saber cómo se comportan las variables a nivel local (region).
+ Nivel educativo: como gran indicador de desigualdades sociales (cine).

# Estructura de datos

En base a lo que señalaba en un comienzo, la idea de este proyecto es que sea replicable y reproducible para quien desee investigar sobre inserción laboral juvenil. Así, se basa en la estructura del [Protocolo TIER](https://www.projecttier.org/tier-protocol/demo-project/), conteniendo carpetas donde subiré:
+ Data (Datos): contiene las bases de datos ocupadas en las diversas etapas de la investigación (Análisis, Iniciales e intermedias).
+ Output (Resultados): acá agregaré gráficos y tablas (ojalá mapas).
+ Script: son las hojas de trabajo para los procesamientos en R, diferenciadas según cada etapa.

# Autor

Mi nombre es Ignacio Becker Bozo, y el proyecto se enmarca en el desarrollo de mi tesis: "Segmentación del mercado laboral juvenil en Chile: tendencias y modalidades de la década 2010-2020", para optar al grado de Magíster en Ciencias Sociales de la Universidad de Chile.
