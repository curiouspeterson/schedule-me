import { createClient } from '@/lib/supabase/server'
import { cookies } from 'next/headers'
import { DashboardContent } from '@/components/dashboard/DashboardContent'
import { redirect } from 'next/navigation'

export default async function DashboardPage() {
  const cookieStore = cookies()
  const supabase = createClient(cookieStore)

  // Get current user and their profile
  const { data: { user }, error: userError } = await supabase.auth.getUser()
  
  if (userError) {
    console.error('Error fetching user:', userError)
    return redirect('/login')
  }

  if (!user) {
    console.log('No user found, redirecting to login')
    return redirect('/login')
  }

  // Fetch profile with error handling
  let { data: profile, error: profileError } = await supabase
    .from('profiles')
    .select(`
      *,
      roles:role_id (
        name
      )
    `)
    .eq('id', user.id)
    .single()

  if (profileError) {
    console.error('Error fetching profile:', profileError)
    // If no profile exists, we should create one
    if (profileError.code === 'PGRST116') {
      console.log('Creating new profile for user:', user.id)
      const { data: newProfile, error: createError } = await supabase
        .from('profiles')
        .insert({
          id: user.id,
          first_name: user.user_metadata?.full_name?.split(' ')[0] || user.email?.split('@')[0],
          last_name: user.user_metadata?.full_name?.split(' ').slice(1).join(' ') || '',
          role_id: 1, // Default to employee role
          weekly_hours_limit: 40,
        })
        .select(`
          *,
          roles:role_id (
            name
          )
        `)
        .single()

      if (createError) {
        console.error('Error creating profile:', createError)
        throw createError
      }

      profile = newProfile
    } else {
      return redirect('/login')
    }
  }

  return (
    <div className="container mx-auto py-6">
      <DashboardContent
        user={user}
        isManager={profile?.roles?.name === 'manager'}
      />
    </div>
  )
} 