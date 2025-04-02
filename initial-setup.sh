#!/bin/bash
# title initial-setup.sh
# version 0.0.1
# author DavitTec
# date 2023-10-01
# description This script sets up a new LaTeX project directory with a basic structure and README file.

# Get .environment variables
# shellcheck disable=SC1091
source ./.env
# Get the project

# name from the environment variable or use a default name
export PROJECT_NAME=${PROJECT_NAME:-"Latex-Learning-Workshop"}
export GIT_USERNAME=${GIT_USERNAME:-"joe bloggs"}
export GIT_TOKEN=${GIT_TOKEN:-"my-secret-token"} #
export GIT_REPO=${GIT_REPO:-"Latex-Learning-Workshop"}

# Get the project name from the first argument or use a default name
Project_name=${1:-$PROJECT_NAME}
LATEX_FOLDER="LaTex_Projects"

# usage ./initial-setup.sh
# check if the script is run with root privileges
# if [ "$EUID" -ne 0 ]; then
#     echo "Please run as root"
#     exit
# fi

# TODO # check if the script is run with a valid argument
# # check if the script is run with a valid argument
# if [ $# -ne 1 ]; then
#   echo "Usage: $0 $Project_name"
#   exit 1
# fi
# check if the argument is a valid directory name
if [[ ! "$Project_name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo "Invalid project name. Only alphanumeric characters, underscores, and hyphens are allowed."
    exit 1
fi

# create the project directory
if [ ! -d "$LATEX_FOLDER" ]; then
    mkdir "$LATEX_FOLDER"
    echo " - Directory $LATEX_FOLDER created successfully."
else
    echo " - Directory $LATEX_FOLDER already exists."
fi

cd "$LATEX_FOLDER" || exit
echo "Project directory $LATEX_FOLDER created successfully."

# create the subdirectories
mkdir -p src figures tables
echo " - Subdirectories src, figures, and tables created successfully."

# create the main LaTeX file
cat <<EOL >main.tex
\documentclass{article}     
\usepackage{graphicx}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage{hyperref}

\title{Your Title Here}
\author{Your Name Here}
\date{\today}

\begin{document}
\maketitle
\section{Introduction}
This is a sample LaTeX document.
\section{Figures}

\begin{figure}[h]
    \centering
    \includegraphics[width=0.5\textwidth]{figures/your-figure.png}
    \caption{Your caption here}
    \label{fig:your-label}
\end{figure}
\section{Tables}
\begin{table}[h]
    \centering
    \begin{tabular}{|c|c|c|}
        \hline
        Column 1 & Column 2 & Column 3 \\
        \hline
        Data 1   & Data 2   & Data 3   \\
        \hline
    \end{tabular}
    \caption{Your caption here}
    \label{tab:your-label}
\end{table}
\section{Math}
\begin{equation}
    E = mc^2
\end{equation}
\section{References}
\bibliographystyle{plain}
\bibliography{references}
\end{document}
EOL
echo " - main.tex file created successfully."

# create the references file
cat <<EOL >references.bib
@article{sample,
    author = {Author, A.},
    title = {Sample Title},
    journal = {Sample Journal},
    year = {2023},
    volume = {1},
    number = {1},
    pages = {1-10}
}
@book{samplebook,
    author = {Author, B.},
    title = {Sample Book},
    publisher = {Sample Publisher},
    year = {2023}
}
@misc{samplemisc,
    author = {Author, C.},
    title = {Sample Miscellaneous},
    year = {2023},
    url = {https://example.com}
}
EOL

# create the .latexmkrc file
cat <<EOL >.latexmkrc
# Use pdflatex as the default compiler
$pdf_mode = 1; # 1 = pdflatex
# Enable continuous preview mode
$preview_mode = 1; # 1 = continuous preview mode
# Enable shell escape
$enable_shell_escape = 1; # 1 = enable shell escape
# Enable bibliography processing
$bibtex_use = 1; # 1 = enable bibtex
# Enable glossary processing
$glossary_use = 1; # 1 = enable glossary
# Enable index processing
$index_use = 1; # 1 = enable index
# Enable makeindex processing
$makeindex_use = 1; # 1 = enable makeindex
# Enable biber processing
$biber_use = 1; # 1 = enable biber        
# Enable biblatex processing
$biblatex_use = 1; # 1 = enable biblatex
# Enable bibtex processing
$bibtex_use = 1; # 1 = enable bibtex
# Enable makeglossaries processing  

$makeglossaries_use = 1; # 1 = enable makeglossaries
# Enable makeindex processing
$makeindex_use = 1; # 1 = enable makeindex
# Enable makeglossaries processing
$makeglossaries_use = 1; # 1 = enable makeglossaries
# Enable makeindex processing
$makeindex_use = 1; # 1 = enable makeindex
# Enable makeglossaries processing
$makeglossaries_use = 1; # 1 = enable makeglossaries
# Enable makeindex processing
$makeindex_use = 1; # 1 = enable makeindex
# Enable makeglossaries processing
$makeglossaries_use = 1; # 1 = enable makeglossaries
# Enable makeindex processing       
EOL

echo " - .latexmkrc file created successfully."

# Any more for Latex_Projects?
#
echo " - LaTeX project structure created successfully."

# create the README file
cat <<EOL >README.md
# LaTeX Project: $Project_name 
EOL

echo "# - Latex-Learning-Workshop" >>README.md

cd .. # back to the parent directory

# create the .gitignore file in root directory

if [ -f ".gitignore" ]; then
    echo "File \".gitignore\" exists"
else
    cat <<EOL >.gitignore
# Ignore LaTeX auxiliary files
*/build/*.aux     
*/build/*.toc
*.synctex.gz
*.fdb_latexmk     
*.run.xml
*.synctex
*/build/*.fls

#environment
*.env
*.env.local
*.env.development.local
*.env.test.local
*.env.production.local
*.env.development
*.env.test
*.env.production

# Ignore temporary files
*.tmp
*.temp

# Ignore backup files
*/build/*~
*/build/*.bak

# Ignore log files
*/build/*.log

# Ignore compiled files
*/build/*.pdf
*/build/*.dvi

# Ignore output files
*/out
*/build  #This ignores all the content in the build directory

# Node
.node_modules

EOL

    echo " - .gitignore file created successfully."
fi

# #copy or create VSCODE Workspace in the project directory
# TODO  the .vscode directory in the project directory
# cp -r ../.vscode ./
# vscode --add .vscode
# create the .vscode directory in the project directory
if [ -d ".vscode" ]; then
    echo "Directory \".vscode\" exists"
else
    mkdir .vscode
    echo " - Directory .vscode created successfully."
fi
# create the settings.json file in the .vscode directory
cat <<EOL >.vscode/settings.json
{
    "files.autoSave": "onWindowChange",
    "editor.wordWrapColumn": 160,
    "latex-workshop.view.pdf.viewer": "tab",
    "latex-workshop.latex.autoBuild.run": "onFileChange",
    "latex-workshop.latex.autoBuild.cleanAndRetry": true,
    "latex-workshop.latex.autoBuild.onSave": true
}
EOL
echo " - settings.json file created successfully."
# create the tasks.json file in the .vscode directory

echo " - VSCODE setting files copied successfully."

# create the .env_example file
cat <<EOL >.env_example
# .env_example  file        
# This file is an example of the .env file
# It contains the environment variables used in the script
# You can copy this file to .env and fill in the values

PROJECT_NAME="Latex-Learning-Workshop"

# GIT credentials
# You can use a personal access token instead of a password
# You can create a personal access token in your GitHub account settings
GIT_USERNAME=your-git-username
GIT_TOKEN="<personal-access-token>"
GIT_REPO="Latex-Learning-Workshop"

EOL

#  Copy my .env credentials to .env file"
# TODO Were to put the .env file?

# echo " - .env file created successfully."

# copy initial-setup.sh file to src directory
if [ -d "src" ]; then
    echo "Directory \"src\" exists"
else
    mkdir src
    echo " - Directory src created successfully."
fi
# copy the initial-setup.sh file to the src directory
cp -p initial-setup.sh src/
echo " - initial-setup.sh file copied to src directory successfully."
rm initial-setup.sh

#  Create a README file in the src  directory
cat <<EOL >"$LATEX_FOLDER/src/README.md"
# LaTeX Project: $Project_name
This is the source code directory for the LaTeX project: $Project_name
EOL

echo " - README.md file created in src directory successfully."

#  create a README file in the root directory

if [ -f "README.md" ]; then
    echo "File \"README.md\" exists"
    cat <<EOL >>README.md


## Things to do

This is the root README for the LaTeX project: $Project_name
This *[$LATEX_FOLDER](./$LATEX_FOLDER)* contains the following subdirectories:

- *src*: This directory contains the source code for the LaTeX project.
- *figures*: This directory contains the figures for the LaTeX project.
- *tables*: This directory contains the tables for the LaTeX project.
- *build*: This directory contains the build files for the LaTeX project.
- *out*: This directory contains the output files for the LaTeX project.

This project README was created by DavitTec
EOL

else
    echo "File \"README.md\" does not exist"

    cat <<EOL >>README.md
# LaTeX Project: $Project_name

## Things to do

This is the root README for the LaTeX project: $Project_name
This *[$LATEX_FOLDER](./$LATEX_FOLDER)* contains the following subdirectories:
- *src*: This directory contains the source code for the LaTeX project.
- *figures*: This directory contains the figures for the LaTeX project.
- *tables*: This directory contains the tables for the LaTeX project.
- *build*: This directory contains the build files for the LaTeX project.
- *out*: This directory contains the output files for the LaTeX project.

This project README was created by DavitTec
EOL
fi

echo " - README.md file created in root directory successfully."

# create a new repository
# Git initialization
# echo " - Initilizing git repository"
# git init
# git add README.md
# git commit -m "first commit"
# git branch -M master
# git remote add origin https://$GIT_TOKEN@github.com/$GIT_USERNAME/$GIT_REPO.git"
# git push -u origin master
# echo " - Git repository initialized and first commit made."
#
# OR
#
# push an existing repository from the command line

echo " - Pushing existing repository to GitHub"
echo " - git remote set-url origin https://$GIT_TOKEN@github.com/$GIT_USERNAME/$GIT_REPO.git"

git remote set-url origin https://$GIT_TOKEN@github.com/$GIT_USERNAME/$GIT_REPO.git

# https://github.com/DavitTec/Latex-Learning-Workshop.git

echo " - git statements following"

git remote add origin https://github.com/$GIT_USERNAME/$GIT_REPO.git
git branch -M master
git push -u origin master

echo " - Project directory $Project_name created successfully."
echo " - Project setup completed successfully."

exit 0
