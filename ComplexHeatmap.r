library(tidyverse)
library(rio)
library(ComplexHeatmap)
library(circlize)
library(rjson)
library(insight)

params <- fromJSON(file='Input_data.json')
false_sym <- '\U1F5F7 '
true_sym <- '\U1F5F9 '

# Check input path
if (file.exists(params$Excel_path) == FALSE) {
    input = 1
} else {
    input = 0
    if (is.null(params$Output_dir) == TRUE) {
        params$Output_dir <- getwd()
        outdir = 0
    } else if (dir.exists(params$Output_dir) == FALSE) {
        outdir = 1
    } else {
        outdir = 0
    }
}

df <- import(params$Excel_path)
df <- as.data.frame(df)

# Check data
title = 0
if (is.null(params$Main_plot$title) == TRUE) {
    params$Main_plot$title <- 'NULL'
}
legend = 0
if (is.null(params$Main_plot$legend) == TRUE) {
    params$Main_plot$legend <- 'NULL'
}
if (is.null(params$Main_plot$y_label) == TRUE | is.character(df[1,params$Main_plot$y_label]) == FALSE) {
    y_label = 1
} else {
    y_label = 0
}

######################################
#

matrix_vect <- unlist(params$Main_plot$data_column)
if (sum(!grepl(':', matrix_vect)) == length(matrix_vect)) {
    matrix_data <- as.numeric(matrix_vect)
} else {
    matrix_data <- as.numeric(matrix_vect[!grepl(':', matrix_vect)])
    index.str <- grep(':', matrix_vect)
    for (i in index.str) {
        matrix_vect[i]
        strend <- as.numeric(strsplit(matrix_vect[i], ':')[[1]])
        range <- strend[1]:strend[2]
        matrix_data <- append(matrix_data, range)
    }
    matrix_data <- sort(matrix_data)
}
num.col <- 0
str.col <- 0
for (j in matrix_data) {
    if (is.numeric(df[1,j]) == TRUE) {
        num.col <- num.col + 1
    } else if (is.character(df[1,j]) == TRUE) {
        str.col <- str.col + 1
    }
}
if (num.col == length(matrix_data) & params$Main_plot$data_type == 'continuous') {
    main_data = 0
    data_type = 0
} else if (str.col == length(matrix_data) & params$Main_plot$data_type == 'categorical') {
    main_data = 0
    data_type = 0
} else {
    main_data = 1
    data_type = 1
}
row_dendrogram = 0
column_dendrogram = 0

if (params$Main_plot$split_row_group$method == 'by_kmean') {
    method.row = 'km'
    med.row = 0
} else if (params$Main_plot$split_row_group$method == 'by_dend') {
    method.row = 'dend'
    med.row = 0
} else if (params$Main_plot$split_row_group$method == 'by_categ' & is.character(df[1,params$Main_plot$split_row_group$categorical]) == TRUE) {
    method.row = 'categ'
    meth.row.cat = params$Main_plot$split_row_group$categorical
    med.row = 0
} else {
    med.row = 1
}

if (params$Main_plot$split_column_group$method == 'by_kmean') {
    method.col = 'km'
    med.col = 0
} else if (params$Main_plot$split_column_group$method == 'by_dend') {
    method.col = 'dend'
    med.col = 0
} else if (params$Main_plot$split_column_group$method == 'by_categ' & is.character(df[1,params$Main_plot$split_column_group$categorical]) == TRUE) {
    method.col = 'categ'
    meth.col.cat = params$Main_plot$split_column_group$categorical
    med.col = 0
} else {
    med.col = 1
}
######################################
#
print_func <- function(x, se='') {
    if (x != 0) {
        print_color(paste(se, false_sym, sep=''), 'red')
    } else {
        print_color(paste(se, true_sym, sep=''), 'green')
    }
}

# Print checking process
print_color('Checking processes\n', 'blue')
message('')
print_color('>> 1. Paths\n', 'green')
message('')
print_func(input)
message('input: ', params$Excel_path)
print_func(outdir)
message('outdir: ', params$Output_dir)
message('')

