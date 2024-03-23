package dto;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 * @author 关于废人张
 * @date 2024/3/23 1:07
 * @Description 管理員公告
 */
@Data
@Accessors(chain = true)
public class AnnouncementsDTO {

    private String content;

    private String author;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date publishedAt;

    /**
     * 0-立即发送 1-定时发送
     */
    private int sendOption;
}
