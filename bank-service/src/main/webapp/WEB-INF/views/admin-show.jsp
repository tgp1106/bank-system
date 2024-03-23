<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.User" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="entity.Administrator" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>管理后台</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.bootcdn.net/ajax/libs/vue/2.5.0/vue.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/axios/1.3.6/axios.min.js"></script>
    <style>
        /*body {*/
        /*    background-image: url("https://pic.rmb.bdstatic.com/bjh/news/6bf485d5ac92e530691b48765b98c9c8383.jpeg");*/
        /*    background-size: cover;*/
        /*    background-repeat: no-repeat;*/
        /*}*/

        .left-area, .middle-area, .right-area {
            border: 1px solid #ddd;
        }


        .flex-container {
            height: 90vh; /* 占据剩余的高度 */
            display: flex;
        }

        .middle-area {
            flex: 2; /* 中间区域占据两倍的空间 */
        }

        .profile-info {
            text-align: right;
            color: white;
            /*margin-top: 10px;*/
        }

        .button-group {
            display: flex;
            flex-direction: column;
            gap: 10px;
            align-items: center;
        }

        .btn {
            width: 50%;

        }

        .notice-board {
            border: 1px solid #ccc;
            max-width: 600px;
            margin: 0 auto;
            padding: 15px;
            background-color: transparent;
            border-radius: 10px;
        }

        .admin-name {
            font-weight: bold;
            color: #3498db; /* 设置管理员名字颜色 */
        }

        .notice-board ul {
            list-style-type: none;
            padding: 0;
            height: 430px;
            overflow-y: auto; /* 垂直滚动条 */
        }
        .notice-time {
            color: gray;
        }

        .notice-board-ul li {
            margin: 10px 0;
            padding: 10px;
            background-color: transparent;
            color: white;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            word-wrap: break-word; /* 在需要时自动换行 */
            /*overflow-y: auto; !* 垂直滚动条 *!*/
        }

        ::-webkit-scrollbar {
            width: 5px; /* 滚动条宽度 */
        }

        ::-webkit-scrollbar-track {
            background: transparent; /* 滚动条背景色 */
        }

        ::-webkit-scrollbar-thumb {
            background: #b3b3b3; /* 滚动条颜色 */
            border-radius: 8px; /* 滚动条圆角 */
        }



        .notice-li {
            background-color: transparent;
        }
        #pageContent {
            list-style-type: none;
            padding: 0;
            height: 430px;
            overflow-y: auto; /* 垂直滚动条 */
        }
        .operator-div {
            list-style-type: none;
            padding: 0;
            height: 430px;
            overflow-y: auto; /* 垂直滚动条 */
        }
        .btn-custom {
            display: inline;
            padding-left: 5px;
        }
        h2 {
            color: #5bc0de;
        }
        .th-custom {
            width: 25%;
        }
    </style>
    <%
        Administrator user = (Administrator)pageContext.getSession().getAttribute("loginAdministrator");
    %>
</head>

<body>
<nav class="navbar" style="height: 10%;background-color: transparent">
    <h3 class="text-white" style="text-align: center;">银 行 管 理 系 统 管 理 端</h3>
    <div class="profile-info">
        <button class="btn btn-primary btn-outline-light ml-2" style="margin-left: 15px;width: 100px;" onclick="backIndex()">返回主页</button>
        <button class="btn btn-danger btn-outline-light ml-2" style="margin-left: 15px;width: 100px;" onclick="window.location.href='${pageContext.request.contextPath}/logout'">退出登录</button>
    </div>
