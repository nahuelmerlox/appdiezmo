-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create enum types for payment methods and contribution types
CREATE TYPE payment_method_type AS ENUM ('efectivo', 'transferencia', 'tarjeta');
CREATE TYPE contribution_type AS ENUM ('diezmo', 'siembra');

-- Create the tithes table
CREATE TABLE tithes (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),
    type contribution_type NOT NULL,
    payment_method payment_method_type NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Create an index on the created_at column for better query performance
CREATE INDEX idx_tithes_created_at ON tithes(created_at);

-- Create a trigger to automatically update the updated_at timestamp
CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_timestamp
    BEFORE UPDATE ON tithes
    FOR EACH ROW
    EXECUTE FUNCTION trigger_set_timestamp();

-- Set up Row Level Security (RLS)
ALTER TABLE tithes ENABLE ROW LEVEL SECURITY;

-- Create a policy that allows all operations for authenticated users
CREATE POLICY "Allow all operations for authenticated users" ON tithes
    FOR ALL
    TO authenticated
    USING (true)
    WITH CHECK (true);

-- Create a policy that allows only inserts for anonymous users
CREATE POLICY "Allow inserts for anonymous users" ON tithes
    FOR INSERT
    TO anon
    WITH CHECK (true);