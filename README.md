 ██▒   █▓██▓███▄ ▄███▓    ███▄ ▄███▓█    ██ ██▓ ▄▄▄█████▓██▓    █     █░██▀███  ▄▄▄      ██▓███
▓██░   █▓██▓██▒▀█▀ ██▒   ▓██▒▀█▀ ██▒██  ▓██▓██▒ ▓  ██▒ ▓▓██▒   ▓█░ █ ░█▓██ ▒ ██▒████▄   ▓██░  ██▒
 ▓██  █▒▒██▓██    ▓██░   ▓██    ▓██▓██  ▒██▒██░ ▒ ▓██░ ▒▒██▒   ▒█░ █ ░█▓██ ░▄█ ▒██  ▀█▄ ▓██░ ██▓▒
  ▒██ █░░██▒██    ▒██    ▒██    ▒██▓▓█  ░██▒██░ ░ ▓██▓ ░░██░   ░█░ █ ░█▒██▀▀█▄ ░██▄▄▄▄██▒██▄█▓▒ ▒
   ▒▀█░ ░██▒██▒   ░██▒   ▒██▒   ░██▒▒█████▓░██████▒██▒ ░░██░   ░░██▒██▓░██▓ ▒██▒▓█   ▓██▒██▒ ░  ░
   ░ ▐░ ░▓ ░ ▒░   ░  ░   ░ ▒░   ░  ░▒▓▒ ▒ ▒░ ▒░▓  ▒ ░░  ░▓     ░ ▓░▒ ▒ ░ ▒▓ ░▒▓░▒▒   ▓▒█▒▓▒░ ░  ░
   ░ ░░  ▒ ░  ░      ░   ░  ░      ░░▒░ ░ ░░ ░ ▒  ░ ░    ▒ ░     ▒ ░ ░   ░▒ ░ ▒░ ▒   ▒▒ ░▒ ░
     ░░  ▒ ░      ░      ░      ░   ░░░ ░ ░  ░ ░  ░      ▒ ░     ░   ░   ░░   ░  ░   ▒  ░░
      ░  ░        ░             ░     ░        ░  ░      ░         ░      ░          ░  ░
     ░
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
