---
description: >
  This chapter shows how to upgrade Hydejack to a newer version. The method depends on how you've installed Hydejack.
hide_description: true
---

# Markdown
Markdown is a [lightweight markup language](https://en.wikipedia.org/wiki/Lightweight_markup_language) with plain text formatting syntax. Its design allows it to be converted to many output formats, but the original tool by the same name only supports HTML.[^1]  [`wiki`](https://en.wikipedia.org/wiki/Markdown)  

{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}
![Screenshot](https://d33wubrfki0l68.cloudfront.net/541d89b49cfeb577c7ba61491899adeac8bdf4d0/2826b/assets/images/dillinger.png)

## Get Started
### [Basic Syntax](https://www.markdownguide.org/basic-syntax/)

#### Headings    
To create a heading, add number signs (`#`) in front of a word or phrase. The number of number signs you use should correspond to the heading level. For example, to create a heading level three (`<h3>`), use three number signs (e.g., `### My Header`).  
Alternatively, on the line below the text, add any number of `==` characters for heading level 1 or `--` characters for heading level 2.  
```markdown
# Heading level 1
## Heading level 2
### Heading level 3
#### Heading level 4
##### Heading level 5
###### Heading level 6
Heading level 1
===============
Heading level 2
---------------
```
<table><tr><td>
<h1>Heading level 1</h1><h2>Heading level 2</h2><h3>Heading level 3</h3><h4>Heading level 4</h4><h5>Heading level 5</h5><h6>Heading level 6</h6><h1>Heading level 1</h1><h2>Heading level 2</h2>
</td></tr></table>
---
#### Paragraphs 
To create paragraphs, use a blank line to separate one or more lines of text. You should not indent paragraphs with spaces or tabs.
```markdown
I really like using Markdown.

I think I'll use it to format all of my documents from now on.
```
<table><tr><td>
I really like using Markdown.<br><br>
I think I'll use it to format all of my documents from now on.
</td></tr></table>
---
#### Line Breaks 
To create a line break (`<br>`), end a line with two or more `spaces`, and then type return.
```markdown
This is the first line.  
And this is the second line.
```
<table><tr><td>
This is the first line.<br>
And this is the second line.
</td></tr></table>
---
#### Emphasis 
**- Bold**  
To bold text, add two asterisks or underscores before and after a word or phrase. To bold the middle of a word for emphasis, add two asterisks without spaces around the letters.
```markdown
I just love **bold text**.
I just love __bold text__.
Love**is**bold
```
<table><tr><td>
I just love <strong>bold text</strong>.<br>
I just love <strong>bold text</strong>.<br>
Love<strong>is</strong>bold
</td></tr></table>
---
**- Italic**  
To italicize text, add one `asterisk` or `underscore` before and after a word or phrase. To italicize the middle of a word for emphasis, add one `asterisk` without spaces around the letters.
```markdown
Italicized text is the *cat's meow*.
Italicized text is the _cat's meow_.
A*cat*meow
```
<table><tr><td>
Italicized text is the <em>cat's meow</em>.<br>
Italicized text is the <em>cat's meow</em>.<br>
A<em>cat</em>meow
</td></tr></table>
---
**- Bold and Italic**  
To emphasize text with bold and italics at the same time, add three `asterisks` or `underscores` before and after a word or phrase.
```markdown
This text is ***really important***.
This text is ___really important___.
This text is __*really important*__.
This text is **_really important_**.
```
<table><tr><td>
This text is <strong><em>really important</em></strong>.<br>
This text is <strong><em>really important</em></strong>.<br>
This text is <strong><em>really important</em></strong>.<br>
This text is <strong><em>really important</em></strong>.
</td></tr></table>
---
#### Blockquotes  
To create a blockquote, add a `>` in front of a paragraph.
```markdown
> Dorothy followed her through many of the beautiful rooms in her castle.
>
>> The Witch bade her clean the pots and kettles and sweep the floor and keep the fire fed with wood.
```
> Dorothy followed her through many of the beautiful rooms in her castle.
>
>> The Witch bade her clean the pots and kettles and sweep the floor and keep the fire fed with wood.  

---  
#### Lists   
**- Ordered List**  
To create an ordered list, add line items with `numbers followed by periods`. The numbers don’t have to be in numerical order, but the list should start with the number one.  
```markdown
1. First item
8. Second item
3. Third item
```
1. First item
8. Second item
3. Third item

**- Unordered List**  
To create an unordered list, add `dashes (-)`, `asterisks (*)`, or `plus signs (+)` in front of line items. Indent one or more items to create a nested list.  
```markdown
+ First item
* Second item
- Third item

- First item
- Second item
- Third item
    - Indented item
    - Indented item
```
+ First item
* Second item
- Third item

- First item
- Second item
- Third item
    - Indented item
    - Indented item  

**Adding Elements in Lists**  
  **- Paragraphs**  
```markdown
*   This is the first list item.
*   Here's the second list item.
    I need to add another paragraph below the second list item.
*   And here's the third list item.
```
*   This is the first list item.
*   Here's the second list item.
    I need to add another paragraph below the second list item.
*   And here's the third list item.  

  **- Blockquotes**
```markdown
*   This is the first list item.
*   Here's the second list item.
    > A blockquote would look great below the second list item.
*   And here's the third list item.
```
*   This is the first list item.
*   Here's the second list item.
    > A blockquote would look great below the second list item.
*   And here's the third list item.

  **- Code Blocks**
```markdown
1.  Open the file.
2.  Find the following code block on line 21:
        <html>
          <head>
            <title>Test</title>
          </head>
3.  Update the title to match the name of your website.
```
1.  Open the file.
2.  Find the following code block on line 21:
        <html>
          <head>
            <title>Test</title>
          </head>
3.  Update the title to match the name of your website.

  **- Images**
```markdown
1.  Open the file containing the Linux mascot.
2.  Marvel at its beauty.
    ![Tux, the Linux mascot](/assets/img/docs/tux.png)
3.  Close the file.
```
1.  Open the file containing the Linux mascot.
2.  Marvel at its beauty.  
    ![Tux, the Linux mascot](/assets/img/docs/tux.png)
3.  Close the file.

---  
#### Code  
To denote a word or phrase as code, enclose it in tick marks (`).  
```markdown
At the command prompt, type `nano`.
```
At the command prompt, type `nano`.

  **- Escaping Tick Marks**  
If the word or phrase you want to denote as code includes one or more tick marks, you can escape it by enclosing the word or phrase in double tick marks (``).  
```markdown
``Use `code` in your Markdown file.``
```
``Use `code` in your Markdown file.``

  **- Code Blocks**  
To create code blocks, indent every line of the block by at least four spaces or one tab.   
```html
    <html>
      <head>
      </head>
    </html>
```
    <html>
      <head>
      </head>
    </html>

---  
#### Horizontal Rules 
To create a horizontal rule, use three or more `asterisks (***)`, `dashes (---)`, or `underscores (___)` on a line by themselves.    
```markdown
***
---
_________________
```

---  
#### Links  
To create a link, enclose the link text in brackets (e.g., `[Duck Duck Go]`) and then follow it immediately with the URL in parentheses (e.g., `(https://duckduckgo.com)`).  
You can optionally add a title for a link. This will appear as a tooltip when the user hovers over the link. To add a title, enclose it in `parentheses` after the URL.  
```markdown
My favorite search engine is [Duck Duck Go](https://duckduckgo.com).
My favorite search engine is [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy").
```
My favorite search engine is [Duck Duck Go](https://duckduckgo.com).  
My favorite search engine is [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy").

---  
#### URLs and Email Addresses  
To quickly turn a URL or email address into a link, enclose it in `angle brackets`.  
```markdown
<https://www.markdownguide.org>  
<fake@example.com>
```
<https://www.markdownguide.org>  
<fake@example.com>

[^1]: "Markdown". 2013-12-04. Archived from the original on 2004-04-02.