#!/bin/bash

# Below you must define the list of all LaTeX
# source files which include ExperimenTeX.

tex_source_files_list=(
  "paper-latex/section-mmfa.tex"
)

######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
# YOU SHOULD NOT NEED TO EDIT BELOW

tex_source_files_list_with_prefix=()
for i in ${tex_source_files_list[@]}
do
  tex_source_files_list_with_prefix+="../${i} "
done

cd experimentex || exit 1
python3 plot.py ${tex_source_files_list_with_prefix[@]} || exit 1
cd .. || exit 1
