#!/bin/bash
# Script to Repartition "Macintosh HD" BEFORE the image processes starts
# To use with Casper Imageing work flow this script must be set to run "Before" in Casper Admin

diskutil partitionDisk disk0 1 GPT HFS+ Macintosh\ HD 100%