print_color('>> 2. Main-plot data\n', 'green')
message('')
print_func(title)
message("title: ", params$Main_plot$title)
print_func(legend)
message("legend: ", params$Main_plot$legend)
print_func(y_label)
message("y_label: ")
print(params$Main_plot$y_label)
print_func(main_data)
message("main_data: ")
print(matrix_data)
print_func(data_type)
message("data_type: ", params$Main_plot$data_type)
print_func(row_dendrogram)
message("row_dendrogram: ", params$Main_plot$row_dendrogram)
print_func(column_dendrogram)
message("column_dendrogram: ", params$Main_plot$column_dendrogram)
scaling = 0
print_func(scaling)
message("scaling: ", params$Main_plot$scaling)
if (params$Main_plot$split_row_group$display == FALSE) {
    print_func(0)
    message("row_split: Undisplay")
} else {
    print_func(0)
    message("row_split: Display")
    print_func(med.row, '\t')
    message("row_split_method: ", method.row)
    if (method.row == 'categ') {print(meth.row.cat)}
}
if (params$Main_plot$split_column_group$display == FALSE) {
    print_func(0)
    message("column_split: Undisplay")
} else {
    print_func(0)
    message("column_split: Display")
    print_func(med.col, '\t')
    message("column_split_method: ", method.col)
    if (method.col == 'categ') {print(meth.col.cat)}
}

message('')
print_color('>> 3. Side-plot data\n', 'green')
message('')

for (i in 1:length(params$Side_plot$data_column)) {
    if (params$Side_plot$data_type[i] == 'categ' & is.character(df[1, params$Side_plot$data_column[i]]) == TRUE) {
        t=0
    } else if (params$Side_plot$data_type[i] == 'conti' & is.numeric(df[1, params$Side_plot$data_column[i]]) == TRUE) {
        t=0
    } else {
        t=1
    }
    
    print_func(t)
    message("side annotate ", params$Side_plot$sub_legend[i],": ", params$Side_plot$data_column[i], " : ", params$Side_plot$visaul_type[i])
}

total_check = (
    input + outdir + y_label + main_data + data_type 
)
if (total_check != 0) {
    quit()
}
######################################
#
matrix <- df[matrix_data]
if (params$Main_plot$scaling == TRUE) {
    matrix <- scale(matrix)
}

col_lab <- colnames(matrix)
row_lab <- df[[params$Main_plot$y_label]]
font <- params$Main_plot$y_label_font

######################################
message('')
print_color('Cleaning processes\n', 'blue')
message('')
print_func(0)
message("scaling: PASS")
print_func(0)
message("column name order: PASS")
message('')

######################################
# color

main_color <- colorRamp2(c(min(matrix), median(matrix), max(matrix)), c(params$Main_plot$color[1], 'white',params$Main_plot$color[2]))

############################################################################
############################################################################
############################################################################
# side annotation 
# ***Please edit with our hand because it's package limitation !!!
 
col_fun <- colorRamp2(c(min(df[[3]]), max(df[[3]])), c('dimgray','green'))

r_anno <- rowAnnotation(
    Sex = df[[2]],
    Age = df[[3]], 
    col= list(
        Sex = c('Female'='deeppink', 'Male'='blue'),
        Age = col_fun
    )
)
############################################################################
############################################################################
############################################################################

# heatmap
hm <- Heatmap(
    matrix, show_row_names =TRUE, row_names_gp = gpar(fontsize = font),
    column_names_gp = gpar(fontsize = font), row_labels = row_lab, show_column_dend = FALSE,
    column_order = col_lab, name = params$Main_plot$legend, column_names_rot = 45,
    row_dend_width = unit(3, "cm"), col=main_color, right_annotation = r_anno
)

######################################
print_color('Make heatmap processes\n', 'blue')
message('')
print_func(0)
message("create main plot: PASS")
print_func(0)
message("create side plot: PASS")
message('')

######################################
print_color('Export processes\n', 'blue')
message('')
print_func(0)
message("output: ", params$Output_dir, '/', params$Export$file_name, '.', params$Export$file_type)
print_func(0)
message("width: ", params$Export$width, ' px.')
print_func(0)
message("height: ", params$Export$height, ' px.')
print_func(0)
message("resolution: ", params$Export$resolution)
######################################
png(
    paste(params$Output_dir, '/', params$Export$file_name, '.', 
    params$Export$file_type, sep=''), width=params$Export$width, 
    height=params$Export$height, res=120
)
print(hm)
dev.off()