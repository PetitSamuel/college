# Mini-Markdown to HTML Parser
Mini-Markdown is a subset of Markdown language. It translates the Mini-Markdown files into HTML files.

## Supported elements:
1. Formated text: **bold** and _italic_
2. image, for example: ![image name](https://images.pexels.com/photos/1858161/pexels-photo-1858161.jpeg=10@15)
3. headers in 1-6 levels

## How to parse Mini-Markdown file
In general, Mini-Markdown parser works in line-mode, which means it parses the input file line by line.
Each line of the input file will be translated into a paragraph in html.

There always an empty line in the end of each Mini-Markdown file. 

## Plain text
plain text contains a-z A-Z 0-9 , . - : '

## Rich-format text
### Formated text
- bold: use 'two-star' text 'two-star' to bold text
- italic: use 'underscore' text 'underscore' to italic text

Note:    bold and italic can be applied to the Headers. bold and italic can be hybird.



### Image
image test ![image name](https://images.pexels.com/photos/1858161/pexels-photo-1858161.jpeg=10@10):

small:
![img1](https://images.pexels.com/photos/1974627/pexels-photo-1974627.jpeg=20@30) ![img2](https://images.pexels.com/photos/1858161/pexels-photo-1858161.jpeg=20@30)

medium:
![img1](https://images.pexels.com/photos/1974627/pexels-photo-1974627.jpeg=50@80) ![img2](https://images.pexels.com/photos/1858161/pexels-photo-1858161.jpeg=50@80)

large:
![img1](https://images.pexels.com/photos/1974627/pexels-photo-1974627.jpeg=100@150) ![img2](https://images.pexels.com/photos/1858161/pexels-photo-1858161.jpeg=100@150)

## Headers
There are total 6 levels of headers: h1, h2, h3, h4, h5 and h6.

headers are indicated by leading 'sharp's and folloed by a blank.

The text part in headers contains rich-format text, this means the text of a head can be a image, bold text, italic text or mixed content.

1234567890

# H1
## H![image name](https://i.imgur.com/KmppDzf.png=25@25)
### **H3**
#### _H4_
##### **_H5_**
###### _**H6**_

## **This is a bold H2** with image: ![name](https://i.imgur.com/KmppDzf.png=25@25)

## Example parser binary
_**miniMD2html-example**_ is an example parser binary. Your own parser is expected to generate the exactly same output as it.

You can write your own Mini-Markdown files and compare the output of your own parser and the _**miniMD2html-example**_.

## BNF of Mini-Markdown
Please see the assignment description file to find the BNF of Mini-Markdown


## Extra notes
Some functions are provided to help you generate HTML labels.

Please read _global.h_ and _global.c_ to find more details.
