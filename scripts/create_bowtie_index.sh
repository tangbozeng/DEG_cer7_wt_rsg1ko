#!/bin/bash

source bowtie2-2.2.9
ref=$1
bowtie2-build --threads 4 $ref $ref
