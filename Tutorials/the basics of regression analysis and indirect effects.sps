* Dit is de syntax om de basics van regressie analyse te oefenen.
* Erik van Ingen (e.j.vaningen@uvt.nl) / April 2011. 

* De gebruikte data is dezelfde als in de handleiding over werken met SPSS syntax. 
* En deze is hier te downloaden: http://spitswww.uvt.nl/~ejvingen/spss tutorial2.sav. 
get file= "F:\spss tutorial2.sav".						                           /* dit is de directory van mijn USB stick.
*get file="M:\docs\onderwijs\SPSS handleiding\spss tutorial2.sav".

set tnumbers=both onumbers=both ovars=both tvars=both.          /* zie handleiding SPSS syntax.

* STAP 1: variabelen bekijken. 
* tevredenheid.
freq a170.
descr a170.                        /* wat rechts-scheef maar red continu - richting klopt.
* leeftijd.
freq x003.

* MODEL 1.
regres /dep= a170 /enter= x003.
* lineair?.
graph /line= mean(a170) by x003.

* burgerlijke status.
freq x007.
* hercoderen burg status.
recode x007 (1,2=1)(3,4=2)(5=3)(6=4) into x007b.
var lab x007b "burgerlijke status".
val lab x007b 1 "relatie" 2 "gescheiden" 3 "weduwe(naar)" 4 "single".
freq x007b.
* dummies maken. 
comp rel= x007b=1.
comp gesch= x007b=2.
comp wedu= x007b=3.
comp sing= x007b=4.
freq rel to sing.

* MODEL 2. 
regres /dep= a170 /enter= gesch wedu sing.

* MODEL 3.
regres /dep= a170 /enter= gesch wedu sing x003.



* ------------------- DEEL II : INTERMEDIATIE EN SCHIJNEFFECTEN -----------------------.
* verder met voorgaande model. 
regres /dep= a170 /enter= gesch wedu sing.

* rel person.
freq f034.
recode f034 (missing=sysmis)(1=1)(2,3=0) into relper.
freq relper.

* schijnverband?.
regres /dep= a170 /enter= gesch wedu sing /enter= relper.

* eenzaamheid.
freq a013.

* intermediatie?.
regres /dep= a170 /enter= gesch wedu sing /enter= a013.


