# Markup Interactive Language Format
#####  maturita project and personal project
##### by David Šimek and Petr Hruška
##### publishing under <ins>GNU GENERAL PUBLIC LICENSE V3.0</ins> (more in LICENSE file)

----

#### showcase:
##### source code:
```
#heading# color white bg black fontSize 30px inSpace 20px inJump 20px outSpace 10px
#normal#  color black bg transparent fontSize 15px outSpace 10px
#spacer#  bg black inSpace 2px outJump 10px outSpace 10px

"Is this really a test?" style heading
"Yes it is" style normal
"" style spacer
"red" color red bg black
"green" color green bg black
"blue" color blue bg black
"black" color black bg white
"white" color white bg black
```
##### generated HTML:
```
<div style="background-color: rgba(0, 0, 0, 1.0); color: rgba(255, 255, 255, 1.0); margin: 10px 0px; padding: 20px 20px; font: 30px Arial, sans-serif;">Is this really a test?</div>
<div style="background-color: rgba(0, 0, 0, 0.0); color: rgba(0, 0, 0, 1.0); margin: 10px 0px; padding: 0px 10px; font: 15px Arial, sans-serif;">Yes it is</div>
<div style="background-color: rgba(0, 0, 0, 1.0); color: rgba(0, 0, 0, 1.0); margin: 10px 10px; padding: 2px 10px; font: 15px Arial, sans-serif;"></div>
<div style="background-color: rgba(0, 0, 0, 1.0); color: rgba(255, 0, 0, 1.0); margin: 0px 0px; padding: 0px 10px; font: 15px Arial, sans-serif;">red</div>
<div style="background-color: rgba(0, 0, 0, 1.0); color: rgba(0, 255, 0, 1.0); margin: 0px 0px; padding: 0px 10px; font: 15px Arial, sans-serif;">green</div>
<div style="background-color: rgba(0, 0, 0, 1.0); color: rgba(0, 0, 255, 1.0); margin: 0px 0px; padding: 0px 10px; font: 15px Arial, sans-serif;">blue</div>
<div style="background-color: rgba(255, 255, 255, 1.0); color: rgba(0, 0, 0, 1.0); margin: 0px 0px; padding: 0px 10px; font: 15px Arial, sans-serif;">black</div>
<div style="background-color: rgba(0, 0, 0, 1.0); color: rgba(255, 255, 255, 1.0); margin: 0px 0px; padding: 0px 10px; font: 15px Arial, sans-serif;">white</div>
```
##### result:
![obrazek](https://github.com/davidSimek/MarkupInteracticeLanguageFormat/assets/119676792/0d6f0259-ade7-4c94-8e07-e085c9e898bb)

-----

### currently working on:
transpiler to html  
UI tracking changes and displaying preview

-----

### idea:
- simple markup language usable by non developers
- free transpiler and other tools
- easy to use UI (in future)

-----

### is it just markdown copy???
It really seems similar to markdown, I see than and one can argue it has nothing new compared to markdown. That might be valid point, but it has different syntax approach, target group, and will be more interactive.


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
    - writer styled articles
    - teaching/learning materials
    - good looking notes

-----

### technology used:
- haskell
- html  
### probably will be used in future:
- cpp
- Qt for cpp (for easy UI, file tracking and HTML displaying capabilities)
