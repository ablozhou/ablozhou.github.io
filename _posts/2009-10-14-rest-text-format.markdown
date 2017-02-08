---
author: abloz
comments: true
date: 2009-10-14 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/10/14/rest-text-format/
slug: rest-text-format
title: reST 文本格式
wordpress_id: 931
categories:
- 技术
---

========

reST文本格式

========

很好玩的格式化文本

---------

 

写纯文本时很好写，同时也可以用工具格式化。看纯文本也不会太乱。

 

很好的一个格式，希望成为标准。

 

:作者: [周海汉](http://blog.csdn.net/ablo_zhou)

:日期: 2009.10.15

 

参考 [http://docutils.sourceforge.net/rst.html](http://docutils.sourceforge.net/rst.html)

 

示例如下：

## [Inline Markup](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#inline-markup)) 

Inline markup allows words and phrases within text to have character  styles (like italics and boldface) and functionality (like hyperlinks). 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result Notes  </tr> <tbody > <tr valign="top" >
<td >*emphasis*
</td>
<td >_emphasis_
</td>
<td >Normally rendered as italics. 
</td> </tr> <tr valign="top" >
<td >**strong emphasis**
</td>
<td >**strong emphasis**
</td>
<td >Normally rendered as boldface. 
</td> </tr> <tr valign="top" >
<td >`interpreted text`
</td>
<td >(see note at right) 
</td>
<td >The rendering and _meaning_ of interpreted text is domain- or application-dependent. It can be used for things like index entries or  explicit descriptive markup (like program identifiers). 
</td> </tr> <tr valign="top" >
<td >``inline literal``
</td>
<td >`inline literal`
</td>
<td >Normally rendered as monospaced text. Spaces should be preserved, but line breaks will not be. 
</td> </tr> <tr valign="top" >
<td >reference_
</td>
<td >[reference](http://writeblog.csdn.net/#hyperlink-targets)
</td>
<td >A simple, one-word hyperlink reference. See [Hyperlink Targets](http://writeblog.csdn.net/#hyperlink-targets). 
</td> </tr> <tr valign="top" >
<td >`phrase reference`_
</td>
<td >[phrase reference](http://writeblog.csdn.net/#hyperlink-targets)
</td>
<td >A hyperlink reference with spaces or punctuation needs to be quoted with backquotes. See [Hyperlink Targets](http://writeblog.csdn.net/#hyperlink-targets). 
</td> </tr> <tr valign="top" >
<td >anonymous__
</td>
<td >[anonymous](http://writeblog.csdn.net/#hyperlink-targets)
</td>
<td >With two underscores instead of one, both simple and phrase  references may be anonymous (the reference text is not repeated at the  target). See [Hyperlink Targets](http://writeblog.csdn.net/#hyperlink-targets). 
</td> </tr> <tr valign="top" >
<td >_`inline internal target`
</td>
<td >inline internal target
</td>
<td >A crossreference target within text. See [Hyperlink Targets](http://writeblog.csdn.net/#hyperlink-targets). 
</td> </tr> <tr valign="top" >
<td >|substitution reference|
</td>
<td >(see note at right) 
</td>
<td >The result is substituted in from the [substitution definition](http://writeblog.csdn.net/#substitution-references-and-definitions). It could be text, an image, a hyperlink, or a combination of these and others. 
</td> </tr> <tr valign="top" >
<td >footnote reference [1]_
</td>
<td >footnote reference [1](http://writeblog.csdn.net/#footnotes)
</td>
<td >See [Footnotes](http://writeblog.csdn.net/#footnotes). 
</td> </tr> <tr valign="top" >
<td >citation reference [CIT2002]_
</td>
<td >citation reference [[CIT2002]](http://writeblog.csdn.net/#citations)
</td>
<td >See [Citations](http://writeblog.csdn.net/#citations). 
</td> </tr> <tr valign="top" >
<td >http://docutils.sf.net/
</td>
<td >[http://docutils.sf.net/](http://docutils.sf.net/)
</td>
<td >A standalone hyperlink. 
</td> </tr> </tbody> </table>  

Asterisk, backquote, vertical bar, and underscore are inline  delimiter characters. Asterisk, backquote, and vertical bar act like  quote marks; matching characters surround the marked-up word or phrase,  whitespace or other quoting is required outside them, and there can't be whitespace just inside them. If you want to use inline delimiter  characters literally, [escape (with backslash)](http://writeblog.csdn.net/#escaping) or quote them (with double backquotes; i.e. use inline literals). 

In detail, the reStructuredText specification says that in inline  markup, the following rules apply to start-strings and end-strings  (inline markup delimiters): 

  1. The start-string must start a text block or be immediately preceded by whitespace or any of ' " ( [ { or <. 
  2. The start-string must be immediately followed by non-whitespace. 
  3. The end-string must be immediately preceded by non-whitespace. 
  4. The end-string must end a text block (end of document or followed by a blank line) or be immediately followed by whitespace or any of ' " . , : ; ! ? - ) ] } /  or >. 
  5. If a start-string is immediately preceded by one of ' " ( [ { or <, it must not be immediately followed by the corresponding character from ' " ) ] } or >. 
  6. An end-string must be separated by at least one character from the start-string. 
  7. An [unescaped](http://writeblog.csdn.net/#escaping)  backslash preceding a start-string or end-string will disable markup  recognition, except for the end-string of inline literals. 

Also remember that inline markup may not be nested (well, except that inline literals can contain any of the other inline markup delimiter  characters, but that doesn't count because nothing is processed). 

## [Escaping with Backslashes](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#escaping-mechanism)) 

reStructuredText uses backslashes ("") to override the special  meaning given to markup characters and get the literal characters  themselves. To get a literal backslash, use an escaped backslash ("\"). For example: 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Raw reStructuredText Typical result  </tr> <tbody > <tr valign="top" >
<td >*escape* ``with`` ""
</td>
<td >_escape_ with "" 
</td> </tr> <tr valign="top" >
<td >*escape* ``with`` "\"
</td>
<td >*escape* ``with`` "" 
</td> </tr> </tbody> </table>  

In Python strings it will, of course, be necessary to escape any backslash characters so that they actually _reach_ reStructuredText. The simplest way to do this is to use raw strings: 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Python string Typical result  </tr> <tbody > <tr valign="top" >
<td >r"""*escape* `with` "\""""
</td>
<td >*escape* `with` "" 
</td> </tr> <tr valign="top" >
<td > """\*escape* \`with` "\\""""
</td>
<td >*escape* `with` "" 
</td> </tr> <tr valign="top" >
<td > """*escape* `with` "\""""
</td>
<td >_escape_ with "" 
</td> </tr> </tbody> </table>  

## [Section Structure](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#sec
tions)) 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >=====   
Title   
=====   
Subtitle   
--------   
Titles are underlined (or over-   
and underlined) with a printing   
nonalphanumeric 7-bit ASCII   
character. Recommended choices   
are "``= - ` : ' " ~ ^ _ * + # < >``".   
The underline/overline must be at   
least as long as the title text.   
  
A lone top-level (sub)section   
is lifted up to be the document's   
(sub)title.
</td>
<td >**Title**

**Subtitle**

Titles are underlined (or over- and underlined) with a printing nonalphanumeric 7-bit ASCII character. Recommended choices are "= - ` : ' " ~ ^ _ * + # < >". The underline/overline must be at least as long as the title text. 

A lone top-level (sub)section is lifted up to be the document's (sub)title. 

</td> </tr> </tbody> </table>  

## [Paragraphs](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#paragraphs)) 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >

This is a paragraph.

Paragraphs line up at their left   
edges, and are normally separated   
by blank lines.

</td>
<td >

This is a paragraph. 

Paragraphs line up at their left edges, and are normally separated by blank lines. 

</td> </tr> </tbody> </table>  

## [Bullet Lists](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#bullet-lists)) 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >Bullet lists:

- This is item 1   
- This is item 2

- Bullets are "-", "*" or "+".   
Continuing text must be aligned   
after the bullet and whitespace.

Note that a blank line is required   
before the first item and after the   
last, but is optional between items.

</td>
<td >Bullet lists:  

  * This is item 1 
  * This is item 2 
  * Bullets are "-", "*" or "+". Continuing text must be aligned after the bullet and whitespace. 

Note that a blank line is required before the first item and after the last, but is optional between items. 

</td> </tr> </tbody> </table>  

## [Enumerated Lists](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#enumerated-lists)) 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >Enumerated lists:

3. This is the first item   
4. This is the second item   
5. Enumerators are arabic numbers,   
single letters, or roman numerals   
6. List items should be sequentially   
numbered, but need not start at 1   
(although not all formatters will   
honour the first index).   
#. This item is auto-enumerated

</td>
<td >Enumerated lists: 

  1. This is the first item 
  2. This is the second item 
  3. Enumerators are arabic numbers, single letters, or roman numerals 
  4. List items should be sequentially numbered, but need not start at 1 (although not all formatters will honour the first index). 
  5. This item is auto-enumerated 
</td> </tr> </tbody> </table>  

## [Definition Lists](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#definition-lists)) 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >Definition lists:   
  
what   
Definition lists associate a term with   
a definition.   
  
how   
The term is a one-line phrase, and the   
definition is one or more paragraphs or   
body elements, indented relative to the   
term. Blank lines are not allowed   
between term and definition.
</td>
<td >Definition lists: 

**what**
    Definition lists associate a term with a definition. 
**how**
    The term is a one-line phrase, and the definition is one or more paragraphs or body elements, indented relative to the term. Blank lines are not  allowed between term and definition. 
</td> </tr> </tbody> </table>  

## [Field Lists](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#field-lists)) 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >:Authors:   
Tony J. (Tibs) Ibbs,   
David Goodger

(and sundry other good-natured folks)

:Version: 1.0 of 2001/08/08   
:Dedication: To my father.

</td>
<td > <table border="0" > <tbody > <tr valign="top" >
<td >**Authors:
</td>
<td >Tony J. (Tibs) Ibbs, David Goodger 
</td> </tr> <tr >
<td >
</td>
<td >(and sundry other good-natured folks) 
</td> </tr> <tr >
<td >**Version:**
</td>
<td >1.0 of 2001/08/08 
</td> </tr> <tr >
<td >**Dedication:**
</td>
<td >To my father. 
</td> </tr> </tbody> </table>
</td> </tr> </tbody> </table>  

Field lists are used as part of an extension syntax, such as options for [directives](http://writeblog.csdn.net/#directives), or database-like records meant for further processing. Field lists may  also be used as generic two-column table constructs in documents. 

## [Option Lists](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#option-lists)) 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >

-a command-line option "a"   
-b file options can have arguments   
and long descriptions   
--long options can be long also   
--input=file long options can also have   
arguments   
/V DOS/VMS-style options too 

</td>
<td > <table width="100%" border="0" > <tbody > <tr >
<td width="30%" >-a
</td>
<td >command-line option "a" 
</td> </tr> <tr >
<td >-b _file_
</td>
<td >options can have arguments and long descriptions 
</td> </tr> <tr >
<td >--long
</td>
<td >options can be long also 
</td> </tr> <tr >
<td >--input=_file_
</td>
<td >long options can also have arguments 
</td> </tr> <tr >
<td >/V
</td>
<td >DOS/VMS-style options too 
</td> </tr> </tbody> </table>
</td> </tr> </tbody> </table>  

There must be at least two spaces between the option and the description. 

## [Literal Blocks](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#literal-blocks)) 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >A paragraph containing only two colons   
indicates that the following indented   
or quoted text is a literal block.   
  
::   
  
Whitespace, newlines, blank lines, and   
all kinds of markup (like *this* or   
this) is preserved by literal blocks.   
  
The paragraph containing only '::'   
will be omitted from the result.   
  
The ``::`` may be tacked onto the very   
end of any paragraph. The ``::`` will be   
omitted if it is preceded by whitespace.   
The ``::`` will be converted to a single   
colon if preceded by text, like this::   
  
It's very convenient to use this form.   
  
Literal blocks end when text returns to   
the preceding paragraph's indentation.   
This means that something like this   
is possible::   
  
We start here   
and continue here   
and end here.   
  
Per-line quoting can also be used on   
unindented literal blocks::   
  
> Useful for quotes from email and   
> for Haskell literate programming.
</td>
<td >

A paragraph containing only two colons indicates that the following indented or quoted text is a literal block. 
    
      Whitespace, newlines, blank lines, and  all kinds of markup (like *this* or  this) is preserved by literal blocks.   The paragraph containing only '::'  will be omitted from the result.

The :: may be tacked onto the very end of any paragraph. The :: will be omitted if it is preceded by whitespace. The :: will be converted to a single colon if preceded by text, like this: 
    
      It's very convenient to use this form.

Literal blocks end when text returns to the preceding paragraph's indentation. This means that something like this is possible: 
    
          We start here    and continue here  and end here.

Per-line quoting can also be used on unindented literal blocks: 
    
      > Useful for quotes from email and  > for Haskell literate programming.

</td> </tr> </tbody> </table>  

## [Line Blocks](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#line-blocks)) 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >| Line blocks are useful for addresses,   
| verse, and adornment-free lists.   
|   
| Each new line begins with a   
| vertical bar ("|").   
| Line breaks and initial indents   
| are preserved.   
| Continuation lines are wrapped   
portions of long lines; they begin   
with spaces in place of vertical bars.
</td>
<td >

Line blocks are useful for addresses,

verse, and adornment-free lists.

  


Each new line begins with a

vertical bar ("|").

Line breaks and initial indents

are preserved.

Continuation lines are wrapped portions of long lines; they begin with spaces in place of vertical bars.

</td> </tr> </tbody> </table>  

## [Block Quotes](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#block-quotes)) 

<table cellpadding="3" bgcolor="#fff
fcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >Block quotes are just:

Indented paragraphs,

and they may nest.

</td>
<td >Block quotes are just: 
```
 

Indented paragraphs, 


```
 

and they may nest. 


```
 
```
 
</td> </tr> </tbody> </table>  

Use [empty comments](http://writeblog.csdn.net/#comments) to separate indentation contexts, such as block quotes and directive contents.

## [Doctest Blocks](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#doctest-blocks)) 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >

Doctest blocks are interactive   
Python sessions. They begin with   
"``>>>``" and end with a blank line.

>>> print "This is a doctest block."   
This is a doctest block.

</td>
<td >

Doctest blocks are interactive Python sessions. They begin with ">>>" and end with a blank line. 

>>> print "This is a doctest block."   
This is a doctest block.

</td> </tr> </tbody> </table>  

"The [doctest](http://www.python.org/doc/current/lib/module-doctest.html) module searches a module's docstrings for text that looks like an  interactive Python session, then executes all such sessions to verify  they still work exactly as shown." (From the doctest docs.) 

## [Tables](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#tables)) 

There are two syntaxes for tables in reStructuredText. Grid tables  are complete but cumbersome to create. Simple tables are easy to create  but limited (no row spans, etc.).

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >

Grid table:

+------------+------------+-----------+   
| Header 1 | Header 2 | Header 3 |   
+============+============+===========+   
| body row 1 | column 2 | column 3 |   
+------------+------------+-----------+   
| body row 2 | Cells may span columns.|   
+------------+------------+-----------+   
| body row 3 | Cells may | - Cells |   
+------------+ span rows. | - contain |   
| body row 4 | | - blocks. |   
+------------+------------+-----------+

</td>
<td >

Grid table:

<table border="1" > <tr > Header 1 Header 2 Header 3  </tr> <tbody > <tr >
<td >body row 1 
</td>
<td >column 2 
</td>
<td >column 3 
</td> </tr> <tr >
<td >body row 2 
</td>
<td colspan="2" >Cells may span columns. 
</td> </tr> <tr >
<td >body row 3 
</td>
<td rowspan="2" >Cells may  
span rows. 
</td>
<td rowspan="2" >

  * Cells 
  * contain 
  * blocks. 
</td> </tr> <tr >
<td >body row 4 
</td> </tr> </tbody> </table>
</td> </tr> <tr valign="top" >
<td >

Simple table:

===== ===== ======   
Inputs Output   
------------ ------   
A B A or B   
===== ===== ======   
False False False   
True False True   
False True True   
True True True   
===== ===== ======

</td>
<td >

Simple table:

<table border="1" > <tr > Inputs Output  </tr> <tr > A B A or B  </tr> <tbody > <tr >
<td >False 
</td>
<td >False 
</td>
<td >False 
</td> </tr> <tr >
<td >True 
</td>
<td >False 
</td>
<td >True 
</td> </tr> <tr >
<td >False 
</td>
<td >True 
</td>
<td >True 
</td> </tr> <tr >
<td >True 
</td>
<td >True 
</td>
<td >True 
</td> </tr> </tbody> </table>
</td> </tr> </tbody> </table>  

## [Transitions](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#transitions)) 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >

A transition marker is a horizontal line   
of 4 or more repeated punctuation   
characters.

------------

A transition should not begin or end a   
section or document, nor should two   
transitions be immediately adjacent.

</td>
<td >

A transition marker is a horizontal line of 4 or more repeated punctuation characters.

* * *

A transition should not begin or end a section or document, nor should two transitions be immediately adjacent. 

</td> </tr> </tbody> </table>  

Transitions are commonly seen in novels and short fiction, as a gap  spanning one or more lines, marking text divisions or signaling changes  in subject, time, point of view, or emphasis. 

## [Explicit Markup](http://writeblog.csdn.net/#contents)

Explicit markup blocks are used for constructs which float  (footnotes), have no direct paper-document representation (hyperlink  targets, comments), or require specialized processing (directives). They all begin with two periods and whitespace, the "explicit markup start". 

### [Footnotes](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#footnotes)) 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >Footnote references, like [5]_.   
Note that footnotes may get   
rearranged, e.g., to the bottom&
nbsp;of   
the "page".

.. [5] A numerical footnote. Note   
there's no colon after the ``]``.

</td>
<td >Footnote references, like [5](http://writeblog.csdn.net/#5). Note that footnotes may get rearranged, e.g., to the bottom of the "page". 

<table border="0" > <tbody > <tr >
<td colspan="2" >

* * *

</td> </tr> <tr >
<td >**[5]**
</td>
<td >A numerical footnote. Note there's no colon after the ]. 
</td> </tr> </tbody> </table>  
</td> </tr> <tr valign="top" >
<td >Autonumbered footnotes are   
possible, like using [#]_ and [#]_.

.. [#] This is the first one.   
.. [#] This is the second one.

They may be assigned 'autonumber   
labels' - for instance,   
[#fourth]_ and [#third]_.

.. [#third] a.k.a. third_

.. [#fourth] a.k.a. fourth_

</td>
<td >Autonumbered footnotes are possible, like using [1](http://writeblog.csdn.net/#auto1) and [2](http://writeblog.csdn.net/#auto2). 

They may be assigned 'autonumber labels' - for instance, [4](http://writeblog.csdn.net/#fourth) and [3](http://writeblog.csdn.net/#third). 

<table border="0" > <tbody > <tr >
<td colspan="2" >

* * *

</td> </tr> <tr >
<td >**[1]**
</td>
<td >This is the first one. 
</td> </tr> <tr >
<td >**[2]**
</td>
<td >This is the second one. 
</td> </tr> <tr >
<td >**[3]**
</td>
<td >a.k.a. [third](http://writeblog.csdn.net/#third)
</td> </tr> <tr >
<td >**[4]**
</td>
<td >a.k.a. [fourth](http://writeblog.csdn.net/#fourth)
</td> </tr> </tbody> </table>  
</td> </tr> <tr valign="top" >
<td >Auto-symbol footnotes are also   
possible, like this: [*]_ and [*]_.

.. [*] This is the first one.   
.. [*] This is the second one.

</td>
<td >Auto-symbol footnotes are also possible, like this: [*](http://writeblog.csdn.net/#symbol1) and [†](http://writeblog.csdn.net/#symbol2). 

<table border="0" > <tbody > <tr >
<td colspan="2" >

* * *

</td> </tr> <tr >
<td >**[*]**
</td>
<td >This is the first symbol footnote 
</td> </tr> <tr >
<td >**[†]**
</td>
<td >This is the second one. 
</td> </tr> </tbody> </table>  
</td> </tr> </tbody> </table>  

The numbering of auto-numbered footnotes is determined by the order  of the footnotes, not of the references. For auto-numbered footnote  references without autonumber labels ("[#]_"), the references and footnotes must be in the same relative order. Similarly for auto-symbol footnotes ("[*]_"). 

### [Citations](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#citations)) 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >Citation references, like [CIT2002]_.   
Note that citations may get   
rearranged, e.g., to the bottom of   
the "page".

.. [CIT2002] A citation   
(as often used in journals).

Citation labels contain alphanumerics,   
underlines, hyphens and fullstops.   
Case is not significant.

Given a citation like [this]_, one   
can also refer to it like this_.

.. [this] here.

</td>
<td >Citation references, like [[CIT2002]](http://writeblog.csdn.net/#cit2002). Note that citations may get rearranged, e.g., to the bottom of the "page". 

Citation labels contain alphanumerics, underlines, hyphens and fullstops. Case is not significant. 

Given a citation like [[this]](http://writeblog.csdn.net/#this), one can also refer to it like [this](http://writeblog.csdn.net/#this). 

<table border="0" > <tbody > <tr >
<td colspan="2" >

* * *

</td> </tr> <tr >
<td >**[CIT2002]**
</td>
<td >A citation (as often used in journals). 
</td> </tr> <tr >
<td >**[this]**
</td>
<td >here. 
</td> </tr> </tbody> </table>  
</td> </tr> </tbody> </table>  

### [Hyperlink Targets](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#hyperlink-targets)) 

#### [External Hyperlink Targets](http://writeblog.csdn.net/#contents)

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td rowspan="2" >External hyperlinks, like Python_.

.. _Python: http://www.python.org/

</td>
<td > <table width="100%" border="0" > <tbody > <tr bgcolor="#99ccff" >
<td >_Fold-in form_
</td> </tr> <tr >
<td >External hyperlinks, like [Python](http://www.python.org/). 
</td> </tr> </tbody> </table>
</td> </tr> <tr valign="top" >
<td > <table width="100%" border="0" > <tbody > <tr bgcolor="#99ccff" >
<td >_Call-out form_
</td> </tr> <tr >
<td >External hyperlinks, like [_Python_](http://writeblog.csdn.net/#labPython). 

<table border="0" > <tbody > <tr >
<td colspan="2" >

* * *

</td> </tr> <tr >
<td >_Python:_
</td>
<td >[http://www.python.org/](http://www.python.org/)
</td> </tr> </tbody> </table>  
</td> </tr> </tbody> </table>
</td> </tr> </tbody> </table>  

"_Fold-in_" is the representation typically used in HTML  documents (think of the indirect hyperlink being "folded in" like  ingredients into a cake), and "_call-out_" is more suitable for  printed documents, where the link needs to be presented explicitly, for  example as a footnote. You can force usage of the call-out form by using the "[target-notes](http://writeblog.csdn.net/ref/rst/directives.html#target-notes)" directive. 

reStructuredText also provides for **embedded URIs** ([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#embedded-uris)), a convenience at the expense of readability. A hyperlink reference may  directly embed a target URI inline, within angle brackets. The following is exactly equivalent to the example above: 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td rowspan="2" >External hyperlinks, like `Python   
<http://www.python.org/>`_.
</td>
<td >External hyperlinks, li
ke [Python](http://www.python.org/). 
</td> </tr> </tbody> </table>  

#### [Internal Hyperlink Targets](http://writeblog.csdn.net/#contents)

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td rowspan="2" >Internal crossreferences, like example_.

.. _example:

This is an example crossreference target.

</td>
<td > <table width="100%" border="0" > <tbody > <tr bgcolor="#99ccff" >
<td >_Fold-in form_
</td> </tr> <tr >
<td >Internal crossreferences, like [example](http://writeblog.csdn.net/#example-foldin)

This is an example crossreference target. 

</td> </tr> </tbody> </table>
</td> </tr> <tr valign="top" >
<td > <table width="100%" border="0" > <tbody > <tr >
<td bgcolor="#99ccff" >_Call-out form_
</td> </tr> <tr >
<td >Internal crossreferences, like [example](http://writeblog.csdn.net/#example-callout)

_example:_   
This is an example crossreference target. 

</td> </tr> </tbody> </table>
</td> </tr> </tbody> </table>  

#### [Indirect Hyperlink Targets](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#indirect-hyperlink-targets)) 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >Python_ is `my favourite   
programming language`__.

.. _Python: http://www.python.org/

__ Python_

</td>
<td >

[Python](http://www.python.org/) is [my favourite programming language](http://www.python.org/). 

</td> </tr> </tbody> </table>  

The second hyperlink target (the line beginning with "__") is both an indirect hyperlink target (_indirectly_ pointing at the Python website via the "Python_" reference) and an **anonymous hyperlink target**. In the text, a double-underscore suffix is used to indicate an **anonymous hyperlink reference**. In an anonymous hyperlink target, the reference text is not repeated.  This is useful for references with long text or throw-away references,  but the target should be kept close to the reference to prevent them  going out of sync. 

#### [Implicit Hyperlink Targets](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#implicit-hyperlink-targets)) 

Section titles, footnotes, and citations automatically generate  hyperlink targets (the title text or footnote/citation label is used as  the hyperlink name). 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >Titles are targets, too   
=======================   
Implict references, like `Titles are   
targets, too`_.
</td>
<td >**Titles are targets, too**

Implict references, like [Titles are targets, too](http://writeblog.csdn.net/#title). 

</td> </tr> </tbody> </table>  

### [Directives](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#directives)) 

Directives are a general-purpose extension mechanism, a way of adding support for new constructs without adding new syntax. For a description of all standard directives, see [reStructuredText Directives](http://writeblog.csdn.net/ref/rst/directives.html). 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >For instance:

.. image:: images/ball1.gif

</td>
<td >For instance: 

![ball1](http://writeblog.csdn.net/images/ball1.gif)

</td> </tr> </tbody> </table>  

### [Substitution References and Definitions](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#substitution-definitions)) 

Substitutions are like inline directives, allowing graphics and arbitrary constructs within text. 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >The |biohazard| symbol must be used on containers used to dispose of medical waste.

.. |biohazard| image:: biohazard.png

</td>
<td >

The ![biohazard](http://writeblog.csdn.net/images/biohazard.png) symbol must be used on containers used to dispose of medical waste. 

</td> </tr> </tbody> </table>  

### [Comments](http://writeblog.csdn.net/#contents)

([details](http://writeblog.csdn.net/ref/rst/restructuredtext.html#comments)) 

Any text which begins with an explicit markup start but doesn't use the syntax of any of the constructs above, is a comment. 

<table cellpadding="3" bgcolor="#ffffcc" border="1" width="100%" > <tr bgcolor="#99ccff" align="left" > Plain text Typical result  </tr> <tbody > <tr valign="top" >
<td >.. This text will not be shown   
(but, for instance, in HTML might be   
rendered as an HTML comment)
</td>
<td >
</td> </tr> <tr valign="top" >
<td >An "empty comment" does not   
consume following blocks.   
(An empty comment is ".." with   
blank lines before and after.)

..

So this block is not "lost",   
despite its indentation.

</td>
<td >An "empty comment" does not consume following blocks. (An empty comment is ".." with blank lines before and after.) 
```
So this block is not "lost", despite its indentation. 
```
 
</td> </tr> </tbody> </table>  

## [Getting Help](http://writeblog.csdn.net/#contents)

Users who have questions or need assistance with Docutils or reStructuredText should [post a message](mailto:docutils-users@lists.sourceforge.net) to the [Docutils-Users mailing list](http://lists.sourceforge.net/lists/listinfo/docutils-user
s). The [Docutils project web site](http://docutils.sourceforge.net/) has more information. 

 

* * *

  

参考：

[http://docutils.sourceforge.net/docs/user/rst/quickref.html](http://docutils.sourceforge.net/docs/user/rst/quickref.html)

  
  


![](http://img.zemanta.com/pixy.gif?x-id=46f2ce86-ddbe-8ba2-a252-ea07d204f1a1)
