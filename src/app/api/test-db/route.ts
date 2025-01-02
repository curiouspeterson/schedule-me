import { createClient } from '@supabase/supabase-js';
import { NextResponse } from 'next/server';

export async function GET() {
  try {
    console.log('Testing database connection...');
    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

    if (!supabaseUrl || !serviceRoleKey) {
      console.error('Missing environment variables');
      return NextResponse.json({ error: 'Missing environment variables' });
    }

    console.log('Supabase URL:', supabaseUrl);
    console.log('Service Role Key prefix:', serviceRoleKey.substring(0, 6));

    const supabase = createClient(supabaseUrl, serviceRoleKey);

    // Test roles table first
    console.log('Testing roles table...');
    const { data: roles, error: rolesError } = await supabase
      .from('roles')
      .select('*');

    if (rolesError) {
      console.error('Roles query failed:', rolesError);
      return NextResponse.json({ error: 'Roles query failed', details: rolesError });
    }

    console.log('Roles query successful:', roles);

    // Test profiles table
    console.log('Testing profiles table...');
    const { data: profiles, error: profilesError } = await supabase
      .from('profiles')
      .select('*')
      .limit(1);

    if (profilesError) {
      console.error('Profiles query failed:', profilesError);
      return NextResponse.json({ error: 'Profiles query failed', details: profilesError });
    }

    return NextResponse.json({
      success: true,
      roles,
      profiles
    });
  } catch (error) {
    console.error('Test failed:', error);
    return NextResponse.json({ error: 'Test failed', details: error });
  }
} 