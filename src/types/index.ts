export interface User {
  id: string;
  email: string;
  role: 'manager' | 'pantry' | 'delivery';
  created_at: string;
}

export interface Patient {
  id: string;
  name: string;
  room_number: string;
  bed_number: string;
  floor_number: string;
  age: number;
  gender: string;
  diseases: string[];
  allergies: string[];
  contact_number: string;
  emergency_contact: string;
  created_at: string;
  updated_at: string;
}

export interface DietChart {
  id: string;
  patient_id: string;
  meal_type: 'morning' | 'evening' | 'night';
  ingredients: string[];
  instructions: string[];
  created_at: string;
  updated_at: string;
}

export interface PantryStaff {
  id: string;
  user_id: string;
  name: string;
  contact_number: string;
  location: string;
  created_at: string;
}

export interface MealDelivery {
  id: string;
  diet_chart_id: string;
  delivery_staff_id: string;
  status: 'preparing' | 'ready' | 'delivering' | 'delivered';
  delivered_at: string | null;
  notes: string | null;
  created_at: string;
  updated_at: string;
}