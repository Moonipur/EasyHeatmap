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
Edit only JSON file
  ```
  {
      "Excel_path": "/mnt/d/CMU_TEAM/Coding_part/cfDNA/Model/dataset-for-train/dataset-complete.xlsx",
      "Output_dir": "/mnt/d/CMU_TEAM/Coding_part/cfDNA/Model/plot",
      
      "Main_plot": {
          "title": "Heatmap visualization",
          "legend": "Z-score",
          "y_label": 1,
          "y_label_font": 10,
          
          "data_column": ["4:14","15:17", 25],
          "data_type":"continuous",
          
          "scaling": true,
          "color": ["orange", "darkviolet"],
          
          "row_dendrogram": true,
          "column_dendrogram": false,
          
          "split_row_group": {
              "display": false,
              "method": "by_dend",
              "categorical": null
          },
          "split_column_group": {
              "display": false,
              "method": "by_categ",
              "categorical": 26
          }
      },
      
      "Side_plot": {
          "data_column": [2, 3], 
          "visaul_type": ["bar", "bar"],
          "data_type": ["categ", "conti"],
          "sub_legend": ["Sex", "Age"], 
          "color": [["pink","blue"], ["green","gray"]]
      },
  
      "Export": {
          "file_type": "png",
          "file_name": "Heatmap-of-cfHCC",
          "width": 800,
          "height": 1500,
          "resolution": 120
      }
  }
  ```

Test how to run
  ```
  Rscript ComplexHeatmap.r ./test/Test_input_data.json
  ```

Picture

![Heatmap-of-plant](https://github.com/Moonipur/EasyHeatmap/assets/119776865/020ecbbb-5798-4d63-8956-cd5dfc6a20e9)



# Contact
Deveper: Mr. Moon

Email: songphon_sutthittha@cmu.ac.th
