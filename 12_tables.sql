-- Dimension Tables
CREATE TABLE dim_table_1 (
    dim_id INT PRIMARY KEY,
    attribute_1 VARCHAR(50),
    attribute_2 VARCHAR(50),
    attribute_3 VARCHAR(50),
    attribute_4 VARCHAR(50),
    attribute_5 VARCHAR(50),
    attribute_6 VARCHAR(50),
    attribute_7 VARCHAR(50)
);

CREATE TABLE dim_table_2 (
    dim_id INT PRIMARY KEY,
    attribute_1 VARCHAR(50),
    attribute_2 VARCHAR(50),
    attribute_3 VARCHAR(50),
    attribute_4 VARCHAR(50),
    attribute_5 VARCHAR(50),
    attribute_6 VARCHAR(50),
    attribute_7 VARCHAR(50)
);

CREATE TABLE dim_table_3 (
    dim_id INT PRIMARY KEY,
    attribute_1 VARCHAR(50),
    attribute_2 VARCHAR(50),
    attribute_3 VARCHAR(50),
    attribute_4 VARCHAR(50),
    attribute_5 VARCHAR(50),
    attribute_6 VARCHAR(50),
    attribute_7 VARCHAR(50)
);

CREATE TABLE dim_table_4 (
    dim_id INT PRIMARY KEY,
    attribute_1 VARCHAR(50),
    attribute_2 VARCHAR(50),
    attribute_3 VARCHAR(50),
    attribute_4 VARCHAR(50),
    attribute_5 VARCHAR(50),
    attribute_6 VARCHAR(50),
    attribute_7 VARCHAR(50)
);

CREATE TABLE dim_table_5 (
    dim_id INT PRIMARY KEY,
    attribute_1 VARCHAR(50),
    attribute_2 VARCHAR(50),
    attribute_3 VARCHAR(50),
    attribute_4 VARCHAR(50),
    attribute_5 VARCHAR(50),
    attribute_6 VARCHAR(50),
    attribute_7 VARCHAR(50)
);

CREATE TABLE dim_table_6 (
    dim_id INT PRIMARY KEY,
    attribute_1 VARCHAR(50),
    attribute_2 VARCHAR(50),
    attribute_3 VARCHAR(50),
    attribute_4 VARCHAR(50),
    attribute_5 VARCHAR(50),
    attribute_6 VARCHAR(50),
    attribute_7 VARCHAR(50)
);

-- Fact Tables
CREATE TABLE fact_table_1 (
    fact_id INT PRIMARY KEY,
    measure_1 DECIMAL(10, 2),
    measure_2 DECIMAL(10, 2),
    measure_3 DECIMAL(10, 2),
    measure_4 DECIMAL(10, 2),
    measure_5 DECIMAL(10, 2),
    measure_6 DECIMAL(10, 2),
    measure_7 DECIMAL(10, 2),
    d1_id INT,
    d2_id INT,
    d3_id INT,
    FOREIGN KEY (d1_id) REFERENCES dim_table_1 (dim_id),
    FOREIGN KEY (d2_id) REFERENCES dim_table_2 (dim_id),
    FOREIGN KEY (d3_id) REFERENCES dim_table_3 (dim_id)
);

CREATE TABLE fact_table_2 (
    fact_id INT PRIMARY KEY,
    measure_1 DECIMAL(10, 2),
    measure_2 DECIMAL(10, 2),
    measure_3 DECIMAL(10, 2),
    measure_4 DECIMAL(10, 2),
    measure_5 DECIMAL(10, 2),
    measure_6 DECIMAL(10, 2),
    measure_7 DECIMAL(10, 2),
    d4_id INT,
    d5_id INT,
    d6_id INT,
    FOREIGN KEY (d4_id) REFERENCES dim_table_4 (dim_id),
    FOREIGN KEY (d5_id) REFERENCES dim_table_5 (dim_id),
    FOREIGN KEY (d6_id) REFERENCES dim_table_6 (dim_id)
);

CREATE TABLE fact_table_3 (
    fact_id INT PRIMARY KEY,
    measure_1 DECIMAL(10, 2),
    measure_2 DECIMAL(10, 2),
    measure_3 DECIMAL(10, 2),
    measure_4 DECIMAL(10, 2),
    measure_5 DECIMAL(10, 2),
    measure_6 DECIMAL(10, 2),
    measure_7 DECIMAL(10, 2),
    d1_id INT,
    d4_id INT,
    d5_id INT,
    FOREIGN KEY (d1_id) REFERENCES dim_table_1 (dim_id),
    FOREIGN KEY (d4_id) REFERENCES dim_table_4 (dim_id),
    FOREIGN KEY (d5_id) REFERENCES dim_table_5 (dim_id)
);
