.___     .___ ._____.___      ._____.___ .____     .___    _____._.___               ___ .______  .______  ._______
|   |___ : __|:         |     :         ||    |___ |   |   \__ _:|: __|     .___    |   |: __   \ :      \ : ____  |
|   |   || : ||   \  /  |     |   \  /  ||    |   ||   |     |  :|| : |     :   | /\|   ||  \____||   .   ||    :  |
|   :   ||   ||   |\/   |     |   |\/   ||    :   ||   |/\   |   ||   |     |   |/  :   ||   :  \ |   :   ||   |___|
 \      ||   ||___| |   |     |___| |   ||        ||   /  \  |   ||   |     |   /       ||   |___\|___|   ||___|
  \____/ |___|      |___|           |___||. _____/ |______/  |___||___|     |______/|___||___|        |___|
                                          :/                                        :
                                          :                                         :


# vim-multi-wrap
A plugin for quickly wrapping multiple lines in HTML tags

**Hotkey leder-w**

**Text for layout**

```HTML
 text
```

**Command Line Input**

`p`

**Result**

```HTML
<p>text</p>
```

-----------------------

**Text for layout**

```HTML
 text
```

**Command Line Input**

`p.red`

**Result**

```HTML
`<p class="red">text</p>
```

-----------------------
**Text for layout**

```HTML
 text

 text2

 text3
```

**Command Line Input**

`> p.red`

**Result**

```HTML
<p class="red">text</p>

<p class="red">text2</p>

<p class="red">text3</p>
```
