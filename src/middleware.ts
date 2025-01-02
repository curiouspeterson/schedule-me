import { createServerClient, type CookieOptions } from '@supabase/ssr'
import { NextResponse, type NextRequest } from 'next/server'

// Define protected routes that require authentication
const protectedRoutes = ['/dashboard', '/schedule', '/availability', '/timeoff', '/employees']

// Define public routes that should bypass authentication
const publicRoutes = ['/login', '/signup', '/auth/callback']

export async function middleware(request: NextRequest) {
  console.log('Middleware executing for path:', request.nextUrl.pathname)
  
  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        get(name: string) {
          return request.cookies.get(name)?.value
        },
        set(name: string, value: string, options: CookieOptions) {
          // This is not used but required for the type
        },
        remove(name: string, options: CookieOptions) {
          // This is not used but required for the type
        },
      },
    }
  )

  try {
    const { data: { session }, error } = await supabase.auth.getSession()
    console.log('Session check result:', { hasSession: !!session, hasError: !!error })
    
    const { pathname } = request.nextUrl

    // Allow access to public routes
    if (publicRoutes.some(route => pathname.startsWith(route))) {
      console.log('Accessing public route:', pathname)
      // If user is already logged in and trying to access login/signup, redirect to dashboard
      if (session && (pathname.startsWith('/login') || pathname.startsWith('/signup'))) {
        console.log('User is logged in, redirecting to dashboard')
        return NextResponse.redirect(new URL('/dashboard', request.url))
      }
      console.log('Allowing access to public route')
      return NextResponse.next()
    }

    // Check authentication for protected routes
    if (protectedRoutes.some(route => pathname.startsWith(route))) {
      console.log('Accessing protected route:', pathname)
      if (!session) {
        console.log('No session found, redirecting to login')
        return NextResponse.redirect(new URL('/login', request.url))
      }
    }

    console.log('Proceeding with request')
    return NextResponse.next()
  } catch (error) {
    console.error('Error in middleware:', error)
    // On error, allow the request to proceed to handle error states properly
    return NextResponse.next()
  }
}

export const config = {
  matcher: [
    /*
     * Match all request paths except for the ones starting with:
     * - api (API routes)
     * - _next/static (static files)
     * - _next/image (image optimization files)
     * - favicon.ico (favicon file)
     */
    '/((?!api|_next/static|_next/image|favicon.ico).*)',
  ],
} 