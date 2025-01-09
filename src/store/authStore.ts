import { create } from 'zustand';
import { User } from '../types';
import { supabase } from '../lib/supabase';

interface AuthState {
  user: User | null;
  loading: boolean;
  signIn: (email: string, password: string) => Promise<void>;
  signOut: () => Promise<void>;
  initialize: () => Promise<void>;
}

// Temporary development user
const devUser: User = {
  id: 'e52e5fee-6d0d-4738-9a44-8c23d1b1c4ab',
  email: 'hospital_manager@xyz.com',
  role: 'manager',
  created_at: new Date().toISOString()
};

export const useAuthStore = create<AuthState>((set) => ({
  user: devUser, // Set development user directly
  loading: false, // No loading needed for dev
  signIn: async (email: string, password: string) => {
    // In development, always "succeed" and set the dev user
    set({ user: devUser });
  },
  signOut: async () => {
    set({ user: null });
  },
  initialize: async () => {
    // In development, always set the dev user
    set({ user: devUser, loading: false });
  }
}));