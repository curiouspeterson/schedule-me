import { NextResponse } from 'next/server';

export async function GET() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  return NextResponse.json({
    supabaseUrl: {
      value: supabaseUrl,
      length: supabaseUrl?.length,
      prefix: supabaseUrl?.substring(0, 10)
    },
    serviceRoleKey: {
      exists: !!serviceRoleKey,
      length: serviceRoleKey?.length,
      prefix: serviceRoleKey?.substring(0, 6),
      isBearer: serviceRoleKey?.startsWith('eyJ')
    },
    anonKey: {
      exists: !!anonKey,
      length: anonKey?.length,
      prefix: anonKey?.substring(0, 6),
      isBearer: anonKey?.startsWith('eyJ')
    }
  });
} 