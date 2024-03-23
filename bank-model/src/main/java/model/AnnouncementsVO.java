package model;

import com.fasterxml.jackson.annotation.JsonFormat;
import entity.Announcements;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 * @author 关于废人张
 * @date 2024/3/23 1:11
 * @Description 公告
 */
@Data
@Accessors(chain = true)
public class AnnouncementsVO {

    /**
     * 唯一標識
     */
    private int id;

    /**
     * 公告內容
     */
    private String content;

    /**
     * 公告發佈管理員名稱
     */
    private String name;

    /**
     * 發佈時間
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm::ss")
    private Date time;

    public static AnnouncementsVO convertToVO(Announcements data) {
        return new AnnouncementsVO()
                .setId(data.getId())
                .setContent(data.getContent())
                .setTime(data.getPublishedAt())
                .setName(data.getAuthor());
    }

}
