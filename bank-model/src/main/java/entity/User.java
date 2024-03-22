package entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * <p>
 *
 * </p>
 *
 * @author tgp
 * @since 2023-09-11
 */
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class User implements Serializable {

    private static final long serialVersionUID = 1L;
      @TableId(value = "user_id", type = IdType.AUTO)
    private Long userId;
    private String userName;
    private String passWord;
    private Double balance = 0.0;
    private String phoneNumber;

    @TableLogic //逻辑删除
    @TableField("is_deleted")
    private Integer isDeleted;


    public User(String userName, String passWord, String phoneNumber) {
        this.userName = userName;
        this.passWord = passWord;
        this.phoneNumber = phoneNumber;
    }
}
