import { createClient, SupabaseClient } from "https://esm.sh/@supabase/supabase-js"

const supabase = createClient(
  'https://urdghqpqgkdhmcoecmyb.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyZGdocXBxZ2tkaG1jb2VjbXliIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMTEzNTIxMywiZXhwIjoyMDE2NzExMjEzfQ.12XsqMjC984cOK9lstGA7dRTElEO5M0A67EInBNhIno'
  , { global: { headers: { Authorization: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyZGdocXBxZ2tkaG1jb2VjbXliIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMTEzNTIxMywiZXhwIjoyMDE2NzExMjEzfQ.12XsqMjC984cOK9lstGA7dRTElEO5M0A67EInBNhIno' } } }
)

// Hàm cập nhật dữ liệu
const updateUserDatabase = async () => {
  try {
    // Sử dụng một SQL query để thêm tất cả người dùng và tăng giá trị "hammers" lên 1
    const { data, error } = await supabase.rpc('insert_all_users_and_increment_hammers');

    if (error) {
      console.error('Error inserting users:', error.message);
      return;
    }

    console.log('Users inserted successfully.');
  } catch (err) {
    console.error('Error:', err.message);
  }
};

// Hàm chạy vào mỗi ngày lúc 00:01
const scheduleDailyUpdate = async () => {
  const now = new Date();
  const scheduledTime = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 0, 1, 0, 0); // Lúc 00:01
  const delay = scheduledTime.getTime() - now.getTime();

  // Đợi cho đến khi đến thời gian cập nhật
  if (delay > 0) {
    setTimeout(async () => {
      await updateUserDatabase();
      // Gọi lại hàm sau 24 giờ để lên lịch cho cập nhật tiếp theo
      scheduleDailyUpdate();
    }, delay);
  } else {
    console.error('Scheduled time has passed. Please set a future time for scheduling.');
  }
};

// Bắt đầu lên lịch cập nhật mỗi ngày
scheduleDailyUpdate();
