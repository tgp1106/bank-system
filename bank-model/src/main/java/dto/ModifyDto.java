package dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author：陶广鹏
 * @Package：dto
 * @Project：Bank-system
 * @name：ModifyDto
 * @Date：2023/9/13 21:28
 * @Filename：ModifyDto
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ModifyDto {

    String phone;

    String passWord;

    String userName;

    /**
     * 头像访问地址
     */
    String fileUrl;
}
