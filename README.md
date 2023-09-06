# Markup Interactive Language Format
#####  maturita project and personal project
##### by David Šimek and Petr Hruška
##### publishing under <ins>GNU GENERAL PUBLIC LICENSE V3.0</ins> (more in LICENSE file)

----

#### showcase:
##### source code:
```
#heading# color white bg black fontSize 30px inSpace 15px inJump 20px outSpace 10px
#subheading# style heading bg 200 100 100 1.0
#mini-heading# color white bg 150 50 50 1.0 fontSize 18px inSpace 10px inJump 20px outSpace 10px
#normal#  color black bg transparent fontSize 15px outSpace 10px
#spacer#  bg black inSpace 2px outJump 10px outSpace 10px

Vim Course $ style heading
@vim logo image@ src https://cdn.pixabay.com/photo/2012/04/11/11/39/text-editor-27620_960_720.png width 200px
by David Šimek $ style mini-heading

"My course will contain some stuff"
"Mainly some vim bindings"
"I just need to make some preview"
"\$So where to begin?"
Moves $ style subheading
"you move your cursor with j,k,l and h"
"that is pretty much it"
Is there more stuff in vim? $ style subheading
"no"
"no more stuff"
```
##### generated HTML:
```
<div style="background-color: rgba(0, 0, 0, 1.0); color: rgba(255, 255, 255, 1.0); margin: 10px 0px; padding: 15px 20px; font: 30px Arial, sans-serif;">Vim Course</div>
<img src="https://cdn.pixabay.com/photo/2012/04/11/11/39/text-editor-27620_960_720.png" style="width: 200px; height:auto; max-width: 100%; max-height: 100%;"><div style="background-color: rgba(150, 50, 50, 1.0); color: rgba(255, 255, 255, 1.0); margin: 10px 0px; padding: 0px 20px; font: 18px Arial, sans-serif;">by David Šimek</div>
<div style="background-color: rgba(0, 0, 0, 0.0); color: rgba(0, 0, 0, 1.0); margin: 0px 0px; padding: 0px 10px; font: 15px Arial, sans-serif;">My course will contain some stuff</div>
<div style="background-color: rgba(0, 0, 0, 0.0); color: rgba(0, 0, 0, 1.0); margin: 0px 0px; padding: 0px 10px; font: 15px Arial, sans-serif;">Mainly some vim bindings</div>
<div style="background-color: rgba(0, 0, 0, 0.0); color: rgba(0, 0, 0, 1.0); margin: 0px 0px; padding: 0px 10px; font: 15px Arial, sans-serif;">I just need to make some preview</div>
<div style="background-color: rgba(0, 0, 0, 0.0); color: rgba(0, 0, 0, 1.0); margin: 0px 0px; padding: 0px 10px; font: 15px Arial, sans-serif;">\$So where to begin?</div>
<div style="background-color: rgba(200, 100, 100, 1.0); color: rgba(255, 255, 255, 1.0); margin: 10px 0px; padding: 15px 20px; font: 30px Arial, sans-serif;">Moves</div>
<div style="background-color: rgba(0, 0, 0, 0.0); color: rgba(0, 0, 0, 1.0); margin: 0px 0px; padding: 0px 10px; font: 15px Arial, sans-serif;">you move your cursor with j,k,l and h</div>
<div style="background-color: rgba(0, 0, 0, 0.0); color: rgba(0, 0, 0, 1.0); margin: 0px 0px; padding: 0px 10px; font: 15px Arial, sans-serif;">that is pretty much it</div>
<div style="background-color: rgba(200, 100, 100, 1.0); color: rgba(255, 255, 255, 1.0); margin: 10px 0px; padding: 15px 20px; font: 30px Arial, sans-serif;">Is there more stuff in vim?</div>
<div style="background-color: rgba(0, 0, 0, 0.0); color: rgba(0, 0, 0, 1.0); margin: 0px 0px; padding: 0px 10px; font: 15px Arial, sans-serif;">no</div>
<div style="background-color: rgba(0, 0, 0, 0.0); color: rgba(0, 0, 0, 1.0); margin: 0px 0px; padding: 0px 10px; font: 15px Arial, sans-serif;">no more stuff</div>

```
##### result:
![obrazek](https://github.com/davidSimek/MarkupInteracticeLanguageFormat/assets/119676792/4ad02113-0e82-446f-a379-dd00c54e7960)

-----

### idea:
- simple markup language usable by non developers
- free transpiler, live preview in browser
- easy to use UI

-----

## what can it do?
### simple text:
```
"hi, this is just basic text"
or
hi, this is just basic text $
```
you can choose from these 2 ways
##### result:
```
<div style="background-color: rgba(0, 0, 0, 0.0); color: rgba(0, 0, 0, 1.0); margin: 0px 0px; padding: 0px 10px; font: 15px Arial, sans-serif;">hi, this is just text</div>

```
![obrazek](https://github.com/davidSimek/MarkupInteracticeLanguageFormat/assets/119676792/a079c4e4-3e70-4e08-899b-d97e3bcd6371)

### some styling:
```
this is white text on black background and some other stuff $ color white bg black inJump 20px outJump 20px inSpace 30px outSpace 30px
``` 
##### result:
```
<div style="background-color: rgba(0, 0, 0, 1.0); color: rgba(255, 255, 255, 1.0); margin: 0px 20px; padding: 30px 20px; font: 15px Arial, sans-serif;">this is white text on black background and some other stuff</div>
```
![obrazek](https://github.com/davidSimek/MarkupInteracticeLanguageFormat/assets/119676792/05d5ddce-873f-485d-a195-0752ef53b03e)

### defining styles:
```
#header# color 100 100 200 1.0 inSpace 15px outSpace 10px inJump 18px
this is header $ style header
this is just normal text $
this is header again $ style header
``` 
##### result:
```
<div style="background-color: rgba(0, 0, 0, 0.0); color: rgba(100, 100, 200, 1.0); margin: 10px 0px; padding: 15px 18px; font: 15px Arial, sans-serif;">this is header</div>
<div style="background-color: rgba(0, 0, 0, 0.0); color: rgba(0, 0, 0, 1.0); margin: 0px 0px; padding: 0px 10px; font: 15px Arial, sans-serif;">this is just normal text</div>
<div style="background-color: rgba(0, 0, 0, 0.0); color: rgba(100, 100, 200, 1.0); margin: 10px 0px; padding: 15px 18px; font: 15px Arial, sans-serif;">this is header again</div>
```
![obrazek](https://github.com/davidSimek/MarkupInteracticeLanguageFormat/assets/119676792/b44aa16b-e1be-418e-bfc0-c43cebde298b)

### use image
```
@image of dog@ src https://cdn.pixabay.com/photo/2019/08/19/07/45/corgi-4415649_1280.jpg width 200px
```
##### result:
```
<img src=https://cdn.pixabay.com/photo/2019/08/19/07/45/corgi-4415649_1280.jpg style = "width: 200px; height:auto; max-width: 100%; max-height: 100%;">```
```
![obrazek](https://github.com/davidSimek/MarkupInteracticeLanguageFormat/assets/119676792/e25f5756-9935-49cc-a72c-9af5b972da4f)

-----

### is it just markdown copy???
It is similar to markdown, but it has some key differences
##### differences from markdown:    
- no xml markings
- interactivity (in future)
- per line evaluation

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
- cpp (http server)
- js
- bash 
