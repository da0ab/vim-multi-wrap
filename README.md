# vim-multi-wrap
A plugin for quickly wrapping multiple lines in HTML tags

**Hotkey leder-w**

``
 text
``
**Command Line Input**

`` p``

**Result**

``<p>text</p>``

-----------------------

**Hotkey leder-w**

``
 text
``
**Command Line Input**

`` p.red``

**Result**

``<p class="red">text</p>``

-----------------------
**Hotkey leder-w**

``
 text

 text2

 text3
``

**Command Line Input**

`` > p.red``

**Result**

``
<p class="red">text</p>

<p class="red">text2</p>

<p class="red">text3</p>
``
