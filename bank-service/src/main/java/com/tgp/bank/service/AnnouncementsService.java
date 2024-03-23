package com.tgp.bank.service;

import dto.AnnouncementsDTO;
import model.AnnouncementsVO;

import java.util.List;

/**
 * @author 关于废人张
 * @date 2024/3/23 0:32
 * @Description
 */
public interface AnnouncementsService {

    List<AnnouncementsVO> getList();

    void publishAnnouncement(AnnouncementsDTO announcementsDTO);
}
