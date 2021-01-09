CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    listing_id int4,
    guest_email text,
    host_email text,
    status text,
    dates_from text,
    dates_to texts
);