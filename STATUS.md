# Project Status

## Overview

This is a **Next.js** project named `schedule-me`, designed to manage employee scheduling, coverage requirements, and time-off requests. The application leverages **Supabase** for backend services, including authentication and database management. The frontend is built with **React 18**, **TypeScript**, and **Tailwind CSS**, utilizing components from **Radix UI** and **Shadcn UI** for a consistent and responsive user interface.

## Technologies Used

- **Next.js 14**: Server-side rendering and Static Site Generation.
- **React 18**: Frontend library for building user interfaces.
- **TypeScript**: Static type checking for JavaScript.
- **Supabase**: Backend as a service for authentication, database, and storage.
- **React Query (@tanstack/react-query)**: Data fetching and state management.
- **Tailwind CSS**: Utility-first CSS framework for styling.
- **Shadcn UI**: Component library for building accessible and customizable UI components.
- **Radix UI**: Unstyled, accessible components for building high-quality design systems and web apps.
- **Vitest & Testing Library**: Testing frameworks for unit and integration tests.
- **ESLint & Prettier**: Code linting and formatting tools.

## Project Structure

- **`src/components/`**: Reusable React components organized by feature (e.g., `schedule`, `dashboard`, `notifications`).
- **`src/app/`**: Next.js App Router structure with route-specific components and pages.
- **`src/lib/`**: Library utilities, including Supabase client setup and scheduling algorithms.
- **`src/types/`**: TypeScript type definitions for various data structures.
- **`supabase/migrations/`**: SQL migration files for database schema and initial data.
- **`tests/`**: Testing files for components and utilities.
- **Configuration Files**: `package.json`, `tsconfig.json`, `tailwind.config.js`, `.prettierrc`, `.gitignore`, `postcss.config.mjs`, `eslint.config.mjs`, `supabase/config.toml`.

## Dependencies

### Production Dependencies

- **@radix-ui/react-***: Various Radix UI components for building accessible interfaces.
- **@supabase/supabase-js**: Supabase client for interacting with the backend.
- **@tanstack/react-query**: Managing server state and data fetching.
- **date-fns**: Utility library for date operations.
- **lucide-react**: Icon library.
- **next-themes**: Theme management for Next.js.
- **react & react-dom**: Core React libraries.
- **shadcn-ui**: UI component library.
- **sonner**: Notification library.
- **zustand**: State management library.

### Development Dependencies

- **@testing-library/***: Testing utilities for React components.
- **@types/***: Type definitions for TypeScript.
- **@vitejs/plugin-react**: Vite plugin for React.
- **autoprefixer, postcss, tailwindcss**: CSS processing tools.
- **eslint, eslint-config-next**: Linting tools.
- **prettier**: Code formatter.
- **vitest**: Testing framework.
- **typescript**: TypeScript compiler and language support.
- **vite-tsconfig-paths**: Vite plugin for TypeScript path mapping.

## Key Features

- **Coverage Management**: 
  - `CoverageManager.tsx` handles fetching and updating staffing coverage requirements.
  - Utilizes Supabase for data operations and React Query for state management.
  
- **Availability Summary**: 
  - `AvailabilitySummary.tsx` displays statistics related to employee availability.
  - Calculates metrics like total employees, fully available, partially available, and unavailable.

- **Dashboard**: 
  - `DashboardContent.tsx` provides an overview for both managers and employees.
  - Displays profile information, quick actions, and upcoming shifts.
  
- **Role Management**: 
  - `RoleManager.tsx` allows managers to manage team roles within the organization.
  
- **Notifications**: 
  - `NotificationCenter.tsx` manages and displays user notifications.
  
- **Schedule Generation**: 
  - `ScheduleGenerator.tsx` includes functionalities for generating and publishing schedules.
  
- **Testing**: 
  - Comprehensive tests using Vitest and Testing Library ensure component reliability (`AvailabilitySummary.test.tsx`).

## Database Schema

- **`coverage_requirements`**: Manages staffing needs per shift and day.
- **`profiles`**: Stores user profiles with roles and organization associations.
- **`schedule_assignments`**: Tracks employee assignments to shifts.
- **`shift_swap_requests`**: Handles requests for shift swaps.
- **`employee_availability`**: Records employee availability patterns.

### Security

- **Row-Level Security (RLS)**: Implemented in Supabase to restrict data access based on user roles and organization membership.
- **Policies**:
  - Users can only view coverage requirements within their organization.
  - Only managers can manage coverage requirements and other sensitive operations.

## Development Scripts

Defined in `package.json`:

- **`dev`**: Starts the development server.
- **`build`**: Builds the production version.
- **`start`**: Starts the production server.
- **`lint`**: Runs ESLint for code linting.
- **`test`**: Executes tests using Vitest.
- **`test:coverage`**: Runs tests with coverage reporting.

## UI/UX

- **Shadcn UI**: Utilized for building consistent and accessible UI components. Updated commands following the new naming convention (`npx shadcn@latest`).
- **Tailwind CSS**: Customized via `tailwind.config.js` to extend themes and integrate with Shadcn UI.
- **Responsive Design**: Ensured through Tailwind's utility classes for various screen sizes.

## Testing

- **Unit & Integration Tests**: Implemented using Vitest and Testing Library (`AvailabilitySummary.test.tsx`).
- **Mocking**: Supabase client is mocked to simulate backend interactions during tests.
- **Coverage Reports**: Generated to ensure code reliability and identify untested areas.

## Continuous Integration & Deployment

- **Vercel**: Recommended for deploying the Next.js application, leveraging seamless integration and optimization features.
- **Supabase**: Manages backend services, including databases and authentication.

## Areas for Improvement

1. **Error Handling**:
   - Enhance user feedback for failed operations beyond toast notifications.
   - Implement retry mechanisms for transient errors in data fetching.

2. **Performance Optimization**:
   - Optimize React Query cache to reduce unnecessary network requests.
   - Implement code-splitting and lazy loading for large components.

3. **Accessibility**:
   - Conduct thorough accessibility audits to ensure compliance with standards.
   - Utilize ARIA attributes where necessary in custom components.

4. **Scalability**:
   - Refactor components to be more modular for easier maintenance and scalability.
   - Optimize database queries and indexes for better performance with larger datasets.

5. **Security Enhancements**:
   - Regularly review and update RLS policies in Supabase.
   - Implement rate limiting and input validation to prevent abuse.

6. **Documentation**:
   - Expand inline code documentation for better developer onboarding.
   - Maintain a comprehensive `README.md` with setup instructions, feature overviews, and contribution guidelines.

7. **Testing Coverage**:
   - Increase test coverage for critical components and utilities.
   - Incorporate end-to-end testing using tools like Cypress.

## Conclusion

The `schedule-me` project is a robust scheduling platform built with modern technologies, ensuring scalability, security, and a responsive user experience. By addressing the identified areas for improvement, the project can further enhance its reliability, performance, and user satisfaction. 