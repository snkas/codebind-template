# CodeBind template

[![build](https://github.com/snkas/codebind-template/workflows/build/badge.svg)](https://github.com/snkas/codebind-template/actions?query=workflow%3Abuild+branch%3Amaster)

This repository can be used as the starting point to make use of CodeBind for a new paper.

_This code repository makes use of a gnuplot file. See the complete license at [./LICENSE](./LICENSE) for more detailed information. It moreover makes use of several distribution packages (texlive, gnuplot) and Python modules (texsoup, [exputilpy](https://github.com/snkas/exputilpy), networkx)._


## Basics

1. CodeBind is written to be used on Ubuntu LTE version 18.04, 20.04 or later, with Python version 3.7+ installed.
   You can verify with the following commands:
   * `python3 --version`
   * `python3 -m pip --version` (installable via `sudo apt install python3-pip`)

2. Clone this repository:
   ```
   git clone https://github.com/snkas/codebind-template.git
   cd codebind-template
   ```

3. Setup the environment by executing (*estimated duration: 7-8 min*):
   ```
   bash setup_env.sh
   ```
   ... which should install all dependencies necessary, among which 
   distribution packages (texlive, gnuplot) and Python modules (texsoup, exputilpy, networkx).
   
4. Reproduce the template by executing:
   ```
   bash reproduce.sh
   ```
   ... which will run the entire five step pipeline: build, interpret, run, plot and compile.
   
5. You can view the resulting PDF in: `paper-latex/out/paper.pdf`

6. Feel free to edit the LaTeX source in `paper-latex/section-mmfa.tex` and rerun `bash reproduce.sh` to see the difference in `paper-latex/out/paper.pdf`.


## Define your own experiments

Authors who wish to add new experiment types must implement four components: the run framework, the interpreter, the plotter and the LaTeX. 


**Step 1: run framework**

The run framework is what the experiment is about. The experiment framework can be literally anything that accepts input files and outputs result / log files. Make sure that runs are self-contained (i.e., its input files) and as deterministic as possible.

1. Add the framework under `frameworks/`
2. Edit `setup_env.sh` to install all dependencies
3. Edit `step_1_build.sh` to build the framework and run tests


**Step 2: consider experiments and write draft LaTeX marked up with ExperimenTeX**

Start writing a first draft of the LaTeX in `paper-latex/`:

* Consider which types of experiments (*expclasses*) will exist, and what their relevant parameters are;
* Consider which concrete experiments (*expintances*) will be run, and if they have overlaps that could benefit from defining shared *expclasses* to inherit from;
* Envelop the sentences which describe the experiment setup, such as parameters, with *explines*;
* Represent text (e.g., words, metrics) which depends on experimental results using *expincludetext* commands;
* Represent figures which depend on experimental results using *expincludegraphics* commands.

Concretely, the following steps should be taken:

1. For instance, you wrote `paper-latex/section-example.tex`

2. Add `paper-latex/section-example.tex` to the list of TeX files containing explines in `step_2_interpret.sh`

3. Add `paper-latex/section-example.tex` to the list of TeX files containing expincludes in `step_4_plot.sh`


**Step 3: write interpreter and plotter for each new experiment root class**

1. Name your new root experiment class (e.g., "xyz")

2. Add a new root class:
   ```
   experimentex/rootclasses/rootclass_xyz.py
   ```
   ... which defines the interpreter `XyzRootClassInterpreter` and plotter `XyzRootClassPlotter`
   
3. Add the root class to:
   ```
   experimentex/rootclasses/rootclasses.py
   ```
   
4. (Optional) Don't forget to edit `setup_env.sh` if you have any new dependencies because of the interpreters and plotters you create.


**Step 4: iterative development**

Once authors have an initial draft, they can start with implementing an interpreter and plotter. They can then continue iterating, cycling between:

1. Writing new text with new or modified explines and expincludes;
2. Extending the interpreter to incorporate the explines;
3. Extending the plotter to be able to satisfy the new expincludes;
4. And potentially: extending or adding running frameworks.
