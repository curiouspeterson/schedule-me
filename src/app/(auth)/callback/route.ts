import { createClient } from '@/lib/supabase/server'
import { cookies } from 'next/headers'
import { NextResponse } from 'next/server'

export async function GET(request: Request) {
  const requestUrl = new URL(request.url)
  const code = requestUrl.searchParams.get('code')

  if (code) {
    const cookieStore = cookies()
    const supabase = createClient(cookieStore)

    try {
      const { data: { user }, error: authError } = await supabase.auth.exchangeCodeForSession(code)
      
      if (authError) {
        console.error('Auth error:', authError)
        throw authError
      }

      if (user) {
        // Check if profile exists
        const { data: profile, error: profileError } = await supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single()

        if (profileError && profileError.code !== 'PGRST116') { // PGRST116 is "no rows returned"
          console.error('Error fetching profile:', profileError)
          throw profileError
        }

        // Create profile if it doesn't exist
        if (!profile) {
          console.log('Creating new profile for user:', user.id)
          const { error: insertError } = await supabase
            .from('profiles')
            .insert({
              id: user.id,
              full_name: user.user_metadata.full_name || '',
              avatar_url: user.user_metadata.avatar_url || null,
              role: 'employee',
              weekly_hours_limit: 40
            })

          if (insertError) {
            console.error('Error creating profile:', insertError)
            throw insertError
          }
        }
      }

      // Redirect to the dashboard
      return NextResponse.redirect(`${requestUrl.origin}/dashboard`)
    } catch (error) {
      console.error('Auth callback error:', error)
      // Redirect to error page or login with error
      return NextResponse.redirect(`${requestUrl.origin}/login?error=Unable to sign in`)
    }
  }

  // No code present, redirect to login
  return NextResponse.redirect(`${requestUrl.origin}/login?error=No authorization code`)
} 