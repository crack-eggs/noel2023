// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient, SupabaseClient } from "https://esm.sh/@supabase/supabase-js"
import { Blowfish } from "https://deno.land/x/crypto@v0.10.1/blowfish.ts";
import { decodeHex } from "https://deno.land/x/crypto@v0.10.1/dev_deps.ts";

export const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': '*',
  "Content-Type": "application/json",
}
const secretKey = 'crackegg1996';

function decodeBlowfish(encodedData) {

  // Chuyển đổi secretKey thành Uint8Array
  const keyUint8Array = new TextEncoder().encode(secretKey);

  // Tạo đối tượng Blowfish với key
  const blowfish = new Blowfish(keyUint8Array);

  const arrayFromString = JSON.parse(encodedData);

  // Convert the array of integers to a Uint8Array
  const uint8Array = new Uint8Array(arrayFromString);

  // Ensure that the data length is a multiple of the block size
  const paddedLength = Math.ceil(uint8Array.length / Blowfish.BLOCK_SIZE) * Blowfish.BLOCK_SIZE;
  const paddedData = new Uint8Array(paddedLength);
  paddedData.set(uint8Array);

  const dataView = new DataView(paddedData.buffer);


  // Giải mã từng block
  for (let i = 0; i < paddedData.length; i += Blowfish.BLOCK_SIZE) {
    blowfish.decryptBlock(dataView, i);
  }

  // Trim the padding from the decrypted data
  const trimmedData = new Uint8Array(dataView.buffer, 0, uint8Array.length);


  // Chuyển đổi DataView thành chuỗi UTF-8
  const decodedText = new TextDecoder().decode(trimmedData);


  return decodedText;
}

Deno.serve(async (req) => {
  const { method } = req
  try {
    const supabaseClient = createClient(
      'https://urdghqpqgkdhmcoecmyb.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyZGdocXBxZ2tkaG1jb2VjbXliIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMTEzNTIxMywiZXhwIjoyMDE2NzExMjEzfQ.12XsqMjC984cOK9lstGA7dRTElEO5M0A67EInBNhIno'
      , { global: { headers: { Authorization: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyZGdocXBxZ2tkaG1jb2VjbXliIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMTEzNTIxMywiZXhwIjoyMDE2NzExMjEzfQ.12XsqMjC984cOK9lstGA7dRTElEO5M0A67EInBNhIno' } } }
    )


    const parsedUrl = new URL(req.url)

    const codeParam = parsedUrl.searchParams.get("code");
    const email = parsedUrl.searchParams.get("email");
    const type = parsedUrl.searchParams.get("type");
    console.log('method', method)
    console.log(type)

    const code = decodeBlowfish(codeParam);
    const parts = code.split("-");


    console.log('type', type)
    console.log('code', code)
    console.log('method', method)

    if (type === 'select') {

      const { data: users, error } = await supabaseClient.from('users').select('*').eq('email', email).limit(1)
      if (error) return handleError(error)
      return new Response(JSON.stringify(users), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 200,
      })
    }


    const body = await req.json();


    if (!code) handleError('Nghi vấn hack')
    console.log('parst', parts[0])

    if (parts[0] === 'duymaiotsv') {
      const idCode = parts[1];
      console.log('idCode', idCode)
      const { data: code, error } = await supabaseClient.from('codes').select('*').eq('code_id', idCode).limit(1)
      if (code && code.length == 0) {
        await supabaseClient.from('codes').insert([{ 'code_id': idCode }])

        if (type === 'update') {
          const { data: data, error } = await supabaseClient.from('users')
            .update(body)
            .eq('email', email).select()
          if (error) return handleError(error)
          return new Response(JSON.stringify(data), {
            headers: { ...corsHeaders, 'Content-Type': 'application/json' },
            status: 200,
          })
        }
        console.log('nhay vao day 2')

        if (type === 'insert') {
          /// create user
          const { data: users, error } = await supabaseClient.from('users').insert([body]).select()
          if (error) return handleError(error)
          return new Response(JSON.stringify(users), {
            headers: { ...corsHeaders, 'Content-Type': 'application/json' },
            status: 200,
          })
        }
        console.log('nhay vao day 4')

      } else {
        return handleError('Phát hiện nghi vấn hack')
      }
    } else {
      return handleError('Phát hiện nghi vấn hack')
    }
    console.log('nhay vao day 5')

  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
})

function handleError(error) {
  return new Response(JSON.stringify({ error: error }), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    status: 400,
  })
}