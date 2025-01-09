/*
  # Create test users

  1. Changes
    - Add test users for each role (manager, pantry, delivery)
    
  2. Security
    - Users are created with secure passwords
    - Each user has appropriate role assigned
*/

-- Create manager user
INSERT INTO auth.users (id, email, encrypted_password, email_confirmed_at, created_at, updated_at)
VALUES (
  'e52e5fee-6d0d-4738-9a44-8c23d1b1c4ab'::uuid,
  'hospital_manager@xyz.com',
  crypt('Password@2025', gen_salt('bf')),
  now(),
  now(),
  now()
);

INSERT INTO public.users (id, email, role)
VALUES (
  'e52e5fee-6d0d-4738-9a44-8c23d1b1c4ab'::uuid,
  'hospital_manager@xyz.com',
  'manager'
);

-- Create pantry user
INSERT INTO auth.users (id, email, encrypted_password, email_confirmed_at, created_at, updated_at)
VALUES (
  'f62e5fee-7d0d-4738-9a44-8c23d1b1c4ac'::uuid,
  'hospital_pantry@xyz.com',
  crypt('Password@2025', gen_salt('bf')),
  now(),
  now(),
  now()
);

INSERT INTO public.users (id, email, role)
VALUES (
  'f62e5fee-7d0d-4738-9a44-8c23d1b1c4ac'::uuid,
  'hospital_pantry@xyz.com',
  'pantry'
);

-- Create delivery user
INSERT INTO auth.users (id, email, encrypted_password, email_confirmed_at, created_at, updated_at)
VALUES (
  '072e5fee-8d0d-4738-9a44-8c23d1b1c4ad'::uuid,
  'hospital_delivery@xyz.com',
  crypt('Password@2025', gen_salt('bf')),
  now(),
  now(),
  now()
);

INSERT INTO public.users (id, email, role)
VALUES (
  '072e5fee-8d0d-4738-9a44-8c23d1b1c4ad'::uuid,
  'hospital_delivery@xyz.com',
  'delivery'
);