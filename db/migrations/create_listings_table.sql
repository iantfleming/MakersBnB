CREATE TABLE listings(id SERIAL PRIMARY KEY, name TEXT NOT NULL, price NUMERIC DEFAULT 0, description TEXT NOT NULL, date text, available_from text, available_to text);
