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
  'Access-Control-Allow-Methods': '*',
  "Content-Type": "application/json",
}
const secretKey = 'crackegg1996';

function decodeBlowfish(encodedData) {

  const keyUint8Array = new TextEncoder().encode(secretKey);

  const blowfish = new Blowfish(keyUint8Array);

  const arrayFromString = JSON.parse(encodedData);

  const uint8Array = new Uint8Array(arrayFromString);

  const paddedLength = Math.ceil(uint8Array.length / Blowfish.BLOCK_SIZE) * Blowfish.BLOCK_SIZE;
  const paddedData = new Uint8Array(paddedLength);
  paddedData.set(uint8Array);

  const dataView = new DataView(paddedData.buffer);

  for (let i = 0; i < paddedData.length; i += Blowfish.BLOCK_SIZE) {
    blowfish.decryptBlock(dataView, i);
  }
  const trimmedData = new Uint8Array(dataView.buffer, 0, uint8Array.length);

  const decodedText = new TextDecoder().decode(trimmedData);

  return decodedText;
}

Deno.serve(async (req) => {
  console.log('--------')
  const { method, url } = req
  try {
    const supabaseClient = createClient(
      'https://urdghqpqgkdhmcoecmyb.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyZGdocXBxZ2tkaG1jb2VjbXliIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMTEzNTIxMywiZXhwIjoyMDE2NzExMjEzfQ.12XsqMjC984cOK9lstGA7dRTElEO5M0A67EInBNhIno'
      , { global: { headers: { Authorization: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyZGdocXBxZ2tkaG1jb2VjbXliIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMTEzNTIxMywiZXhwIjoyMDE2NzExMjEzfQ.12XsqMjC984cOK9lstGA7dRTElEO5M0A67EInBNhIno' } } }
    )


    const parsedUrl = new URL(req.url)

    const codeParam = parsedUrl.searchParams.get("code");
    const email = parsedUrl.searchParams.get("email");

    const codeSha256 = decodeBlowfish(codeParam);
    if (!codeSha256) return handleError('Nghi vấn hack: codeSha256')
    console.log('codeSha256', codeSha256)
    const parts = codeSha256.split("-");
    if (parts[0] !== 'duymaiotsv') return handleError('Nghi vấn hack: parts')
    const nowClient = parts[1];
    var currentDate = new Date();
    var timeServe = currentDate.getTime() * 1000;
    // compare nowClient and timeServe
    console.log('timeServe', timeServe)
    console.log('nowClient', nowClient)

    // if ( timeServe - 3000 > parseInt(nowClient) ) return handleError('Nghi vấn hack: timeServe')
    const idCode = parts[2];
    let body;
    let validator;

    switch (method) {
      case 'GET':
        const settingsPath = parsedUrl.pathname.includes("user/settings");
        if (settingsPath)
          return getSettings(supabaseClient);
        // Kiểm tra xem đoạn path có chứa "user/leaderboard" hay không
        const containsPath = parsedUrl.pathname.includes("user/leaderboard");
        if (containsPath)
          return getLeaderBoard(supabaseClient);

        const checkMatchPath = parsedUrl.pathname.includes("user/match-validate");
        if (checkMatchPath) {
          const matchId = parsedUrl.searchParams.get("match_id");

          if (!matchId) return handleError('Match not found')
          return matchValidate(supabaseClient, matchId)
        }

        return getUserProfile(supabaseClient, email!);
      case 'PATCH':

        validator = await codeValidate(supabaseClient, idCode);
        if (!validator) return handleError('Nghi vấn hack')

        body = await req.json();

        const jackpotPath = parsedUrl.pathname.includes("user/update-jackpot");
        if (jackpotPath) {
          return await updateJackpot(supabaseClient, body)
        }

        const topupPath = parsedUrl.pathname.includes("user/topup");
        if (topupPath) {
          return await updateHammer(supabaseClient, email!, body)
        }
        const hammerPath = parsedUrl.pathname.includes("user/score");
        if (hammerPath) {
          return await updateScore(supabaseClient, email!, body)
        }

        const markDonePath = parsedUrl.pathname.includes("/user/mark-game-as-done");
        if (markDonePath) {
          return await markDone(supabaseClient, email!, body)
        }

        return await updateUser(supabaseClient, email!, body)


      case 'POST':

        validator = await codeValidate(supabaseClient, idCode);
        if (!validator) return handleError('Nghi vấn hack')
        body = await req.json();


        const insertGamePath = parsedUrl.pathname.includes("user/insert-game");
        if (insertGamePath) {
          return insertGame(supabaseClient, email, body);
        }


        const createMathPath = parsedUrl.pathname.includes("user/create-match");
        if (createMathPath) {
          return createGame(supabaseClient, body);
        }


        return createUser(supabaseClient, body)


      default:
        handleError('Erorr')
    }

  } catch (e) {
    handleError('Erorr')

  }
})

async function updateJackpot(supabase: SupabaseClient, body) {
  console.log('update jackpot')


  const { data, error } = await supabase
    .from('settings')
    .update(body)
    .eq('id', 1);

  console.log('update jackpot', data)


  console.log('update jackpot', error)
  if (error) return handleError(error)
  return new Response(JSON.stringify(data), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    status: 200,
  })
}


async function getSettings(supabase: SupabaseClient) {

  const { data: setting, error } = await supabase.from('settings').select('*').limit(1)
  if (error) return handleError(error)
  return new Response(JSON.stringify(setting[0]), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    status: 200,
  })
}

async function getLeaderBoard(supabase: SupabaseClient) {

  const { data: users, error } = await supabase.from('users').select('*').order('score', { ascending: false }).limit(20)
  if (error) return handleError(error)
  return new Response(JSON.stringify(users), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    status: 200,
  })
}

