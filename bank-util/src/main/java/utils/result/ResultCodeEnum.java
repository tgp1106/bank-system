package utils.result;

import lombok.Getter;

/**
 * @Author：陶广鹏
 * @Package：com.tgp.common.result
 * @Project：tgp-oa-parent
 * @name：ResultCodeEnum
 * @Date：2023/8/20 19:38
 * @Filename：ResultCodeEnum
 */
@Getter
public enum ResultCodeEnum {

    SUCCESS(200,"成功"),
    FAIL(201, "失败"),
    SERVICE_ERROR(2012, "服务异常"),
    DATA_ERROR(204, "数据异常"),

    LOGIN_AUTH(208, "未登陆"),
    PERMISSION(209, "没有权限"),
    PASSWORD_ERROR(404,"密码错误"),

    USERS_NOT_EXISTS(30001,"用户不存在"),
    UPLOAD_ERROR(20001, "文件上传失败"),
    LOAD_ERROR(20002, "文件加载失败"),

    SAVE_OPERATOR_ERROR(30002, "保存日志失败");

    private Integer code;

    private String message;

    private ResultCodeEnum(Integer code, String message) {
        this.code = code;
        this.message = message;
    }
}
