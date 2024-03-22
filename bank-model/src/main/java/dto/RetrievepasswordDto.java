package dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author：陶广鹏
 * @Package：dto
 * @Project：Bank-system
 * @name：RetrievepasswordDto
 * @Date：2023/9/14 19:15
 * @Filename：RetrievepasswordDto
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RetrievepasswordDto {
   String userName;
   String phone;
   String code;
}
