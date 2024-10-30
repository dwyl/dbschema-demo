-- Fact Table: Account
CREATE TABLE fact_account (
    account_fact_id SERIAL PRIMARY KEY,
    account_id INT NOT NULL,
    customer_id INT NOT NULL,
    branch_id INT,
    product_id INT,
    balance DECIMAL(18, 2),
    open_date_id INT,
    close_date_id INT,
    FOREIGN KEY (account_id) REFERENCES dim_account(account_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (branch_id) REFERENCES dim_branch(branch_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (open_date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (close_date_id) REFERENCES dim_date(date_id)
);

-- Fact Table: Transaction
CREATE TABLE fact_transaction (
    transaction_fact_id SERIAL PRIMARY KEY,
    transaction_id INT NOT NULL,
    account_id INT NOT NULL,
    transaction_type_id INT,
    amount DECIMAL(18, 2),
    currency_id INT,
    transaction_date_id INT,
    location_id INT,
    employee_id INT,
    channel_id INT,
    FOREIGN KEY (transaction_type_id) REFERENCES dim_transaction_type(transaction_type_id),
    FOREIGN KEY (currency_id) REFERENCES dim_currency(currency_id),
    FOREIGN KEY (transaction_date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (location_id) REFERENCES dim_location(location_id),
    FOREIGN KEY (employee_id) REFERENCES dim_employee(employee_id),
    FOREIGN KEY (channel_id) REFERENCES dim_channel(channel_id)
);

-- Dimension Table: Account
CREATE TABLE dim_account (
    account_id SERIAL PRIMARY KEY,
    account_number VARCHAR(20) UNIQUE,
    account_type VARCHAR(50)
);

-- Dimension Table: Customer
CREATE TABLE dim_customer (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    gender CHAR(1),
    birth_date DATE,
    address VARCHAR(255),
    phone VARCHAR(15),
    email VARCHAR(100)
);

-- Dimension Table: Transaction Type
CREATE TABLE dim_transaction_type (
    transaction_type_id SERIAL PRIMARY KEY,
    transaction_type_name VARCHAR(50)
);

-- Dimension Table: Date
CREATE TABLE dim_date (
    date_id SERIAL PRIMARY KEY,
    full_date DATE UNIQUE,
    year INT,
    quarter INT,
    month INT,
    day INT,
    day_of_week INT,
    is_weekend BOOLEAN
);

-- Dimension Table: Currency
CREATE TABLE dim_currency (
    currency_id SERIAL PRIMARY KEY,
    currency_code CHAR(3),
    currency_name VARCHAR(50)
);

-- Dimension Table: Location
CREATE TABLE dim_location (
    location_id SERIAL PRIMARY KEY,
    country VARCHAR(50),
    state VARCHAR(50),
    city VARCHAR(50)
);

-- Dimension Table: Branch
CREATE TABLE dim_branch (
    branch_id SERIAL PRIMARY KEY,
    branch_name VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(15),
    manager_id INT
);

-- Dimension Table: Product
CREATE TABLE dim_product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    product_type VARCHAR(50),
    interest_rate DECIMAL(5, 2)
);

-- Dimension Table: Employee
CREATE TABLE dim_employee (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(50),
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES dim_branch(branch_id)
);

-- Dimension Table: Channel
CREATE TABLE dim_channel (
    channel_id SERIAL PRIMARY KEY,
    channel_name VARCHAR(50),
    description VARCHAR(255)
);

-- Adding `account_id` foreign key to `transaction_facts` to link with `account_facts`
ALTER TABLE fact_transaction
ADD CONSTRAINT fk_account_id FOREIGN KEY (account_id) REFERENCES fact_account(account_id);