</nav>
<div class="container-fluid">
    <div class="row flex-container">
        <div class="col-md-3 left-area">
            <!-- 左侧区域内容 -->
            <h2 style="text-align: center;">公 告</h2>
            <div class="notice-board">
                <ul id="noticeList" class="notice-board-ul">
                </ul>
            </div>
        </div>
        <!-- 中间区域内容 -->
        <div class="center-div col-md-5 middle-area" style="width: 20%; padding-left: 20px; padding-right: 20px">
            <h2 class="text-center" style="margin-top: 0;padding-top : 0;">用 户 列 表</h2>
            <div id="pageContent" class="button-group">
                <table class="table">
                    <thead>
                    <tr>
                        <th class = "th-custom" scope="col">用户名</th>
                        <th class = "th-custom"  scope="col">冻结</th>
                        <th class = "th-custom"  scope="col">解冻</th>
                        <th class = "th-custom"  scope="col">修改</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="user" items="${users}">
                        <!-- 修改用户信息弹窗 -->
                        <div class="modal fade" id="modifyUserModal-${user.userName}" tabindex="-1" role="dialog" aria-labelledby="modifyUserModalLabel-${user.userName}" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="modifyUserModalLabel-${user.userName}">修改用户信息</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <form>
                                            <div class="form-group">
                                                <label for="phone-${user.userName}">手机号</label>
                                                <input type="text" class="form-control" id="phone-${user.userId}" placeholder="${user.phoneNumber}">
                                            </div>
                                            <div class="form-group">
                                                <label for="password-${user.userName}">密码</label>
                                                <input type="password" class="form-control" id="password-${user.userName}">
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                                        <button type="button" class="btn btn-primary" onclick="modify('${user.userName}')">保存</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <tr>
                            <td class = "th-custom" >${user.userName}</td>
                            <td class = "th-custom" >
                                <button class="btn btn-custom btn-primary btn-sm" onclick="freezeUser('${user.userName}');">冻结</button>
                            </td>
                            <td class = "th-custom" >
                                <button class="btn btn-custom btn-success btn-sm" onclick="unfreezeUser('${user.userName}');">解冻</button>
                            </td>
                            <td class = "th-custom" >
                                <button class="btn btn-custom btn-warning btn-sm" data-toggle="modal" data-target="#modifyUserModal-${user.userName}">修改</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-md-4 right-area">
            <h2  style="text-align: center">发 布 公 告</h2>
            <div class="right-area">
                <form id="announcementForm">
                    <div class="form-group">
                        <label style="align-content: center" for="content">内容</label>
                        <textarea class="form-control" id="content" rows="8" maxlength="500" placeholder="字数限制500以内"></textarea>
                    </div>
                    <div class="form-check d-inline-block" style="padding-right: 50px">
                    </div>
                    <div class="form-check d-inline-block mr-3">
                        <input class="form-check-input" type="radio" name="sendOption" id="sendNow" value="0" checked>
                        <label class="form-check-label" for="sendNow">
                            立即发布
                        </label>
                    </div>

                    <div class="form-check d-inline-block">
                        <input class="form-check-input" type="radio" name="sendOption" id="sendLater" value="1">
                        <label class="form-check-label" for="sendLater">
                            定时发布
                        </label>
                    </div>
                    <div class="form-group mt-3" id="timeInput" style="display: none;">
                        <input type="datetime-local" class="form-control" id="publishTime">
                    </div>
                    <div class="form-group ">
                        <button type="button" style="width: 30%;margin-left:50px;margin-right: 50px" class="btn btn-primary" onclick="publishAnnouncement()">发布</button>
                        <button type="button" style="width: 30%" class="btn btn-secondary" onclick="resetForm()">清空</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        // 获取信息
        getNoticeList();
    });
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
    function getNoticeList() {
        $.ajax({
            url: '${pageContext.request.contextPath}/announcements/getNoticeList',
            type: 'GET',
            dataType: 'json',
            success: function (resp) {
                var ul = $('#noticeList');
                $.each(resp.data, function (index, item) {

                    ul.append('<li class="notice-li">' +
                        '<div class="notice-time">' + item.time + '</div>' +
                        '<span class="admin-name">' + item.name + ' : </span>' +
                        item.content + '</li>');
                });
            },
            error: function () {
                console.log('Error occurred while fetching list items.');
            }
        });
    }
    $('input[type=radio][name=sendOption]').change(function() {
        if (this.value === '1') {
            $('#timeInput').show();
        } else {
            $('#timeInput').hide();
        }
    });

    function publishAnnouncement() {
        var content = $('#content').val();
        var sendOption = $('input[name="sendOption"]:checked').val();
        var publishTime = '';

        if (sendOption === '0') {
            publishTime = $('#publishTime').val();
        }
        var data = {
                "content": content,
                "author": '<%=user.getAdministratorName()%>',
                "sendOption": sendOption === '0' ? 0 : 1,
                "publishedAt": publishTime
        };
        axios.post('${pageContext.request.contextPath}/publishAnnouncement', data)
            .then(response => {
                if (response.data.code === 200) {
                    alert(response.data.message)
                    resetForm();
                }
            })
            .catch(error => {
                this.message = error.response.data.message;
            });
    }
    function resetForm() {
        $('#content').val('');
        $('#publishTime').val('');
    }
    // 监听textarea输入事件
    $('#content').on('input', function() {
        var maxLength = 500;
        var currentLength = $(this).val().length;
        var remaining = maxLength - currentLength;
        $('#charCount').text(remaining);
        if (remaining < 0) {
            // 如果超过限制，截断输入的文本
            $(this).val($(this).val().substr(0, maxLength));
            $('#charCount').text(0);
        }
    });

</script>
</body>
</html>
