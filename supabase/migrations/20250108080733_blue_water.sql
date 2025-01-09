/*
  # Initial Hospital Food Management Schema

  1. New Tables
    - users
      - id (uuid, primary key)
      - email (text, unique)
      - role (text)
      - created_at (timestamp)
    
    - patients
      - id (uuid, primary key)
      - name (text)
      - room_number (text)
      - bed_number (text)
      - floor_number (text)
      - age (integer)
      - gender (text)
      - diseases (text[])
      - allergies (text[])
      - contact_number (text)
      - emergency_contact (text)
      - created_at (timestamp)
      - updated_at (timestamp)
    
    - diet_charts
      - id (uuid, primary key)
      - patient_id (uuid, foreign key)
      - meal_type (text)
      - ingredients (text[])
      - instructions (text[])
      - created_at (timestamp)
      - updated_at (timestamp)
    
    - pantry_staff
      - id (uuid, primary key)
      - user_id (uuid, foreign key)
      - name (text)
      - contact_number (text)
      - location (text)
      - created_at (timestamp)
    
    - meal_deliveries
      - id (uuid, primary key)
      - diet_chart_id (uuid, foreign key)
      - delivery_staff_id (uuid, foreign key)
      - status (text)
      - delivered_at (timestamp)
      - notes (text)
      - created_at (timestamp)
      - updated_at (timestamp)

  2. Security
    - Enable RLS on all tables
    - Add policies for role-based access
*/

-- Users table
CREATE TABLE users (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email text UNIQUE NOT NULL,
  role text NOT NULL CHECK (role IN ('manager', 'pantry', 'delivery')),
  created_at timestamptz DEFAULT now()
);

-- Patients table
CREATE TABLE patients (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  room_number text NOT NULL,
  bed_number text NOT NULL,
  floor_number text NOT NULL,
  age integer NOT NULL,
  gender text NOT NULL,
  diseases text[] DEFAULT '{}',
  allergies text[] DEFAULT '{}',
  contact_number text,
  emergency_contact text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Diet Charts table
CREATE TABLE diet_charts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id uuid REFERENCES patients(id) ON DELETE CASCADE,
  meal_type text NOT NULL CHECK (meal_type IN ('morning', 'evening', 'night')),
  ingredients text[] DEFAULT '{}',
  instructions text[] DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Pantry Staff table
CREATE TABLE pantry_staff (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES users(id) ON DELETE CASCADE,
  name text NOT NULL,
  contact_number text,
  location text,
  created_at timestamptz DEFAULT now()
);

-- Meal Deliveries table
CREATE TABLE meal_deliveries (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  diet_chart_id uuid REFERENCES diet_charts(id) ON DELETE CASCADE,
  delivery_staff_id uuid REFERENCES users(id),
  status text NOT NULL CHECK (status IN ('preparing', 'ready', 'delivering', 'delivered')),
  delivered_at timestamptz,
  notes text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE patients ENABLE ROW LEVEL SECURITY;
ALTER TABLE diet_charts ENABLE ROW LEVEL SECURITY;
ALTER TABLE pantry_staff ENABLE ROW LEVEL SECURITY;
ALTER TABLE meal_deliveries ENABLE ROW LEVEL SECURITY;

-- RLS Policies
CREATE POLICY "Users can view their own data"
  ON users
  FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Managers can view all patients"
  ON patients
  FOR ALL
  USING (EXISTS (
    SELECT 1 FROM users 
    WHERE users.id = auth.uid() 
    AND users.role = 'manager'
  ));

CREATE POLICY "Pantry staff can view patients"
  ON patients
  FOR SELECT
  USING (EXISTS (
    SELECT 1 FROM users 
    WHERE users.id = auth.uid() 
    AND users.role = 'pantry'
  ));

CREATE POLICY "Managers can manage diet charts"
  ON diet_charts
  FOR ALL
  USING (EXISTS (
    SELECT 1 FROM users 
    WHERE users.id = auth.uid() 
    AND users.role = 'manager'
  ));

CREATE POLICY "Pantry staff can view diet charts"
  ON diet_charts
  FOR SELECT
  USING (EXISTS (
    SELECT 1 FROM users 
    WHERE users.id = auth.uid() 
    AND users.role = 'pantry'
  ));

CREATE POLICY "Managers can manage pantry staff"
  ON pantry_staff
  FOR ALL
  USING (EXISTS (
    SELECT 1 FROM users 
    WHERE users.id = auth.uid() 
    AND users.role = 'manager'
  ));

CREATE POLICY "All authenticated users can view meal deliveries"
  ON meal_deliveries
  FOR SELECT
  USING (auth.role() = 'authenticated');

CREATE POLICY "Pantry staff can update meal deliveries"
  ON meal_deliveries
  FOR UPDATE
  USING (EXISTS (
    SELECT 1 FROM users 
    WHERE users.id = auth.uid() 
    AND users.role = 'pantry'
  ));