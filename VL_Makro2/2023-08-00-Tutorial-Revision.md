# Revision Session

## Revenue Function of a Firm

$$
\Pi = pf (zeH)-wH
$$

1): Diff w.r.t w

$$
\frac{ d\Pi }{dw} = pf'(z E(w) H)*zE'(w)H-H= 0 \\
= pf'(zE(w)H) zE'(w)=1
$$

2): Diff w.r.t H

$$
\frac{ d\Pi }{dw} = pf'(zE(w)H)*zE(w)-w = 0 \\
= pf'(zE(w)H)*zE(w)-w = w
$$

Divide 1) by 2)

$$
\frac{ pf'(zE(w)H) zE'(w) }{pf'(zE(w)H) zE(w)} = \frac{ 1 }{w} \\
\frac{ E'(w) }{E(w)} = \frac{ 1 }{w} \\
\frac{ w*E'(w) }{E(w)} = 1 \gets \text{ Solow Condition} \\
$$

Einsetzen von *E(w)* mit v=outside option und a=elasticity 

$$
E(w) = ({\frac{ w-v }{v}})^\alpha \\
E'(w) = \alpha (\frac{ w-v }{w})^{\alpha-1} 
* \frac{ d }{dw}(\frac{ w }{v}-1) = 0 \\

E'(w) = \alpha (\frac{ w-v }{w})^{\alpha-1} 
* \bigg( \frac{v(1)-w(0)  }{v^2}\bigg) \\

\implies E'(w) = \alpha (\frac{ w-v }{w})^{\alpha-1} 
* \frac{ 1 }{v}
$$

Dann

$$
\frac{ E'(w) }{E(w)} = \frac{ \alpha (\frac{ w-v }{w})^{\alpha-1} 
* \frac{ 1 }{v} }{({\frac{ w-v }{v}})^\alpha} \\

= \frac{ \alpha (\frac{ 1 }{v}) }{(\frac{ w-v }{w})^{\alpha-\alpha+1}} \\

\implies \frac{ E'(w) }{E(w)}= \frac{ \alpha }{w-v}
$$

Differentation Rule: (important)

$$
Diff:  \frac{x}{y} \to \frac{ y }{y^2} = \frac{ 1 }{y}
$$

## Outside Option

1): 

$$
v=(1-u)w+ucw \\
v = w-uw+ucw \\
v = w(1-u+uc) \\
v = w(1-u(1-c))
$$

place 1) in optimal wage

$$
w = \frac{ v }{1-\alpha} \\
w = \frac{ w(1-u(1-c)) }{1-\alpha} \\
\frac{ w }{w} = \frac{ 1-u(1-c) }{1-\alpha} \\
1-a = 1-u(1-c) \\
u(1-c) = 1-1+\alpha \\
u^* = \frac{ \alpha }{1-c}
$$

interpret: unemployment rate depends on

- *c*=replacement ratio (how high unempl. benefit is as fraction of wages)
- alpha=elasticity

=> higher unempl. benefits => higher unempl. rate

