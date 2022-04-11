\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tikhon_resume}[2022/04/10 Tikhon's Resume format]

\LoadClass{article}


%% Page setup
\pagestyle{empty}

\RequirePackage{geometry}
\geometry{
  verbose,
  letterpaper,
  tmargin=1.5cm,
  bmargin=1.5cm,
  lmargin=1.5cm,
  rmargin=1.5cm
}


%% Fonts + Symbols
\RequirePackage{fontspec,xltxtra,xunicode}
\setmainfont{Junction}
\setmonofont{DejaVuSansMono}
\newfontfamily\headerfont{Aller}

\newfontfamily\dejafont{DejaVu Sans}

\RequirePackage{newunicodechar}
\newunicodechar{✉}{\raisebox{-0.15\height}{\scalebox{1.4}{\dejafont✉}}}
\providecommand{\email}[1]{%
  ✉ {\dejafont #1}%
}

\RequirePackage{fontawesome}
\providecommand{\github}[1]{%
  \raisebox{-0.15\height}{\scalebox{1.2}{\faicon{github}}} %
  \href{https://github.com/#1}{{\dejafont github.com/#1}}%
}

%% Section headers
\RequirePackage{titlesec}

\titleformat{\section}[runin]
  {\Large\headerfont}
  {}{0em}             % prefix
  {}                  % code before heading
  [ \titlerule]       % code after heading
\titlespacing{\section}{0em}{2ex}{0ex}

\titleformat{\subsection}
  {\large\headerfont}
  {}{0em}
  {}
\titlespacing{\subsection}{0em}{1.5ex}{0.5ex}

\titleformat{\subsubsection}
  {\headerfont}
  {}{0em}
  {}
\titlespacing{\subsubsection}{0em}{0ex}{1.5ex}


%% Within-Line Alignment
\providecommand{\lr}[2]{%
  \parbox[t]{0.7\linewidth}{\raggedright#1}%
  \parbox[t]{0.3\linewidth}{\raggedleft#2}%
}

\providecommand{\lcr}[3]{%
  \parbox[t]{0.333\linewidth}{\raggedright#1}%
  \parbox[t]{0.333\linewidth}{\centering#2}%
  \parbox[t]{0.333\linewidth}{\raggedleft#3}%
}


%% Lists
\RequirePackage{enumitem}
\setlist{itemsep=2pt,topsep=0pt}

%% Date ranges
\providecommand{\dated}[2]{%
  \subsection[#1]{#1 \hfill #2}%
}

\providecommand{\datedsub}[2]{%
  \subsubsection[#1]{#1 \hfill #2}%
}
