# Markup Interactive Language Format
#####  maturita project and personal project
##### by David Šimek and Petr Hruška
##### publishing under <ins>GNU GENENRAL PUBLIC LICENSE V3.0</ins> (more in LICENSE file)

----

#### showcase:
##### source code:
```
"Čus"  color red   margin 10px bg blue  padding 30px
"Hi"   color green margin 20px bg red   padding 30px
"Đ]¶#" color blue  margin 30px bg green padding 30px
```
##### generated HTML:
```
<div style="background-color: rgba(0, 0, 255, 1.0); color: rgba(255, 0, 0 ,1.0); margin: 10px; padding: 30px;">Čus</div>
<div style="background-color: rgba(255, 0, 0, 1.0); color: rgba(0, 255, 0 ,1.0); margin: 20px; padding: 30px;">Hi</div>
<div style="background-color: rgba(0, 255, 0, 1.0); color: rgba(0, 0, 255 ,1.0); margin: 30px; padding: 30px;">Đ]¶#</div>
```
##### result:
![obrazek](https://github.com/davidSimek/MarkupInteracticeLanguageFormat/assets/119676792/efd73962-c77f-4576-b3dc-ed2d2be048ea)

-----

### currently working on:
transpiler to html  

-----
### idea:
- simple markup language usable by non developers
- free transpiler and other tools
- easy to use UI (in future)

-----

### is it just markdown copy???
It really seems similar to markdown, I see than and one can argue it has nothing new compared to markdown. That might be valid point, but it has different syntax approach and target group.


##### differences from markdown:    
- no xml markings
- interactivity
- per line evaluation (with some non-breaking exceptions)

-----

### motivation:
This project has 2 main goals.
- make us get maturita without passing maturita exam
- provide easy and free workflow for making:
    - presentations
    - basic webs
    - teaching/learning materials
    - good looking notes

-----

### technology used:
- haskell
- html  
