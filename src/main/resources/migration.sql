-- customers table
CREATE TABLE IF NOT EXISTS customers (
    id VARCHAR(20) PRIMARY KEY,
    role VARCHAR(20) NOT NULL,
    status VARCHAR(30) NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    password_hash VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP
);

-- accounts table
CREATE TABLE IF NOT EXISTS accounts (
    id VARCHAR(20) PRIMARY KEY,
    owner_id VARCHAR(20) NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    currency VARCHAR(3) NOT NULL,
    balance DECIMAL(19,2) NOT NULL DEFAULT 0.00,
    status VARCHAR(30) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP
);

-- transactions table
CREATE TABLE IF NOT EXISTS transactions (
    id VARCHAR(20) PRIMARY KEY,
    currency VARCHAR(3) NOT NULL,
    amount DECIMAL(19,2) NOT NULL,
    source_account VARCHAR(20) NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
    target_account VARCHAR(20) NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
    type VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    completed_at TIMESTAMP,
    return_reason TEXT,
    reject_reason TEXT
);

-- tokens table (optional – if you want to persist tokens, otherwise keep in-memory)
CREATE TABLE IF NOT EXISTS tokens (
    value VARCHAR(128) PRIMARY KEY,
    expiry TIMESTAMP NOT NULL,
    customer_id VARCHAR(20) NOT NULL REFERENCES customers(id) ON DELETE CASCADE
);