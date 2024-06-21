CREATE TYPE order_status AS ENUM ('PENDING', 'PAID', 'APPROVED', 'CANCELLED', 'CANCELLING');
CREATE TYPE saga_status AS ENUM ('STARTED', 'FAILED', 'SUCCEEDED', 'PROCESSING', 'COMPENSATING', 'COMPENSATED');
CREATE TYPE outbox_status AS ENUM ('STARTED', 'COMPLETED', 'FAILED');

CREATE TABLE orders
(
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    tracking_id uuid NOT NULL,
    price numeric(10,2) NOT NULL,
    order_status order_status NOT NULL,
    failure_messages character varying(1000),
    CONSTRAINT orders_pkey PRIMARY KEY (id)
);

CREATE TABLE order_items
(
    id bigint NOT NULL,
    order_id uuid NOT NULL,
    product_id uuid NOT NULL,
    price numeric(10,2) NOT NULL,
    quantity integer NOT NULL,
    sub_total numeric(10,2) NOT NULL,
    CONSTRAINT order_items_pkey PRIMARY KEY (id, order_id),
    FOREIGN KEY(order_id) REFERENCES orders
);

CREATE TABLE users
(
    id uuid NOT NULL,
    username character(255) NOT NULL,
    first_name character(255) NOT NULL,
    last_name character(255) NOT NULL,
    user_type INTEGER NOT NULL,
    CONSTRAINT customers_pkey PRIMARY KEY (id)
);

CREATE TABLE payment_outbox
(
    id uuid NOT NULL,
    saga_id uuid NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    processed_at TIMESTAMP WITH TIME ZONE,
    type character(255),
    payload json NOT NULL,
    outbox_status outbox_status NOT NULL,
    saga_status saga_status NOT NULL,
    order_status order_status NOT NULL,
    version integer NOT NULL,
    CONSTRAINT payment_outbox_pkey PRIMARY KEY (id)
);

INSERT INTO orders
VALUES ('cb3924d4-bdcb-4fe3-9a65-a3be77e34358', '8eedaf01-872d-46e8-89e0-fa0610971ac4', 'e1a90a82-ce20-4e87-8b7f-92e6037de8d3', 2000, 'APPROVED', 'ok');
INSERT INTO orders
VALUES ('90ea8763-1967-4a81-9e70-04e1e76eb194', '414fbddd-efcb-4d7f-b747-1af780841538', '414fbddd-efcb-4d7f-b747-1af780841538', 100, 'PAID', 'ok');

