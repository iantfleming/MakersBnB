CREATE TABLE listings(id SERIAL PRIMARY KEY, name TEXT NOT NULL, price NUMERIC DEFAULT 0, description TEXT NOT NULL, date date, available_from date, available_to date);
