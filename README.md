# vim-multi-wrap
A plugin for quickly wrapping multiple lines in HTML tags

| Command Line Input            | Result

| p                             | <p>text</p>
| p#main.red strong.green a     | <p id="main" class="red"><strong class="green">
|                               | <a href="">text</a></strong></p>
|                               |
| > a                           | each line
|                               | <a href="">text</a>
|                               |
| > a_blank.red                 | each line
|                               | <a href="" target="_blank" rel="nofollow">text</a>
