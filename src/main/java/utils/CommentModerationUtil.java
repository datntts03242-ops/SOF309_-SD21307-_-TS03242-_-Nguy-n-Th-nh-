package utils;

public class CommentModerationUtil {

    // TODO: nên chuyển sang bảng DB (BannedWords) để admin tự cập nhật không cần build lại
    private static final String[] BANNED_WORDS = {
        "đm", "vcl", "cc", "địt", "đéo"
        // bổ sung thêm từ tục tĩu / công kích khác tại đây
    };

    /**
     * Trả về lý do vi phạm nếu content vi phạm, null nếu hợp lệ.
     */
    public static String checkViolation(String content) {
        if (content == null || content.isBlank()) return null;

        String lower = content.toLowerCase();

        for (String w : BANNED_WORDS) {
            if (lower.contains(w)) {
                return "Chứa từ ngữ tục tĩu, thô tục";
            }
        }

        return null;
    }
}