import { createClient } from '@/lib/supabase/server'
import { cookies } from 'next/headers'
import { redirect } from 'next/navigation'
import { EmployeeList } from '@/components/employees/EmployeeList'

export default async function EmployeesPage() {
  const cookieStore = cookies()
  const supabase = createClient(cookieStore)
  
  const { data: { user }, error: userError } = await supabase.auth.getUser()
  if (userError || !user) {
    redirect('/login')
  }

  // Get user profile to check if they're a manager
  const { data: profile, error: profileError } = await supabase
    .from('profiles')
    .select(`
      *,
      roles:role_id (
        name
      )
    `)
    .eq('id', user.id)
    .single()

  if (profileError || !profile || profile.roles.name !== 'manager') {
    redirect('/dashboard')
  }

  return (
    <div className="container mx-auto py-6">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">Employees</h1>
      </div>
      <EmployeeList />
    </div>
  )
} 