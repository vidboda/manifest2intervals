# Manifest2interval

Bash script to convert Illumina manifests file into GATK Intervals.list files. Can also convert BED files into .list files.

## Usage

perl manifest2interval.pl -i path/to/manifest/file.txt or file.bed

Input is a .txt or .bed file, output is a .list file of format chr:start-end

WARNING: The BED file is assumed to be 0-based. Output is 1-based. For more detailes see [here](http://genome.ucsc.edu/blog/the-ucsc-genome-browser-coordinate-counting-systems/)

## Please note

that converting BED into intervals files is easier using awk, see [here](https://gist.github.com/beboche) for an example.
