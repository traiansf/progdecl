% Programare funcțională --- Despre funcții
% Ioana Leuștean (seria 24) Traian Șerbănuță (seria 23)
% Departamentul de Informatică, FMI, UNIBUC ioana@fmi.unibuc.ro, traian.serbanuta@fmi.unibuc.ro


Introducere în $\lambda$-calcul --- Totul din (aproape) nimic
=============================================================

$\lambda$-calcul pentru toate problemele noastre
------------------------------------------------

![All you need is Lambda](Lambda.pdf "Simbolul grecesc lambda"){ width=20% }

- Model de calcul introdus de Alonzo Church
- Formalizează conceptul de computabilitate
  * Ce clase de probleme pot fi rezolvate cu un calculator?
- Baza programării funcționale
  * toate limbajele funcționale sunt la bază un $\lambda$-calcul

Ce este programarea funcțională
-------------------------------

- Paradigmă de programare ce folosește funcții modelate după
  funcțiile din matematică
- Programele se obțin ca o combinație de _expresii_
- Expresiile pot fi valori concrete, variable și _funcții_
- Funcțiile sunt expresii ce pot fi _aplicate_ unor intrări
  * În urma aplicării, o funcție e _redusă_ sau _evaluată_
- Funcțiile sunt valori (_first-class citizens_)
  * pot fi folosite ca argumente pentru alte funcții

. . .

### Puritate
- Toate limbajele funcționale sunt bazate pe lambda-calcul
- Unele limbaje încorporează și lucruri ce nu sunt reprezentabile în lambda-calcul
- Haskell e un limbaj _pur_, pentru ca nu face acest compromis


Ce este o funcție
-----------------

- Relație între două mulțimi (de intrare și de ieșire)
- Asociază fiecărei intrări _exact_ o ieșire
  * transparență referențială: ieșirea e unic determinată de intrare

### Definirea și evaluarea funcțiilor

- Exemplu definire: $f(x) = x + 1$ 
  * o funcție numită $f$
  * care dată fiind o valoare de intrare, să zicem $x$,
  * obține valoarea de ieșire conform expresiei $x + 1$
- Exemplu evaluare:

    $f(1) = 1 + 1$ (substitui $x$ cu $1$ in $x + 1$) $= 2$ (simplific)

Structura $\lambda$-expresiilor
-------------------------------

### O expresie este definită recursiv astfel:
- este o variabilă (un identificator)

  $x$
- se obține prin _abstractizarea_ unei variabile $x$ într-o altă expresie $e$

    $\lambda x . e$ \hfill exemplu: $\lambda x . x$
- se obține prin _aplicarea_ unei expresii $e_1$ asupra alteia $e_2$

    $e_1 \; e_2$ \hfill exemplu: $(\lambda x . x) y$

### Operația de abstractizare $\lambda x . e$
- reprezintă o funcție _anonimă_
- constă din două parți: _antetul_ $\lambda x .$  și _corpul_ $e$
- variabila $x$ din anter este _parametrul_ funcției
  * _leagă_ aparițiile variabilei $x$ în $e$ (ca un cuantificator)
  * Exemplu: $\lambda x . x y$ --- $x$ e _legată_, $y$ e _liberă_
- Corpul funcției reprezintă expresia care definește funcția
  

$\alpha$-eqhivalență
--------------------

- Redenumirea unui argument și a tuturor aparițiilor sale legate
  * Exemplu: $\lambda x . x \equiv_\alpha \lambda y . y \equiv_\alpha \lambda a . a$
  * Asemanator cu: $f(x) = x$ vs $f(y) = y$ vs $f(a) = a$
