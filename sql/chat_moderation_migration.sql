/*
  Migration: thêm tính năng Lưu trữ / Chặn hội thoại / Xóa (thu hồi) tin nhắn
  cho module Chat với Admin.

  CHẠY 1 LẦN trên SQL Server database SuMonDB trước khi build lại project,
  nếu không admin/chat sẽ báo lỗi (thiếu cột is_archived / is_blocked / is_deleted).
*/

IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('ChatConversations') AND name = 'is_archived'
)
BEGIN
    ALTER TABLE ChatConversations ADD is_archived BIT NOT NULL DEFAULT 0;
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('ChatConversations') AND name = 'is_blocked'
)
BEGIN
    ALTER TABLE ChatConversations ADD is_blocked BIT NOT NULL DEFAULT 0;
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('ChatMessages') AND name = 'is_deleted'
)
BEGIN
    ALTER TABLE ChatMessages ADD is_deleted BIT NOT NULL DEFAULT 0;
END
GO
