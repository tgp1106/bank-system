<%@ page import="entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <%
        User user = (User)pageContext.getSession().getAttribute("loginUser");
    %>

    <title>用户主页</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            background-image: url("https://pic.rmb.bdstatic.com/bjh/news/6bf485d5ac92e530691b48765b98c9c8383.jpeg");
            background-size: cover;
            background-repeat: no-repeat;
        }
        .menu {
            width: 20%;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
        }
        .content{
            width: 75%;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
        }
        .button-group {
            display: flex;
            flex-direction: column;
            gap: 10px;
            align-items: center;
        }
        .separator {
            width: 1px;
            background-color: #ccc;
            height: 100%; /* 设置高度为100%以撑开整个父容器 */
            margin: 0 20px; /* 添加一些间距 */
        }
        .center-div {
            position: absolute;
            top: 50%;
            left: 60%;
            transform: translate(-50%, -50%);
        }
        .announcement {
            background-color: rgba(255, 255, 255, 0.8);
            width: 30%;
            height: 100%;
            padding: 20px;
        }
    </style>
</head>
<body>
<div style="display: flex;">
    <div class="announcement" >
        <h2 style="text-align: center;">公告</h2>
        <div>

        </div>
    </div>
    <div class="content" style="width: 70%; padding: 20px;">
        <div id="pageContent1" >
            <h2 style="text-align: center;">银行账户管理系统</h2>
            <div style="position: absolute; top: 10px; right: 10px;">
                <button class="btn btn-danger" style="font-size: 10px;" onclick="window.location.href='${pageContext.request.contextPath}/logout'">退出登录</button>
            </div>
        </div>
        <div id="pageContent" style="text-align: center;">
            <!-- 初始页面内容 -->
            <div class="center-div" style="width: 20%; padding: 20px;">
                <div class="button-group">
                    <h4>
                <span style="display: flex; align-items: center;">余额：
                    <span id="balanceValue" style="display: inline-block;"></span>
                    <span id="eyeIcon" class="fas fa-eye" style="cursor: pointer;" onclick="toggleBalance()"></span>
                    <span id="eyeSlashIcon" class="fas fa-eye-slash" style="cursor: pointer; display: none;" onclick="toggleBalance()"></span>
                </span>
                    </h4>
                    <button class="btn btn-primary btn-block" onclick="loadPage('${pageContext.request.contextPath}/deposit')">存款</button>
                    <button class="btn btn-secondary btn-block" onclick="loadPage('${pageContext.request.contextPath}/withdraw')">取款</button>
                    <button class="btn btn-success btn-block" onclick="loadPage('${pageContext.request.contextPath}/transfer')">转账</button>
                    <button class="btn btn-warning btn-block" onclick="loadPage('${pageContext.request.contextPath}/modify')">修改用户信息</button>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script>
    $(document).ready(function() {
        updateBalance();
        toggleBalance(); // 初始状态设为隐藏
    });

    function updateBalance() {
        $.ajax({
            url: '${pageContext.request.contextPath}/updateBalance',
            type: 'GET',
            success: function(response) {
                console.log(response);
                var balance = response;
                $('#balanceValue').text(balance); // 更新余额显示的元素
            },
            error: function(xhr, status, error) {
                console.log('Error updating balance:', error);
            }
        });
    }

    function toggleBalance() {
        var eyeIcon = document.getElementById("eyeIcon");
        var eyeSlashIcon = document.getElementById("eyeSlashIcon");
        var balanceValue = document.getElementById("balanceValue");

        if (eyeIcon.style.display !== "none") {
            eyeIcon.style.display = "none";
            eyeSlashIcon.style.display = "inline-block";
            balanceValue.style.display = "none"; // 隐藏余额值
        } else {
            eyeIcon.style.display = "inline-block";
            eyeSlashIcon.style.display = "none";
            balanceValue.style.display = "block"; // 显示余额值
        }
    }

    function loadPage(url) {
        $.get(url, function(data) {
            $('#pageContent').html(data);
        });
    }

</script>

</body>
</html>