async function matchValidate(supabase: SupabaseClient, matchId: string) {

  const { data: match, error } = await supabase.from('match_status').select('*').eq('id', matchId).limit(1)
  if (error) return handleError(error)
  if (match.length == 0) return handleError('Match not found')

  return new Response(JSON.stringify(match[0].available), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    status: 200,
  })
}

async function createUser(supabase: SupabaseClient, body) {
  const { data: users, error } = await supabase.from('users').insert([body]).select()
  if (error) return handleError(error)
  return new Response(JSON.stringify(users), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    status: 200,
  })
}

async function createGame(supabase: SupabaseClient, body) {
  const { data: users, error } = await supabase.from('match_status').insert([body])
  if (error) return handleError(error)
  return new Response(JSON.stringify(users), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    status: 200,
  })
}

async function getUserProfile(supabase: SupabaseClient, email: string) {
  if (!email) return handleError('Nghi vấn hack')


  const { data: users, error } = await supabase.from('users').select('*').eq('email', email).limit(1)
  if (error) return handleError(error)
  return new Response(JSON.stringify(users), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    status: 200,
  })
}

async function codeValidate(supabase: SupabaseClient, code: string): Promise<boolean> {
  const { data: data, error } = await supabase.from('codes').select('*').eq('code_id', code).limit(1)
  if (data.length > 0) {
    return false
  }
  await supabase.from('codes').insert([{ 'code_id': code }])
  return true;
}

async function updateUser(supabase: SupabaseClient, email: string, body) {
  if (!email) return handleError('Nghi vấn hack')
  try {
    const { data: data, error } = await supabase.from('users')
      .update(body)
      .eq('email', email)


    return new Response(JSON.stringify(data), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  }
  catch (e) {
    console.log('e', e)
    return handleError(e)

  }
}


async function insertGame(supabase: SupabaseClient, email: string, body) {
  if (!email) return handleError('Nghi vấn hack')

  try {
    const { data: data, error } = await supabase.from('games')
      .insert([body])
    return new Response(JSON.stringify(data), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  }
  catch (e) {
    console.log('e', e)
    return handleError(e)

  }
}


async function markDone(supabase: SupabaseClient, email: string, body) {
  try {
    const { data: data, error } = await supabase.from('match_status')
      .update({
        'available': body.available
      })
      .eq('id', body.id)
    return new Response(JSON.stringify(data), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  }
  catch (e) {
    console.log('e', e)
    return handleError(e)

  }
}


async function updateScore(supabase: SupabaseClient, email: string, body) {
  if (!email) return handleError('Nghi vấn hack')
  try {
    const { data: data, error } = await supabase.from('users')
      .update({
        'score': body.score
      })
      .eq('email', email)
    return new Response(JSON.stringify(data), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  }
  catch (e) {
    console.log('e', e)
    return handleError(e)

  }
}



async function updateHammer(supabase: SupabaseClient, email: string, body) {
  if (!email) return handleError('Nghi vấn hack')
  try {
    const { data: data, error } = await supabase.from('users')
      .update({ 'hammers': body.quantity })
      .eq('email', email)

    const { data: _, __ } = await supabase.from('topup_history')
      .insert([body])
      .eq('email', email)
    return new Response(JSON.stringify(data), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  }
  catch (e) {
    console.log('e', e)
    return handleError(e)

  }
}


function handleError(error) {
  return new Response(JSON.stringify({ error: error }), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    status: 400,
  })
}