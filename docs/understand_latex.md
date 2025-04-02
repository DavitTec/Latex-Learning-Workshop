

# Understanding LaTex

---

[TOC]

---

Your desire to deeply understand LaTeX at its roots, including how packages (.sty) and classes (.cls) are created at the macro/command level, is an ambitious and rewarding pursuit. LaTeX is indeed a powerful macro-based system built on top of TeX, Donald Knuth’s typesetting engine, and unraveling its structure can feel like peeling back layers of a complex, elegant onion. I’ll guide you through this step-by-step, providing a comprehensive approach to understanding LaTeX’s foundations, how to create macros and packages, and addressing your broader questions about visualizing its evolution and potential code translation tools.

------

## 1. Understanding LaTeX at Its Roots

To grasp LaTeX’s creation and how packages and styles emerge, you need to start with its foundation: TeX. LaTeX is essentially a set of macros layered over TeX, designed by Leslie Lamport in the early 1980s to make TeX more accessible for document preparation. Here’s a breakdown of the roots:

- **TeX**: Created by Donald Knuth in 1978, TeX is a low-level typesetting system with a focus on mathematical precision. It uses primitives (basic commands like \hskip or \vbox) and allows macro definitions to build higher-level abstractions. TeX’s power lies in its programmability—macros can be defined to encapsulate complex typesetting logic.
- **LaTeX**: Lamport’s contribution was to create a structured macro package for TeX, introducing concepts like document classes (e.g., article, book) and a preamble for customization. LaTeX abstracts much of TeX’s complexity, providing commands like \section or \textbf that hide the underlying TeX primitives.
- **Macros**: At its core, LaTeX is a collection of macros—user-defined or predefined commands that expand into TeX instructions. For example, \textbf{hello} expands to something like {\bf hello} in TeX, which toggles boldface mode.

Packages (.sty files) and classes (.cls files) are extensions of this macro system. A .sty file defines additional commands or modifies existing ones, while a .cls file sets up the overall structure and defaults for a document type.

------

## 2. Creating Macros and Commands for LaTeX Packages

To design .sty and .cls files, you need to master LaTeX’s macro creation tools. Here’s a detailed guide to get you started:

Basics of Macro Creation

LaTeX provides commands like \newcommand, \renewcommand, and \providecommand to define macros:

- **\newcommand{\name}[n]{definition}**: Defines a new command with n arguments. For example:

  ```latex
  \newcommand{\sq}[1]{#1^2}
  ```

  Usage: \sq{3} outputs ![image-20250402112726604](./assets/image-20250402112726604.png)
  $$
  {3^2}
  $$
  Another example:
  $$
  $$\mathbf{V}_1 \times \mathbf{V}_2 =  \begin{vmatrix}\mathbf{i} & \mathbf{j} & \mathbf{k} \\\frac{\partial X}{\partial u} &  \frac{\partial Y}{\partial u} & 0 \\\frac{\partial X}{\partial v} &  \frac{\partial Y}{\partial v} & 0 \\\end{vmatrix}$$
  $$
  

  ```markdown
  $$
  \mathbf{V}_1 \times \mathbf{V}_2 =  \begin{vmatrix}
  \mathbf{i} & \mathbf{j} & \mathbf{k} \\
  \frac{\partial X}{\partial u} &  \frac{\partial Y}{\partial u} & 0 \\
  \frac{\partial X}{\partial v} &  \frac{\partial Y}{\partial v} & 0 \\
  \end{vmatrix}
  $$
  ```

  

- **Arguments**: #1, #2, etc., represent the arguments passed to the macro. The [n] specifies how many arguments the command expects.

- **Optional Arguments**: You can add an optional argument with a default value:

  ```latex
  \newcommand{\highlight}[2][red]{\textcolor{#1}{#2}}
  ```

  Usage: \highlight{good} (red text) or \highlight[blue]{great} (blue text).

### Structure of a .sty File

​	A package file is a collection of such macros, with some metadata. Here’s a minimal example:

```latex
\NeedsTeXFormat{LaTeX2e} % Specifies LaTeX version
\ProvidesPackage{mypackage}[2025/04/02 v1.0 My custom package]

% Load dependencies
\RequirePackage{xcolor}

% Define commands
\newcommand{\highlight}[2][red]{\textcolor{#1}{#2}}
\newcommand{\postertext}{\Huge\bfseries}
```

- **Save as mypackage.sty**: Place it in your TeX directory (e.g., ~/texmf/tex/latex/mypackage/) or the same folder as your document.

