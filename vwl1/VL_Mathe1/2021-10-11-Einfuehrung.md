# 11.10.21 Einführung

**Ziel der Linearen Algebra**: Lösung von linearen Gleichungs / Optimierungsproblemen



### Vektoren und Skalarprodukte

Beispiel: Welche Kosten *K* entstehen, wenn vom Produkt *i* mit *i* = 1,...,n jeweils v1 Stück zum Preis *p* gekauft werden sollen?
$$
v = \left(\begin{array}{c} v_1 \\ ... \\ v_n \end{array}\right) ,
p = \left(\begin{array}{c} p_1 \\ ... \\ p_n \end{array}\right)  \\
\rightarrow K = \sum_{i=1}^n = v_i p_1 = <v_ip>  \implies \text{Skalarprodukt}
$$
**Skalarprodukt:** elementweise Multiplikation zweier Vektoren + aufaddieren, Notation = $(x,y)$ 

weitere vektoroperationen: 

- Addition: x+y
    - $\left(\begin{array}{c} x_1 \\ ... \\ x_n \end{array}\right) + \left(\begin{array}{c} y_1 \\ ... \\ y_n \end{array}\right) := \left(\begin{array}{c} x_1+y_1 \\ ... \\ x_n + y_n \end{array}\right) $
- Substraktion x-y
    - gleich wie bei Addition, nur $x-y = x+(-1)y$
- Skalarmultiplizieren: *v \* alpha*  mit alpha einer reellen Zahl
    - $a \left(\begin{array}{c} v_1 \\ ... \\ v_n \end{array}\right) := \left(\begin{array}{c} av_1 \\ ... \\ av_n \end{array}\right) $

**Gesetze**:

1. x + y = y + x (*Kommutativ*)

2. x + (y + z) = (x + y) + z (*Assoziativ*)

3. a(x + y) = ax + ay (*Disitributiv*)

    - Beweis : 
$$
a (x+y) = 
        a(\left(\begin{array}{c} x_1 \\ ... \\ x_n \end{array}\right) + \left(\begin{array}{c} y_1 \\ ... \\ y_n 
        \end{array}\right)) = 
        
        \left(\begin{array}{c} a(x_1+y_1) \\ ... \\ a(x_n+y_n) \end{array}\right) = 
        
        \left(\begin{array}{c} ax_1+ay_1 \\ ... \\ ax_n+ay_n \end{array}\right)
        
        \\ = \left(\begin{array}{c} ax_1 \\ ... \\ ax_n \end{array}\right) + \left(\begin{array}{c} ay_1 \\ ... \\ ay_n 
        \end{array}\right) = 
        
        a\left(\begin{array}{c} x_1 \\ ... \\ x_n \end{array}\right) + a\left(\begin{array}{c} y_1 \\ ... \\ y_n 
        \end{array}\right) = \bold{ax + ay}
$$

​        

4. (ab)x = a(bx) (*auch Distributiv*)



#### Euklidisches Skalarprodukt 

Notation:  $|x| = \sqrt{(x,x)} $ -> Länge des Vektors x 

Eigenschaften: 

1. *Symmetrie*: (x,y) = (y,x) 

2. *Linearität*: (x,y + z) = (x,y) + (x,z) 

    - (ax,y) = a(x+y) 

3. *Definitheit*: |x| > 0, außer Nullvektor 
   
4. *Dreiecksungleichung*: |x+y| $\leq$ |x| + |y|

    

Fancy Eigenschaften: 

- Allgeimeiner Kosinus Satz: Mit alpha = Winkel zwischen den Vektoren

    $  (x,y) = |x||y|\cos(\alpha) \\ \implies |(x,y)| \leq |x||y|$

- Orthogonalität: wenn (x,y) = 0 : senkrecht aufeinander



**Beispielrechnung: **Bestimme Winkel zwischen x und y
$$
x = \left(\begin{array}{c} 0 \\ 2 \\ 1 \\ 2 \end{array}\right)
y = \left(\begin{array}{c} 4 \\ 0 \\ 0 \\ -3 \end{array}\right)
\\
<x,y> = |x|*|y|* cos(\alpha) 
\\
\text{Umstellen: }
cos(\alpha) = \frac{<x,y>}{|x|*|y|}
\\
\text{Rechnen: }
\\
<x,y>= 0*4 + 2*0 + 1*0 + 2*-3 = -6 
\\
|x| = \sqrt{0*0 + 2*2 + 1*1 + 2*2} = 3
\\
|y| = \sqrt{4*4+0*0+0*0+-3*-3} = 5
\\
\implies cos(\alpha) = \frac{-6}{3*5} = arccos(\frac{-6}{15}) 
\implies \alpha =113,6°
$$


#### Einheitsvektoren: 

> **def**: Einheitsvektor $e_i$ heißt eine 1 an Stelle *i* und sonst 0, BSP: $e_1 = \left(\begin{array}{c} 1 \\ 0 \\ ... \\ 0 \end{array}\right)$ 

jeder Vektor lässt sich durch Einheitsvektoren darstelle

\-\> Einheitsv. $(e_1,...,e_n)$ sind Basis von $R^n$

