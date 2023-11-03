# EasyHeatmap
ComplexHeatmap script for easy use

  >required R-base version 4.3

# Installation
  ```
  conda create -n RHeatmap -c conda-forge r-base=4.3
  ```
  ```
  conda install -c r r-tidyverse
  ```
  ```
  conda install -c conda-forge r-rio
  ```
  ```
  conda install -c conda-forge r-devtools
  ```
# R-base session
  ```
  R
  ```
  ```
  install.packages("BiocManager")
  ```
  ```
  install.packages("circlize")
  ```
  ```
  install.packages("rjson")
  ```
  ```
  install.packages("insight")
  ```
  ```
  devtools::install_github("jokergoo/ComplexHeatmap")
  ```
# Example
Test how to run
  ```
  Rscript ComplexHeatmap.r ./test/Test_input_data.json
  ```

Picture

![Heatmap-of-plant](https://github.com/Moonipur/EasyHeatmap/assets/119776865/020ecbbb-5798-4d63-8956-cd5dfc6a20e9)



# Contact
Deveper: Mr. Moon

Email: songphon_sutthittha@cmu.ac.th