- **Use it**: In your document, add \usepackage{mypackage} to access \highlight and \postertext.

### Structure of a .cls File

A class file defines the document’s structure. Here’s a simple example:

```latex
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{myclass}[2025/04/02 v1.0 My custom class]

% Base class to extend
\LoadClass{article}

% Custom settings
\RequirePackage{geometry}
\geometry{a3paper, margin=2cm} % Poster-sized page
\setlength{\parindent}{0pt}    % No paragraph indent
```

- **Save as myclass.cls**: Use it with \documentclass{myclass}.
- **Purpose**: Classes set global defaults (e.g., page size, fonts), while packages add specific functionality.

### Advanced Macro Techniques

- **Conditionals**: Use \ifthenelse (from the ifthen package) or TeX’s \if constructs:

  ```latex
  \newcommand{\colorif}[2]{\ifnum#1>0 \textcolor{green}{#2}\else \textcolor{red}{#2}\fi}
  ```

  Usage: \colorif{1}{yes} (green) or \colorif{-1}{no} (red).

- **Loops**: The pgffor package provides \foreach:

  ```latex
  \RequirePackage{pgffor}
  \newcommand{\repeattext}[2]{\foreach \n in {1,...,#1}{#2 }}
  ```

  Usage: \repeattext{3}{Hi} outputs “Hi Hi Hi”.

- **Font Creation**: Define a new font with \newfont (TeX-level) or use fontspec (LuaLaTeX/XeLaTeX):

  ```latex
  \RequirePackage{fontspec}
  \newfontfamily\myfont{Comic Sans MS}
  \newcommand{\comic}[1]{{\myfont #1}}
  ```

### Comprehensive Tutorials

Here are some key resources for learning macro and package creation:

