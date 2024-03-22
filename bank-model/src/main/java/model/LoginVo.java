package model;

import lombok.Data;

/**
 * 登录对象
 */
@Data
public class LoginVo {

    /**
     * 用户名
     */
    private String username;

    /**
     * 密码
     */
    private String password;


}
