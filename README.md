# EasyHeatmap
ComplexHeatmap script for easy use

  >required R-base version 4.3

# Installation
  ```
  conda create -n RHeatmap -c conda-forge r-base=4.3
  ```
  ```
  conda activate Rheatmap
  ```
  ```
  conda install -c conda-forge r-rio
  ```
  ```
  conda install -c conda-forge r-devtools
  ```
# R-base session
  ```
  conda activate RHeatmap
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
      "Excel_path": "./Plant_metabolites.xlsx",
      "Output_dir": null,
      
      "Main_plot": {
          "title": "Heatmap example",
          "legend": "Z-score",
          "y_label": 1,
          "y_label_font": 10,
          
          "data_column": ["2:5"],
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
          "data_column": [7, 8], 
          "visaul_type": ["tab", "tab"],
          "data_type": ["conti", "categ"],
          "sub_legend": ["Age", "Height"], 
          "color": [["white","green"], ["salmon","yellow"]]
      },
  
      "Export": {
          "file_type": "png",
          "file_name": "Heatmap-of-plant",
          "width": 400,
          "height": 500,
          "resolution": 100
      }
  }
  ```

Usage
  ```
  Rscript ComplexHeatmap.r ./Input_data.json
  ```

Test 
  ```
  Rscript ComplexHeatmap.r ./test/Test_input_data.json
  ```

Picture

![Heatmap-of-plant](https://github.com/Moonipur/EasyHeatmap/assets/119776865/020ecbbb-5798-4d63-8956-cd5dfc6a20e9)



# Contact
Deveper: Mr. Moon

Email: songphon_sutthittha@cmu.ac.th