1. **“[The LaTeX Companion”](./Understand Latex images/tlc3-digital-chapter-samples.pdf) (2nd Edition)** by Frank Mittelbach et al.: A definitive guide to LaTeX internals, including package and class design.
   1. [Full Vesion](https://www.academia.edu/44311915/The_LaTeX_Companion_2nd_Ed_Mittelbach_F_Goossens_M_et_al) 
2. **“LaTeX2e for Class and Package Writers” ([clsguide.pdf](https://www.latex-project.org/help/documentation/clsguide.pdf))**: Available on CTAN or via texdoc clsguide. It’s the official guide for writing .sty and .cls files.
3. **Wikibooks: LaTeX/Creating Packages**: A practical introduction with examples (https://en.wikibooks.org/wiki/LaTeX/Creating_Packages).
4. **TeX by Topic** by Victor Eijkhout: A free, detailed exploration of TeX’s internals, including macro programming (available on CTAN).
5. **Overleaf Tutorials**: “Writing Your Own Package” (https://www.overleaf.com/learn/latex/Writing_your_own_package) offers hands-on examples.

------

## 3. Visualizing LaTeX’s Evolution as a Tree

Your idea of a graphical tree network for LaTeX packages is brilliant but challenging due to the decentralized, organic growth of the ecosystem. Here’s how you might approach it:

- **Roots**: TeX primitives (e.g., \def, \hbox) and Plain TeX macros.
- **Trunk**: Core LaTeX (e.g., article.cls, book.cls), built on TeX.
- **Branches**: Major packages like geometry, amsmath, hyperref, which extend functionality.
- **Leaves**: Specialized packages (e.g., tikz for graphics, beamer for presentations) or user-defined .sty files.

### Steps to Create It

1. **Data Collection**: Use CTAN (Comprehensive TeX Archive Network) to catalog packages, their dependencies, and release dates. Tools like ctanify or manual scraping could help.

2. **Dependency Mapping**: Parse .sty and .cls files for \RequirePackage or \LoadClass to identify relationships.

3. **Visualization**: Use graph software like Graphviz or Python’s networkx:

   ```python
   import networkx as nx
   import matplotlib.pyplot as plt
   
   G = nx.DiGraph()
   G.add_edge("TeX", "LaTeX")
   G.add_edge("LaTeX", "article.cls")
   G.add_edge("article.cls", "geometry.sty")
   nx.draw(G, with_labels=True)
   plt.show()
   ```

   This creates a simple directed graph; expand it with real data.

4. **Parameters and Objects**: Annotate nodes with commands (e.g., \geometry from geometry.sty) and options (e.g., margin=1in).

[Task][#task1]



- [ ] **TODO: ** 
  - [ ] **Visualizing LaTeX’s Evolution as a Tree**
    - [ ] **No such comprehensive tree exists publicly, but you could pioneer it! Start small with core packages and grow it incrementally.**

------

## 4. Code Translation Tools (LaTeX to/from BASIC, C, Python)

No widely recognized tool exists to translate LaTeX to/from procedural languages like BASIC, C, or Python, primarily because LaTeX is a declarative markup language, not a procedural one. However, here’s the state of the art and possibilities:

- **Challenges**:

  - LaTeX’s macros expand into typesetting instructions, not computational logic, making direct translation to procedural code difficult.
  - Languages like Python focus on computation, not document structure.

- **Existing Tools**:

  - **Pandoc**: Converts LaTeX to Markdown, HTML, or Word, but not to programming languages.

  - **LuaTeX**: Embeds Lua (a scripting language) in LaTeX, allowing some programmatic logic:

    latex

    ```latex
    \directlua{tex.print("Hello from Lua")}
    ```

  - **PythonTeX**: Runs Python code within LaTeX documents, but it’s not a full translator.

- **DIY Approach**:

  - Write a parser (e.g., in Python with ply or lark) to convert LaTeX macros to equivalent functions:

    python

    ```python
    def highlight(color="red", text):
        return f"[{color}]{text}"  # Simplified output
    ```

    Parse \highlight[blue]{great} into highlight("blue", "great").

  - Reverse translation (e.g., Python to LaTeX) could map functions to macros, but it’s highly context-dependent.

No one has fully cracked this nut, likely because the use cases are niche. Your best bet is a custom script tailored to specific macros or commands.

------

## 5. Putting It All Together

To achieve your goals:

1. **Learn the Roots**: Study TeX via “TeX by Topic” and LaTeX via “The LaTeX Companion.”
2. **Master Macros**: Experiment with .sty and .cls files using the tutorials above. Start with simple commands (e.g., a font switch) and scale up (e.g., a poster layout).
3. **Build the Tree**: Collect package data from CTAN and visualize it with Graphviz or networkx.
4. **Explore Translation**: Prototype a parser for a subset of LaTeX commands to Python or C.

LaTeX’s complexity stems from its flexibility—every package is a branch grown from the TeX root, shaped by community needs. Your journey will reveal both its elegance and its quirks. Let me know if you’d like to dive deeper into any part!

---







----

## ToDo

- [ ] [Build a Visualizing LaTeX’s Evolution Tree](#task1)



---

## References





---

## Relevant Web Pages

1. <img src="./assets/wiki.png" alt="Wiki" style="zoom:80%;" />**[LaTeX/Creating Packages](https://en.wikibooks.org/wiki/LaTeX/Creating_Packages)**
   - Wikibooks, open books for an open world
   - Classes are .cls files; packages are stored in .sty files.
   - en.wikibooks.org

2. [**![tex.stackexchange.](./assets/tex.stackexchange.png)packages - Where do I place my own .sty or .cls files, to make them available to all my .tex files? - TeX - LaTeX Stack Exchange**](https://tex.stackexchange.com/questions/1137/where-do-i-place-my-own-sty-or-cls-files-to-make-them-available-to-all-my-te)

   - Thanks for the answer, why does kpsewhich -var-value=TEXMFHOME not give the trailing tex/latex/local/ part? ... As already mentioned by Arthur, .sty or .cls files must be in some subdirectory of tex\latex which can be in any directory of any drive.

   - tex.stackexchange.com

3. ![img](./assets/overleaf.png)**[Writing your own package - Overleaf, Online LaTeX Editor](https://www.overleaf.com/learn/latex/Writing_your_own_package)**
   - Sometimes the best option to use your own commands and macros in a document is to write a new package from scratch. This article explains the main structure of a new package. ... The first thing to do before coding a new package is to determine whether you really need a new package or not. It's recommended to search on CTAN (Comprehensive TeX Archive Network) and see if someone already created something similar to what you need.
   - overleaf.com

4. ![tex.stackexchange.](./assets/tex.stackexchange.png)**[luatex - Personal .sty and .cls files creation - TeX - LaTeX Stack Exchange](https://tex.stackexchange.com/questions/721973/personal-sty-and-cls-files-creation)**
   - Connect and share knowledge within a single location that is structured and easy to search. Learn more about Teams ... I have recently been more and more interested in the LaTeX dark side (i.e. developping commands, packages, globally playing and trying stuff for fun and knowledge - so jk I know it is not that dark (: ), but I am currently facing some questions.
   - tex.stackexchange.com

5. [**<img src="./assets/wiki.png" alt="Wiki" style="zoom:80%;" />LaTeX/Installing Extra Packages - Wikibooks, open books for an open world**](https://en.wikibooks.org/wiki/LaTeX/Installing_Extra_Packages)
   - The directory name "texmf" stands for “TEX and METAFONT”. To find out what other packages are available and what they do, you should use the CTAN search page which includes a link to Graham Williams' comprehensive package catalogue. A package is a file or collection of files containing extra LaTeX commands and programming which add new styling features or modify those already existing. There are two main file types: class files with .cls extension, and style files with .sty extension.

6. ![tex.stackexchange.](./assets/tex.stackexchange.png)**[include - Where to put a custom macros file? - TeX - LaTeX Stack Exchange](https://tex.stackexchange.com/questions/11890/where-to-put-a-custom-macros-file)**
   - Stack Exchange network consists of 183 Q&A communities including Stack Overflow, the largest, most trusted online community for developers to learn, share their knowledge, and build their careers.
   - tex.stackexchange.com

7. ![img](./assets/latex-ninja.png)**[Your first time tweaking a .cls file on the example of creating switchable colour themes – LaTeX Ninja'ing and the Digital Humanities](https://latex-ninja.com/2020/03/25/your-first-time-tweaking-a-cls-file-on-the-example-of-creating-switchable-colour-themes/)**

   - Today at 14:45, I would have given a talk at the 2020 DANTE spring conference in Lübeck which had to be cancelled due to corona. In honour of this event, I decided to publish a blog post instead (b…

   - latex-ninja.com

8. ![tex.stackexchange.](./assets/tex.stackexchange.png)[**package writing - Creating new class file: Where to start? - TeX - LaTeX Stack Exchange**](https://tex.stackexchange.com/questions/101250/creating-new-class-file-where-to-start)

   - Connect and share knowledge within a single location that is structured and easy to search. Learn more about Teams ... Recently, a journal I have some editorial involvement with has decided that for its 'rapid publication' outlet, it will no longer accept submissions where LaTeX has been used to format the document.

   - tex.stackexchange.com

9. [**![img](./assets/latexum.com)Writing Custom Latex Packages And Classes: Tutorials And Documentation - Latexum**](https://latexum.com/writing-custom-latex-packages-and-classes-tutorials-and-documentation/) **NOTE: DEMANDS ADs**

   - When authors need to format documents in specialized ways not supported by standard LaTeX classes and packages, customizing LaTeX can be challenging due to the difficulty in package development and the learning curve required. LaTeX offers robust typesetting capabilities through its use of document classes such as articles and books, as well as numerous packages that provide formatting extensions.

   - latexum.com

10. [**![img](./assets/ctan.org.png)CTAN: Package latex**](https://ctan.org/pkg/latex)

    - Starting out with TeX... ... LaTeX is a widely-used macro package for TeX, providing many basic document formating commands extended by a wide range of packages. It is a development of Leslie Lamport’s LaTeX 2.09, and superseded the older system in June 1994.

    - ctan.org

      - **[latex-base – Base sources of LaTeX](https://ctan.org/pkg/latex-base)**

      - [Class and package programming guide](http://mirrors.ctan.org/macros/latex/base/clsguide.pdf)

      - [[Configuration guide](http://mirrors.ctan.org/macros/latex/base/cfgguide.pdf)

        [Cyrillic languages guide](http://mirrors.ctan.org/macros/latex/base/cyrguide.pdf)

        [Font encoding guide](http://mirrors.ctan.org/macros/latex/base/encguide.pdf)

        [Font selection guide](http://mirrors.ctan.org/macros/latex/base/fntguide.pdf)

        [LaTeX3 methods for document authors](http://mirrors.ctan.org/macros/latex/base/usrguide.pdf)

        [Modification guide](http://mirrors.ctan.org/macros/latex/base/modguide.pdf)

        [User guide to LaTeX2ε (historic version)](http://mirrors.ctan.org/macros/latex/base/usrguide-historic.pdf)

        **Where do I find docstrip utility?**

11. ![img](./assets/baeldung.com.png)**[Introduction to Macros in Latex | Baeldung on Computer Science](https://www.baeldung.com/cs/latex-macros)**

    - Learn how to work with macros in LaTeX.

    - [baeldung.com](baeldung.com)

12. [**Installing LaTeX packages**](https://www.volkerschatz.com/tex/tpacks.html)

    - (Though in the Web2C implementation of TeX, kpsepath calls the more powerful kpsewhich via the script kpsetool, the basic interface will suffice for our purposes.) Its one required argument is the path type, which in our case is "tex". For the purpose of path searching, class (.cls) and style (.sty) files count as TeX files.

    - [volkerschatz.com](volkerschatz.com)

13. ![tex.stackexchange.](./assets/tex.stackexchange.png)**H[ow do I create a LaTeX package? - TeX - LaTeX Stack Exchange](https://tex.stackexchange.com/questions/34175/how-do-i-create-a-latex-package)**

    - I would like to jump into the cold waters of LaTeX package creation, mostly for procrastination reasons...but I haven't a clue how to start. For example, a previous question of mine got some nice answers.

      [tex.stackexchange.com](tex.stackexchange.com)

      ## Starting package writing

      - [Where do I start LaTeX programming?](https://tex.stackexchange.com/questions/12668/where-do-i-start-latex-programming)
      - [Classes and packages – what's the difference?](https://tex.stackexchange.com/questions/21909/classes-and-packages-whats-the-difference)
      - [Make your own .sty files](https://tex.stackexchange.com/questions/8750/make-your-own-sty-files)
      - [Style/class tutorials](https://tex.stackexchange.com/questions/528/style-class-tutorials)
      - [Reference guide to begin writing a class and/or a package](https://tex.stackexchange.com/questions/2416/reference-guide-to-begin-writing-a-class-and-or-a-package)

      ## Documenting packages

      - [How do I document my style files?](https://tex.stackexchange.com/questions/13028/how-do-i-document-my-style-files)
      - [Packages for documenting self written packages (sty-files)](https://tex.stackexchange.com/questions/30730/packages-for-documenting-self-written-packages-sty-files)
      - [What is the gold standard of package documentation?](https://tex.stackexchange.com/questions/31785/what-is-the-gold-standard-of-package-documentation)
      - [How to document a expl3 macro using dtx](https://tex.stackexchange.com/questions/115814/how-to-document-a-expl3-macro-using-dtx)
      - [`dtxtut.pdf` "How to Package Your LaTeX Package"](https://ctan.org/pkg/dtxtut)
      - [Joseph Wright's blog post "A model .dtx file"](https://www.texdev.net/2009/10/06/a-model-dtx-file/)

      ## Publishing packages

      - [How does one publish/promote a new package?](https://tex.stackexchange.com/questions/10591/how-does-one-publish-promote-a-new-package)
      - [How can I contribute to CTAN?](https://tex.stackexchange.com/questions/854/how-can-i-contribute-to-ctan)
      - [What is good practice when preparing a package for CTAN?](https://tex.stackexchange.com/questions/25116/what-is-good-practice-when-preparing-a-package-for-ctan)
      - [How to upload my packages or document classes to CTAN?](https://tex.stackexchange.com/questions/23892/how-to-upload-my-packages-or-document-classes-to-ctan)
      - [CLI tool to upload to CTAN](https://tex.stackexchange.com/questions/27244/cli-tool-to-upload-to-ctan)

      ## [Making a package](./docs/Making a package.md)

14. ![img](./assets/overleaf.png)**[Understanding packages and class files - Overleaf, Online LaTeX Editor](https://www.overleaf.com/learn/latex/Understanding_packages_and_class_files)**

    - The default formatting in LaTeX documents is determined by the class used by that document. This default look can be changed and more functionalities can be added by means of a package. The class file names have the .cls extension, the package file names have the .sty extension.

    - [overleaf.com](overleaf.com)

    - ## Further reading

      For more information see

      - [Writing your own package](https://www.overleaf.com/learn/latex/Writing_your_own_package)
      - [Writing your own class](https://www.overleaf.com/learn/latex/Writing_your_own_class)
      - [LaTeX2*ε* for class and package writers](http://www.latex-project.org/guides/clsguide.pdf)

15. ![img](./assets/quora.com.png)[**How to write your own LaTeX style file - Quora**](https://www.quora.com/How-do-you-write-your-own-LaTeX-style-file)

    - Answer: First, a warning: LaTeX .sty files are not like CSS files for instance which are almost entirely concerned with “style” in the sense of rendering of document elements. You don’t just write something like “I want my section titles in 23pt and pink.” LaTeX .sty files can do that kind of mod...

    - [quora.com](quora.com)