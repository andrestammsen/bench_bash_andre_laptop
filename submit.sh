#!/bin/bash

#SBATCH --job-name=parallel_wavelet_original
#SBATCH --nodes=original
#SBATCH --ntasks=original
#SBATCH --ntasks-per-node=original
#SBATCH --output=parallel_wavelet_original-%j.out
#SBATCH --error=parallel_wavelet_original-%j.err
#SBATCH --time=original

echo "skript $0 is executed"

#srun ./wavelet_contour.py
