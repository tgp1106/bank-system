package com.tgp.bank.service;

import org.springframework.web.multipart.MultipartFile;

/**
 * @author 关于废人张
 * @date 2024/3/23 12:24
 * @Description
 */
public interface FileService {
    String uploadFile(MultipartFile file);

    byte[] getImage(String imageName);
}
