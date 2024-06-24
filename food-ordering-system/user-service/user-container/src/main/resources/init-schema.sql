
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE customers
(
    id uuid NOT NULL,
    username character(255) NOT NULL,
    first_name character(255) NOT NULL,
    last_name character(255) NOT NULL,
    user_type INTEGER DEFAULT 0,
    CONSTRAINT customers_pkey PRIMARY KEY (id)
);