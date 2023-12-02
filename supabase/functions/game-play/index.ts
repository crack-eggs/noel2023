// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient, SupabaseClient } from "https://esm.sh/@supabase/supabase-js"



serve(async (req) => {
  const { url, method } = req
  return new Response('ahi', {
    headers: { 'Content-Type': 'application/json' },
    status: 200,
  })
}
)