package dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author：陶广鹏
 * @Package：dto
 * @Project：Bank-system
 * @name：FindBackDto
 * @Date：2023/9/14 20:00
 * @Filename：FindBackDto
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class FindBackDto {
    String userName;
    String code;
    String newPassword;
}
