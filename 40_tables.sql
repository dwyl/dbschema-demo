-- Fact Table 1 and its Dimension Tables
CREATE TABLE fact_table_1 (
    fact_id INT PRIMARY KEY,
    measure_1 DECIMAL(10, 2),
    measure_2 DECIMAL(10, 2),
    -- Add more columns as needed
    d1_id INT,
    d2_id INT,
    d3_id INT,
    d4_id INT,
    d5_id INT,
    d6_id INT,
    d7_id INT,
    d8_id INT,
    d9_id INT,
    d10_id INT,
    FOREIGN KEY (d1_id) REFERENCES dim_table_1 (dim_id),
    FOREIGN KEY (d2_id) REFERENCES dim_table_2 (dim_id),
    FOREIGN KEY (d3_id) REFERENCES dim_table_3 (dim_id),
    FOREIGN KEY (d4_id) REFERENCES dim_table_4 (dim_id),
    FOREIGN KEY (d5_id) REFERENCES dim_table_5 (dim_id),
    FOREIGN KEY (d6_id) REFERENCES dim_table_6 (dim_id),
    FOREIGN KEY (d7_id) REFERENCES dim_table_7 (dim_id),
    FOREIGN KEY (d8_id) REFERENCES dim_table_8 (dim_id),
    FOREIGN KEY (d9_id) REFERENCES dim_table_9 (dim_id),
    FOREIGN KEY (d10_id) REFERENCES dim_table_10 (dim_id)
);

CREATE TABLE dim_table_1 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_2 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_3 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_4 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_5 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_6 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_7 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_8 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_9 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_10 (dim_id INT PRIMARY KEY, name VARCHAR(50));

-- Fact Table 2 and its Dimension Tables
CREATE TABLE fact_table_2 (
    fact_id INT PRIMARY KEY,
    measure_1 DECIMAL(10, 2),
    measure_2 DECIMAL(10, 2),
    -- Add more columns as needed
    d11_id INT,
    d12_id INT,
    d13_id INT,
    d14_id INT,
    d15_id INT,
    d16_id INT,
    d17_id INT,
    d18_id INT,
    d19_id INT,
    d20_id INT,
    FOREIGN KEY (d11_id) REFERENCES dim_table_11 (dim_id),
    FOREIGN KEY (d12_id) REFERENCES dim_table_12 (dim_id),
    FOREIGN KEY (d13_id) REFERENCES dim_table_13 (dim_id),
    FOREIGN KEY (d14_id) REFERENCES dim_table_14 (dim_id),
    FOREIGN KEY (d15_id) REFERENCES dim_table_15 (dim_id),
    FOREIGN KEY (d16_id) REFERENCES dim_table_16 (dim_id),
    FOREIGN KEY (d17_id) REFERENCES dim_table_17 (dim_id),
    FOREIGN KEY (d18_id) REFERENCES dim_table_18 (dim_id),
    FOREIGN KEY (d19_id) REFERENCES dim_table_19 (dim_id),
    FOREIGN KEY (d20_id) REFERENCES dim_table_20 (dim_id)
);

CREATE TABLE dim_table_11 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_12 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_13 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_14 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_15 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_16 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_17 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_18 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_19 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_20 (dim_id INT PRIMARY KEY, name VARCHAR(50));

-- Fact Table 3 and its Dimension Tables
CREATE TABLE fact_table_3 (
    fact_id INT PRIMARY KEY,
    measure_1 DECIMAL(10, 2),
    measure_2 DECIMAL(10, 2),
    -- Add more columns as needed
    d21_id INT,
    d22_id INT,
    d23_id INT,
    d24_id INT,
    d25_id INT,
    d26_id INT,
    d27_id INT,
    d28_id INT,
    d29_id INT,
    d30_id INT,
    FOREIGN KEY (d21_id) REFERENCES dim_table_21 (dim_id),
    FOREIGN KEY (d22_id) REFERENCES dim_table_22 (dim_id),
    FOREIGN KEY (d23_id) REFERENCES dim_table_23 (dim_id),
    FOREIGN KEY (d24_id) REFERENCES dim_table_24 (dim_id),
    FOREIGN KEY (d25_id) REFERENCES dim_table_25 (dim_id),
    FOREIGN KEY (d26_id) REFERENCES dim_table_26 (dim_id),
    FOREIGN KEY (d27_id) REFERENCES dim_table_27 (dim_id),
    FOREIGN KEY (d28_id) REFERENCES dim_table_28 (dim_id),
    FOREIGN KEY (d29_id) REFERENCES dim_table_29 (dim_id),
    FOREIGN KEY (d30_id) REFERENCES dim_table_30 (dim_id)
);

CREATE TABLE dim_table_21 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_22 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_23 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_24 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_25 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_26 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_27 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_28 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_29 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_30 (dim_id INT PRIMARY KEY, name VARCHAR(50));

-- Fact Table 4 and its Dimension Tables
CREATE TABLE fact_table_4 (
    fact_id INT PRIMARY KEY,
    measure_1 DECIMAL(10, 2),
    measure_2 DECIMAL(10, 2),
    -- Add more columns as needed
    d31_id INT,
    d32_id INT,
    d33_id INT,
    d34_id INT,
    d35_id INT,
    d36_id INT,
    d37_id INT,
    d38_id INT,
    d39_id INT,
    d40_id INT,
    FOREIGN KEY (d31_id) REFERENCES dim_table_31 (dim_id),
    FOREIGN KEY (d32_id) REFERENCES dim_table_32 (dim_id),
    FOREIGN KEY (d33_id) REFERENCES dim_table_33 (dim_id),
    FOREIGN KEY (d34_id) REFERENCES dim_table_34 (dim_id),
    FOREIGN KEY (d35_id) REFERENCES dim_table_35 (dim_id),
    FOREIGN KEY (d36_id) REFERENCES dim_table_36 (dim_id),
    FOREIGN KEY (d37_id) REFERENCES dim_table_37 (dim_id),
    FOREIGN KEY (d38_id) REFERENCES dim_table_38 (dim_id),
    FOREIGN KEY (d39_id) REFERENCES dim_table_39 (dim_id),
    FOREIGN KEY (d40_id) REFERENCES dim_table_40 (dim_id)
);

CREATE TABLE dim_table_31 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_32 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_33 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_34 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_35 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_36 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_37 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_38 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_39 (dim_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE dim_table_40 (dim_id INT PRIMARY KEY, name VARCHAR(50));
