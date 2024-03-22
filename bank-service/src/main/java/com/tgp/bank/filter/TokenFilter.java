package com.tgp.bank.filter;


import com.tgp.bank.service.UserService;
import entity.User;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import utils.execption.TgpException;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;



/**
 * @Author：陶广鹏
 * @Package：com.tgp.bank.filter
 * @Project：Bank-system
 * @name：TokenFilter
 * @Date：2023/9/12 22:20
 * @Filename：TokenFilter
 */

@WebFilter(filterName = "tokenFilter", urlPatterns = "/*")
public class TokenFilter implements Filter {

    RedisTemplate<String, Object> redisTemplate;
    UserService userService;
    boolean isLoggedIn = false;
    //放行目录
    private HashSet<String> allowedPaths = new HashSet<>();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        //添加放行路径
        allowedPaths.add("/login");
        allowedPaths.add("/toregister");
        allowedPaths.add("/retrievepassword");
        allowedPaths.add("/findback");
        allowedPaths.add("/administrator");
        WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(filterConfig.getServletContext());
        redisTemplate = (RedisTemplate<String, Object>) wac.getBean("redisTemplate");
        userService = wac.getBean(UserService.class);
    }


    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {


        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        // 获取请求的路径
        String requestUri = request.getRequestURI();

        //白名单
        if (checkWhiteList(requestUri)) {
            filterChain.doFilter(request, response);
            return;
        }

        // 获取请求中的 token
        String token = (String) request.getSession().getAttribute("token");
        // 检查 token 是否有效，这里可以根据实际业务逻辑来判断
        if (token == null||isTokenExpired(token)) {
            // 无效的 token，进行跳转到登录页面
            request.getSession().invalidate();
            redisTemplate.delete("isLoggedIn");
            redisTemplate.delete("loginUsername");
            response.sendRedirect("/login.jsp?message=expired"); // 使用重定向方式跳转
        } else if (request.getSession().getAttribute("loginUser")!=null) {
                User loginUser = (User) request.getSession().getAttribute("loginUser");
            String loginUsername = (String) redisTemplate.opsForValue().get("loginUsername");
//            String passwordByusername = userService.getPasswordByusername(loginUser.getUserName());
            System.out.println(loginUsername);
            String passwordByusername = userService.getPasswordByusername(loginUsername);
                if (!loginUser.getPassWord().equals(passwordByusername) ) {
                    request.getSession().invalidate();
                    redisTemplate.delete("isLoggedIn");
                    redisTemplate.delete("loginUsername");
                    response.sendRedirect("/login.jsp");//如果用户密码发生变动,清空session并跳转到登录页面
                   return;
                }
                filterChain.doFilter(request, response);
            }else if (request.getSession().getAttribute("loginAdministrator")!=null){
            filterChain.doFilter(request, response);
        }

        }
        // 请求处理完成后，清除 ThreadLocal 中的用户和 token 信息


    @Override
    public void destroy() {
        // 过滤器销毁方法
    }

    /*
        白名单
     */
    private boolean checkWhiteList(String path) {
        // 如果请求的是静态文件，则直接放行
        if (isStaticResource(path)) {
            return true;
        }
        // 如果请求的是登录页面，则直接放行
        if (isLoginPage(path)) {
            return true;
        }
        return allowedPaths.contains(path);//最后检查放行目录
    }

    private boolean isStaticResource(String requestUri) {
        // 根据实际需求判断是否为静态资源，可以根据文件后缀或特定路径进行判断
        // 这里仅作示例，假设静态资源的路径以 /static/ 开头
        return requestUri.startsWith("/static/");
    }

    private boolean isLoginPage(String requestUri) {
        // 根据实际的登录页面路径进行判断，这里仅作示例
        if ("/login.jsp".equals(requestUri)) {
            return true;
        }
        if ("/register.jsp".equals(requestUri)) {
            return true;
        }
        if ("/".equals(requestUri)) {
            return true;
        }
        if ("/retrievepassword.jsp".equals(requestUri)) {
            return true;
        }
        if ("/administer.jsp".equals(requestUri)) {
            return true;
        }
            return false;

    }

    private static boolean isTokenExpired(String token) {
        try {
            Claims claims = Jwts.parser()
                    .setSigningKey("123456")
                    .parseClaimsJws(token)
                    .getBody();
            Date expirationDate = claims.getExpiration();
            return expirationDate.before(new Date());
        } catch (ExpiredJwtException e) {
            // Token 已过期
            return true;
        } catch (Exception e) {
            // 解析或验证出错
            e.printStackTrace();
            return true;
        }
    }
    }