- Numele asociat argumentului e pur formal
  * E necesar doar ca să îl pot recunoaște în corpul funcției
  * Există reprezentări fără argumente (e.g. [indecși de Bruijn](https://en.wikipedia.org/wiki/De_Bruijn_index))
- $\alpha$-echivalența redenumește _doar_ aparițiile legate ale argumentului
  * Exemple:
  
    $(\lambda x . x) x \not\equiv_\alpha (\lambda y . y) y$

    $(\lambda x . x) x \equiv_\alpha (\lambda y . y) x$

$\beta$-reducție
----------------

### Cum aplicăm o funcție (anonimă) unui argument?
înlocuim aplicația cu corpul funcției în care
substituim aparițiile variabilei legate cu argumentul dat.

$$(\lambda {\color{red}x} . {\color{darkred}e}) {\color{green!50!black}e'} \rightarrow_\beta {\color{darkred}e}[{\color{red}x} := {\color{green!50!black}e'}]$$

### Exemple
$$(\lambda {\color{red}x} . {\color{darkred}x}) {\color{green!50!black}y} \rightarrow_\beta {\color{darkred}x}[{\color{red}x} := {\color{green!50!black}y}] = {\color{green!50!black}y}$$

$$(\lambda {\color{red}x} . {\color{darkred}x \; x}) {\color{green!50!black} \lambda x . x} \rightarrow_\beta {\color{darkred}x \; x}[{\color{red}x} := {\color{green!50!black} \lambda x . x}] =
(\lambda {\color{red}x} . {\color{darkred}x}) {\color{green!50!black} \lambda x . x} \rightarrow_\beta {\color{darkred}x }[{\color{red}x} := {\color{green!50!black} \lambda x . x}] = \lambda x . x$$

$\beta$-reducție --- alte exemple
---------------------------------

### Aplicarea funcțiilor se grupează la stânga

$(\lambda x.x)(\lambda y.y)z = ((\lambda x.x)(\lambda y.y))z$

. . .

$((\lambda x.x)(\lambda y.y))z \rightarrow_\beta (x[x := \lambda y.y])z = (\lambda y.y) z$

$(\lambda y.y) z \rightarrow_\beta y [ y := z ] = z$

### Funcție cu variabile libere

$(\lambda x.x\; y)z \rightarrow_\beta (x\; y[x := z]) = z\; y$

### $lambda$ are are prioritate foarte mică 

$\lambda x . x\; \lambda x . x = \lambda x . (x\; (\lambda x . x))$


Mai multe argumente
-------------------

- Funcțiile anonime au _un singur_ parametru
  * și pot fi aplicate _unui singur_ argument
- Simulăm mai multe argumente prin abstractizare repetată
  
  Exemplu: $\lambda x . \lambda y . x\; y$
  * Citim: primește ca argumente $x$ și $y$ și aplică pe $x$ lui $y$
  * De fapt e o funcție de $x$ care în urma aplicării dă o funcție de $y$
  * Procesul se numește Currying  (de la Haskell Curry)
  * Pentru simplificarea notației, scriem 
    $\lambda x\; y . x\; y$ în loc de $\lambda x . \lambda y . x \; y$

### Exemplu de evaluare

  $(\lambda x\; y.x\; y)(\lambda z. a) 1 = (\lambda x . (\lambda y.x\; y)) (\lambda z. a) 1 = ((\lambda x . (\lambda y.x\; y)) (\lambda z. a)) 1 \onslide<2->{\rightarrow_\beta ((\lambda y.x\; y)[x := \lambda z.a]) 1 = (\lambda y . (\lambda z . a) y) 1}
  \onslide<3->{\rightarrow_\beta ((\lambda z.a) y)[y := 1] = (\lambda z . a) 1} \onslide<4->{\rightarrow_\beta a[z := y] = a}$


Evaluarea ca simplificare
-------------------------

### Forma normală $\beta$

- O $\lambda$-expresie este în forma normală $\beta$ dacă regula $\beta$ nu mai poate fi aplicată asupra ei.
- Corespunde ideii de expresie complet evaluată
- Evaluarea unei $\lambda$-expresii constă în simplificarea ei
  * folosind regula $\beta$ până la ajungerea la o formă normală
- O $\lambda$-expresie nu poate avea mai multe forme normale
  * modulo $\alpha$-conversie

### Exemple

- $\lambda x . x$ este în formă normală
- $(\lambda x .x ) z$ nu este în formă normală ($z$ este)
- $z (\lambda x .x )$ este în formă normală

Combinatori
-----------

- _Combinatorii_ sunt $\lambda$-expresii fără variabile libere
- Scopul lor este de a "combina" argumentele primite la intrare

### Contraexemple

- $\lambda y. x$ --- $y$ e legată, dar $x$ este liberă
- $\lambda x. x\; z$ --- $x$ e legată, dar $z$ este liberă

### Exemple distinse

- __combinatorul I__: funcția identitate $\lambda x. x$
- __combinatorul K__: proiecția stângă $\lambda x\; y.x$
- __combinatorul S__: substituție $\lambda x\; y\; z. x z (y z)$
- orice $\lambda$-expresie poate fi obținută dintr-o combinație de S,K, I
- Vă place Tetris? Încercați [Combinatris](https://dirk.rave.org/combinatris/)


Divergență
----------

- Nu toate $\lambda$-expresiile au formă normală
  * cele care au se numesc convergente
  * celelalte se numesc divergente

- Exemplu de expresie divergentă: __combinatorul $\omega$__

  $(\lambda x. x\; x) (\lambda x. x\; x) \onslide<2->{\rightarrow_\beta (x\; x)[x := \lambda x. x\; x] = (\lambda x. x\; x) (\lambda x. x\; x)}$
  

Introducere în Haskell
======================

Cum interacționăm cu codul Haskell
----------------------------------

- Interpretorul (Read-Eval-Print-Loop) GHCi
  - Pot evalua expresii direct în el
  - Pot (re)încărca fișiere editate într-un editor extern
- `Prelude>`{.haskell} - o colecție de funcții standard încărcate automat
- Comenzile GHCi încep cu "`:`"
 
  `:quit`, `:load`, `:reload`, `:type`

Să înțelegem expresiile
-----------------------

- Orice în Haskell este fie expresie, fie declarație
  - declarațiile asociază nume expresiilor

### Exemple

```{.haskell}
Prelude> 1
1
Prelude> 1 + 1
2
Prelude> "Salut"
"Salut"
Prelude> (1 + 2) * 3
9
Prelude> length "Salut" * 2
10
```

- Interpretorul calculează și afișează _forma normală_ a expresiilor

Funcții
-------

- Exemplu: o funcție care înmulțește argumentul cu 3

  `Prelude> triple x = x * 3`{.haskell}

  *  `triple` dă nume funcției anonime `\x -> x * 3`{.haskell}

     trebuie să înceapă cu literă mică
  * `x` este parametrul funcției (pot fi mai mulți)
  * `=` e folosit pentru a defini (declara) valori și funcții
  * `x * 3` este corpul funcției

- aceeași declarație este validă și în interpretor și într-un fișier

Evaluare
--------

- Evaluare prin $\beta$-reducție ca în $\lambda$-calcul
```{.haskell}
Prelude> triple x = x * 3
Prelude> triple 2
--- triple 2 = (\x -> x * 3) 2 --> x * 3[x := 2] = 2 * 3 -->
6
```
- Haskell folosește o formă de evaluare non-strictă, leneșă
- Amână evaluarea cât de mult posibil, până când e forțată din exterior

```{.haskell}
Prelude> fst (1 + 1, error "Unreachable")
2
```

Operatori infix
---------------

Declararea valorilor
--------------------

Funcții aritmetice în Haskell
-----------------------------

Folosirea parantezelor
----------------------

`let`{.haskell} și `where`{.haskell}
-------------------------------------


Șiruri de caractere
===================

Afișarea șirurilor de caractere
-------------------------------

O prima privire asupra tipurilor
--------------------------------

Afișarea șirurilor de caractere
-------------------------------

Definiții globale vs. definiții locale
--------------------------------------

Funcții de concatenare
----------------------

Concatenare și domeniu de vizibilitate
--------------------------------------


Câteva funcții aplicabile listelor
----------------------------------


Tipuri de date
==============

Tipuri de date primare
----------------------

Ce sunt tipurile
----------------

Anatomia unei declarații de date
--------------------------------

Tipuri numerice
---------------

Compararea valorilor
--------------------

Tipul de date `Bool`{.haskell}
------------------------------

Tupluri
-------

Liste
-----


Tipuri
======

La ce folosesc tipurile
-----------------------

Cum citim o signatură de tip
-----------------------------


Currying
--------


Polymorphism
------------


Inferența tipurilor
-------------------


Tipuri pentru declarații
------------------------


Clase de tipuri
===============

Ce sunt clasele de tipuri?
--------------------------

Să revenim la `Bool`{.haskell}
------------------------------

`Eq`{.haskell}
--------------


Instanțierea claselor
---------------------


`Num`{.haskell}
--------------


Clase de tip cu tip implicit?
-----------------------------


`Ord`{.haskell}
--------------

`Enum`{.haskell}
--------------


`Show`{.haskell}
--------------


`Read`{.haskell}
--------------


Instanțele sunt determinate de tip
----------------------------------

Mai multe operații
------------------

