<%@ page import="entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html >
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%
        User user = (User)pageContext.getSession().getAttribute("loginUser");
        String url = user.getFileUrl();
    %>
    <title>用户主页</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-image: url("https://pic.rmb.bdstatic.com/bjh/news/6bf485d5ac92e530691b48765b98c9c8383.jpeg");
            background-size: cover;
            background-repeat: no-repeat;
        }

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
            height: 500px;
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
        .operator-div {
            list-style-type: none;
            padding: 0;
            height: 500px;
            overflow-y: auto; /* 垂直滚动条 */
        }
    </style>
</head>
<body>

<nav class="navbar" style="height: 10%;background-color: transparent">
    <h3 class="text-white" style="text-align: center;">银 行 管 理 系 统</h3>
    <div class="profile-info">
        <img src="${pageContext.request.contextPath}/imageProxy?imageName=<%=url%>" alt="" style="width: 40px; height: 40px; border-radius: 50%;">
        <button class="btn btn-primary btn-outline-light ml-2" style="margin-left: 15px;width: 100px;" onclick="backIndex()">返回主页</button>
        <button class="btn btn-danger btn-outline-light ml-2" style="margin-left: 15px;width: 100px;" onclick="window.location.href='${pageContext.request.contextPath}/logout'">退出登录</button>
    </div>
</nav>

<div class="container-fluid">
    <div class="row flex-container">
        <div class="col-md-3 left-area">
            <!-- 左侧区域内容 -->
            <h2 style="text-align: center;color: #5bc0de">公 告</h2>
            <div class="notice-board">
                <ul id="noticeList" class="notice-board-ul">
                </ul>
            </div>
        </div>
        <!-- 中间区域内容 -->
        <div class="center-div col-md-5 middle-area" style="width: 20%; padding: 20px;">
            <div id="pageContent" class="button-group">
                <h4>
                <span style="display: flex; align-items: center;">余额：
                    <span id="balanceValue" style="display: inline-block;"></span>
                    <span id="eyeIcon" class="fas fa-eye" style="cursor: pointer;" onclick="toggleBalance()"></span>
                    <span id="eyeSlashIcon" class="fas fa-eye-slash" style="cursor: pointer; display: none;"
                          onclick="toggleBalance()"></span>
                </span>
                </h4>
                <button class="btn btn-primary btn-block"
                        onclick="loadPage('${pageContext.request.contextPath}/deposit')">存款
                </button>
                <button class="btn btn-secondary btn-block"
                        onclick="loadPage('${pageContext.request.contextPath}/withdraw')">取款
                </button>
                <button class="btn btn-success btn-block"
                        onclick="loadPage('${pageContext.request.contextPath}/transfer')">转账
                </button>
                <button class="btn btn-warning btn-block"
                        onclick="loadPage('${pageContext.request.contextPath}/modify')">修改用户信息
                </button>
            </div>
        </div>
        <div class="col-md-4 right-area">
            <h2 class="text-white" style="text-align: center">操 作 记 录</h2>
            <div class="operator-div">
                <table class=" table mt-2 text-white">
                    <thead style="text-align: center">
                    <tr>
                        <th>时间</th>
                        <th>操作人</th>
                        <th>操作类型</th>
                        <th>交易金额(元)</th>
                        <th>转入者</th>
                    </tr>
                    </thead>
                    <tbody  id="transactionTableBody">

                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>
<script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        updateBalance();
        toggleBalance(); // 初始状态设为隐藏
        // 获取信息
        getNoticeList();
        // 获取转账信息
        getOperatorList();
    });

    function getOperatorList() {
        console.log("qqqq");
        $.ajax({
            url: '${pageContext.request.contextPath}/getOperatorList?username=<%=user.getUserName()%>',
            type: 'GET',
            success: function (result) {
                var ul = $('#transactionTableBody');
                console.log(result)
                $.each(result.data, function (index, item) {
                    ul.append('<tr>' +
                        '<td>' + item.operationTime + '</td>' +
                        '<td>' + item.operationUsername + '</td>' +
                        '<td>'  + item.operation + '</td>' +
                        '<td>' + item.operationAmount + '</td>' +
                        '<td>' + item.transferName  + '</td>' +
                        '</tr>');
                });
            },
            error: function () {
                console.log('Error occurred while fetching list items.');
            }
        });
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

    function updateBalance() {
        $.ajax({
            url: '${pageContext.request.contextPath}/updateBalance',
            type: 'GET',
            success: function (response) {
                console.log(response);
                var balance = response;
                $('#balanceValue').text(balance); // 更新余额显示的元素
                console.log("1111" + balance);
            },
            error: function (xhr, status, error) {
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
            balanceValue.style.display = "inline-block"; // 显示余额值
        }
    }

    function loadPage(url) {
        $.get(url, function (data) {
            $('#pageContent').html(data);
        });
    }

    function backIndex() {
        window.location.href = "${pageContext.request.contextPath}/index";
    }

</script>
</body>
</html>
