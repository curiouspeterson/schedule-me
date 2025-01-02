'use client'

import { createClient } from '@/lib/supabase/client'
import { DashboardLayout } from '@/components/layouts/DashboardLayout'
import { useEffect, useState } from 'react'
import { useRouter, usePathname } from 'next/navigation'

const PUBLIC_PATHS = ['/login', '/signup', '/auth/callback']

export default function AuthLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const [isLoading, setIsLoading] = useState(true)
  const supabase = createClient()
  const router = useRouter()
  const pathname = usePathname()

  useEffect(() => {
    const checkUser = async () => {
      try {
        console.log('Checking user session in auth layout')
        const { data: { user }, error } = await supabase.auth.getUser()
        
        if (error) {
          console.error('Error checking user:', error)
          return
        }

        console.log('Auth check result:', { 
          hasUser: !!user, 
          pathname,
          isPublicPath: PUBLIC_PATHS.includes(pathname)
        })

        // Only redirect if we're on a protected path and there's no user
        if (!PUBLIC_PATHS.includes(pathname) && !user) {
          console.log('No user found on protected path, redirecting to login')
          router.replace('/login')
        }
      } catch (error) {
        console.error('Unexpected error in auth layout:', error)
      } finally {
        setIsLoading(false)
      }
    }

    checkUser()
  }, [supabase.auth, router, pathname])

  if (isLoading) {
    return (
      <div className="flex min-h-screen items-center justify-center">
        <div className="text-muted-foreground">Loading...</div>
      </div>
    )
  }

  // For public routes, render without dashboard layout
  if (PUBLIC_PATHS.includes(pathname)) {
    return children
  }

  // For protected routes, wrap with dashboard layout
  return <DashboardLayout>{children}</DashboardLayout>
} 