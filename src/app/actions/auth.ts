'use server'

import { createClient } from '@supabase/supabase-js'

if (!process.env.NEXT_PUBLIC_SUPABASE_URL || !process.env.SUPABASE_SERVICE_ROLE_KEY) {
  throw new Error('Missing Supabase environment variables')
}

const supabaseAdmin = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY,
  {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  }
)

export async function createUserProfile(userId: string, fullName: string) {
  try {
    console.log('=== Starting createUserProfile server action ===');
    console.log('Input params:', { userId, fullName });

    // First check if profile already exists
    const { data: existingProfile, error: fetchError } = await supabaseAdmin
      .from('profiles')
      .select('id')
      .eq('id', userId)
      .single();

    if (fetchError && fetchError.code !== 'PGRST116') { // PGRST116 means no rows returned
      console.error('Error checking existing profile:', fetchError);
      return { success: false, error: fetchError };
    }
    
    if (existingProfile) {
      console.log('Profile already exists for user:', userId);
      return { success: true };
    }

    // Get the employee role ID
    const { data: roleData, error: roleError } = await supabaseAdmin
      .from('roles')
      .select('id')
      .eq('name', 'employee')
      .single();

    if (roleError) {
      console.error('Error fetching employee role:', roleError);
      return { success: false, error: roleError };
    }

    if (!roleData) {
      console.error('Employee role not found');
      return { success: false, error: 'Employee role not found' };
    }

    const firstName = fullName.split(' ')[0];
    const lastName = fullName.split(' ').slice(1).join(' ');

    // Create new profile
    const { error: insertError } = await supabaseAdmin
      .from('profiles')
      .insert({
        id: userId,
        first_name: firstName,
        last_name: lastName || null,
        role_id: roleData.id,
        weekly_hours_limit: 40,
      });

    if (insertError) {
      console.error('Error creating profile:', insertError);
      return { success: false, error: insertError };
    }

    console.log('Profile created successfully');
    return { success: true };
  } catch (error) {
    console.error('Caught error in createUserProfile:', error);
    return { success: false, error };
  }
} 