'use client'

import { MainNav } from '@/components/navigation/MainNav'
import { UserNav } from '@/components/navigation/UserNav'
import { useQuery } from '@tanstack/react-query'
import { createClient } from '@/lib/supabase/client'
import { useRouter } from 'next/navigation'
import { useEffect } from 'react'

export function DashboardLayout({ children }: { children: React.ReactNode }) {
  const supabase = createClient()
  const router = useRouter()

  // First check if user is authenticated
  useEffect(() => {
    const checkAuth = async () => {
      const { data: { user }, error } = await supabase.auth.getUser()
      if (error || !user) {
        console.error('Auth error in DashboardLayout:', error)
        router.replace('/login')
      }
    }
    checkAuth()
  }, [supabase.auth, router])

  const { data: profile, isLoading, error } = useQuery({
    queryKey: ['profile'],
    queryFn: async () => {
      try {
        const { data: { user } } = await supabase.auth.getUser()
        if (!user) {
          throw new Error('No user found')
        }

        const { data, error } = await supabase
          .from('profiles')
          .select('*')
          .eq('id', user.id)
          .single()

        if (error) {
          console.error('Error fetching profile:', error)
          throw error
        }

        return data
      } catch (error) {
        console.error('Error in profile query:', error)
        throw error
      }
    },
    retry: 1,
    staleTime: 1000 * 60 * 5, // 5 minutes
  })

  if (error) {
    console.error('Profile query error:', error)
    return (
      <div className="flex min-h-screen items-center justify-center">
        <p className="text-lg text-red-500">Error loading profile. Please try refreshing.</p>
      </div>
    )
  }

  if (isLoading) {
    return (
      <div className="flex min-h-screen items-center justify-center">
        <p className="text-lg text-muted-foreground">Loading profile...</p>
      </div>
    )
  }

  if (!profile) {
    return (
      <div className="flex min-h-screen items-center justify-center">
        <p className="text-lg text-muted-foreground">Setting up your profile...</p>
      </div>
    )
  }

  return (
    <div className="flex min-h-screen flex-col">
      <div className="border-b">
        <div className="flex h-16 items-center px-4">
          <MainNav isManager={profile?.role === 'manager'} />
          <div className="ml-auto flex items-center space-x-4">
            <UserNav />
          </div>
        </div>
      </div>
      <main className="flex-1">{children}</main>
    </div>
  )
} 