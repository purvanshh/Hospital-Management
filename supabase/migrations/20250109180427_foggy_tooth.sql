/*
  # Create initial users

  1. Changes
    - Creates manager, pantry, and delivery users if they don't exist
    - Uses DO blocks to safely handle user creation
    - Ensures no duplicate entries
*/

DO $$ 
BEGIN
  -- Create manager user if not exists
  IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'hospital_manager@xyz.com') THEN
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
  END IF;

  -- Create manager public user if not exists
  IF NOT EXISTS (SELECT 1 FROM public.users WHERE email = 'hospital_manager@xyz.com') THEN
    INSERT INTO public.users (id, email, role)
    VALUES (
      'e52e5fee-6d0d-4738-9a44-8c23d1b1c4ab',
      'hospital_manager@xyz.com',
      'manager'
    );
  END IF;

  -- Create pantry user if not exists
  IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'hospital_pantry@xyz.com') THEN
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
  END IF;

  -- Create pantry public user if not exists
  IF NOT EXISTS (SELECT 1 FROM public.users WHERE email = 'hospital_pantry@xyz.com') THEN
    INSERT INTO public.users (id, email, role)
    VALUES (
      'f62e5fee-7d0d-4738-9a44-8c23d1b1c4ac',
      'hospital_pantry@xyz.com',
      'pantry'
    );
  END IF;

  -- Create delivery user if not exists
  IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'hospital_delivery@xyz.com') THEN
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
  END IF;

  -- Create delivery public user if not exists
  IF NOT EXISTS (SELECT 1 FROM public.users WHERE email = 'hospital_delivery@xyz.com') THEN
    INSERT INTO public.users (id, email, role)
    VALUES (
      '072e5fee-8d0d-4738-9a44-8c23d1b1c4ad',
      'hospital_delivery@xyz.com',
      'delivery'
    );
  END IF;
END $$;