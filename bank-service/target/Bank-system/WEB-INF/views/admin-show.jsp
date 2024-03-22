<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.User" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户列表</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.bootcdn.net/ajax/libs/vue/2.5.0/vue.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/axios/1.3.6/axios.min.js"></script>
</head>
<body>
<div class="container">
    <h2 class="text-center">用户列表</h2>
    <table class="table">
        <thead>
        <tr>
            <th scope="col">用户名</th>
            <th scope="col">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="username" items="${usernames}">
            <tr>
                <td>${username}</td>
                <td>
                    <button class="btn btn-primary btn-sm" onclick="freezeUser('${username}');">冻结用户</button>
                    <button class="btn btn-success btn-sm" onclick="unfreezeUser('${username}');">解冻用户</button>
                    <button class="btn btn-warning btn-sm" data-toggle="modal" data-target="#modifyUserModal-${username}">修改用户信息</button>

                    <!-- 修改用户信息弹窗 -->
                    <div class="modal fade" id="modifyUserModal-${username}" tabindex="-1" role="dialog" aria-labelledby="modifyUserModalLabel-${username}" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="modifyUserModalLabel-${username}">修改用户信息</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form>
                                        <div class="form-group">
                                            <label for="phone-${username}">手机号</label>
                                            <input type="text" class="form-control" id="phone-${username}">
                                        </div>
                                        <div class="form-group">
                                            <label for="password-${username}">密码</label>
                                            <input type="password" class="form-control" id="password-${username}">
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                                    <button type="button" class="btn btn-primary" onclick="modify('${username}')">保存</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="mt-5">
    <h3>发布公告</h3>
    <form id="announcementForm">
        <div class="form-group">
            <label for="content">内容</label>
            <textarea class="form-control" id="content" rows="3"></textarea>
        </div>
        <div class="form-group">
            <label for="publishTime">时间</label>
            <input type="datetime-local" class="form-control" id="publishTime">
        </div>
        <div class="form-group">
            <label for="publisher">发布人</label>
            <input type="text" class="form-control" id="publisher">
        </div>
        <button type="button" class="btn btn-primary" onclick="publishAnnouncement()">发布公告</button>
        <button type="button" class="btn btn-secondary" onclick="resetForm()">清空表单</button>
    </form>
</div>
<div class="d-flex justify-content-center mt-3">
    <button type="button" class="btn btn-danger" onclick="window.location.href='${pageContext.request.contextPath}/logout'">退出登录</button>
</div>
<script>
    function freezeUser(userName) {
        axios.get('/userFreeze', {
            params: {
                userName: userName
            }
        })
            .then(response => {
                console.log(response)
                if (response.data.code === 201) {
                    alert(response.data.message)
                } else {
                    alert(response.data.data)
                }
            })
    }
    function modify(username) {
        var phone = document.getElementById("phone-" + username).value;
        var password = document.getElementById("password-" + username).value;

        var formData = {
            "userName": username,
            "phone": phone,
            "passWord": password
        };

        axios.post('${pageContext.request.contextPath}/modify', formData)
            .then(response => {
                console.log(response)
                if (response.data.code === 201) {
                    alert(response.data.message)
                } else {
                    alert(response.data.data);
                    $('#modifyUserModal-' + username).modal('hide'); // 关闭当前用户的弹窗
                }
            })
            .catch(error => {
                this.message = error.response.data.message;
                // 处理失败的情况
            });

    }
    function unfreezeUser(userName) {
        axios.get('/userUnfreeze', {
            params: {
                userName: userName
            }
        })
            .then(response => {
                console.log(response);
                if (response.data.code === 201) {
                    alert(response.data.message);
                } else {
                    alert(response.data.data);
                }
            })
    }
    function updateUser(userName) {
        axios.get('/updateUser', {
            params: {
                userName: userName
            }
        }).then(response => {
            console.log(response);
            if (response.data.code === 201) {
                alert(response.data.message);
            } else {
                alert(response.data.message);
            }
        })
    }

</script>

<script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
