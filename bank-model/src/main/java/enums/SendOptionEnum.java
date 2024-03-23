package enums;

import lombok.Getter;

/**
 * @author 关于废人张
 * @date 2024/3/23 15:40
 * @Description 公告发布选择枚举
 */
@Getter
public enum SendOptionEnum {

    NOW(0,"立即发送"),
    TIMING(1,"定时");

    private int option;

    private String message;

    SendOptionEnum(int option, String message) {
        this.option = option;
        this.message = message;
    }
}
