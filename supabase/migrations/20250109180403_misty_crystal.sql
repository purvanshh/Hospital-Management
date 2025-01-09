-- Create manager user
INSERT INTO auth.users (
  instance_id,
  id,
  aud,
  role,
  email,
  encrypted_password,
  email_confirmed_at,
  created_at,
  updated_at
) VALUES (
  '00000000-0000-0000-0000-000000000000',
  'e52e5fee-6d0d-4738-9a44-8c23d1b1c4ab',
  'authenticated',
  'authenticated',
  'hospital_manager@xyz.com',
  crypt('Password@2025', gen_salt('bf')),
  now(),
  now(),
  now()
);

INSERT INTO public.users (id, email, role)
VALUES (
  'e52e5fee-6d0d-4738-9a44-8c23d1b1c4ab',
  'hospital_manager@xyz.com',
  'manager'
);

-- Create pantry user
INSERT INTO auth.users (
  instance_id,
  id,
  aud,
  role,
  email,
  encrypted_password,
  email_confirmed_at,
  created_at,
  updated_at
) VALUES (
  '00000000-0000-0000-0000-000000000000',
  'f62e5fee-7d0d-4738-9a44-8c23d1b1c4ac',
  'authenticated',
  'authenticated',
  'hospital_pantry@xyz.com',
  crypt('Password@2025', gen_salt('bf')),
  now(),
  now(),
  now()
);

INSERT INTO public.users (id, email, role)
VALUES (
  'f62e5fee-7d0d-4738-9a44-8c23d1b1c4ac',
  'hospital_pantry@xyz.com',
  'pantry'
);

-- Create delivery user
INSERT INTO auth.users (
  instance_id,
  id,
  aud,
  role,
  email,
  encrypted_password,
  email_confirmed_at,
  created_at,
  updated_at
) VALUES (
  '00000000-0000-0000-0000-000000000000',
  '072e5fee-8d0d-4738-9a44-8c23d1b1c4ad',
  'authenticated',
  'authenticated',
  'hospital_delivery@xyz.com',
  crypt('Password@2025', gen_salt('bf')),
  now(),
  now(),
  now()
);