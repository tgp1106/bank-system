<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>银行管理系统</title>

    <script src="https://cdn.bootcdn.net/ajax/libs/vue/2.5.0/vue.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/axios/1.3.6/axios.min.js"></script>

    <style>
        * {
            padding: 0;
            margin: 0;
        }
        html {
            height: 100%;
        }
        body {
            background-image: url("https://hbimg.huabanimg.com/e0521a52048c95a29a91093df25eb59e6bb6b56356b8d-cBipCD_fw658");
            background-size: cover;
            background-repeat: no-repeat;
        }
        .login-container {
            width: 600px;
            height: 315px;
            margin: 0 auto;
            margin-top: 10%;
            border-radius: 15px;
            box-shadow: 0 10px 50px 0px rbg(59, 45, 159);
            background-color: rgb(95, 76, 194);
        }
        .left-container {
            display: inline-block;
            width: 330px;
            border-top-left-radius: 15px;
            border-bottom-left-radius: 15px;
            padding: 60px;
            background-image: linear-gradient(to bottom right, rgb(118, 76, 163), rgb(92, 103, 211));
        }
        .title {
            color: #fff;
            font-size: 18px;
            font-weight: 200;
        }
        .title span {
            border-bottom: 3px solid rgb(237, 221, 22);
        }
        .input-container {
            padding: 20px 0;
        }
        input {
            border: 0;
            background: none;
            outline: none;
            color: #fff;
            margin: 20px 0;
            display: block;
            width: 100%;
            padding: 5px 0;
            transition: .2s;
            border-bottom: 1px solid rgb(199, 191, 219);
        }
        input:hover {
            border-bottom-color: #fff;
        }
        ::-webkit-input-placeholder {
            color: rgb(199, 191, 219);
        }
        .message-container {
            font-size: 14px;
            transition: .2s;
            color: rgb(199, 191, 219);
            cursor: pointer;
        }
        .message-container:hover {
            color: #fff;
        }
        .right-container {
            width: 145px;
            display: inline-block;
            height: calc(100% - 120px);
            vertical-align: top;
            padding: 60px 0;
        }
        .regist-container {
            text-align: center;
            color: #fff;
            font-size: 18px;
            font-weight: 200;
        }
        .regist-container span {
            border-bottom: 3px solid rgb(237, 221, 22);
        }
        .action-container {
            font-size: 10px;
            color: #fff;
            text-align: center;
            position: relative;
            top: 200px;
        }
        .action-container span {
            border: 1px solid rgb(237, 221, 22);
            padding: 10px;
            display: inline;
            line-height: 20px;
            border-radius: 20px;
            position: absolute;
            bottom: 10px;
            left: calc(72px - 20px);
            transition: .2s;
            cursor: pointer;
        }
        .action-container span:hover {
            background-color: rgb(237, 221, 22);
            color: rgb(95, 76, 194);
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="left-container">
        <div class="title"><span>管理员登录</span></div>
        <div class="input-container">
            <input id="administrator_name" type="text" name="administrator_name" placeholder="管理员名">
            <input id="administrator_password" type="password" name="administrator_password" placeholder="密码">
        </div>
        <div >
            <span class="message-container" onclick="window.location.href='login.jsp'">返回用户登录界面</span>
        </div>
        <%
            String message = request.getParameter("message");
            if (message != null && message.equals("expired")) {
        %>
        <p style="color: red;">用户身份过期或未登录，请登录后再尝试</p>
        <%
        } else {
        %>
        <p style="display: none;"></p>
        <%
            }
        %>
    </div>
    <div class="right-container">
        <div class="action-container">
            <span onclick="admin()">提交</span>
        </div>
    </div>
</div>
<script>

    function admin() {

        var administrator_name = document.getElementById("administrator_name").value
        var administrator_password = document.getElementById("administrator_password").value

        var formData = {
            "administrator_name": administrator_name,
            "administrator_password": administrator_password
        }


        axios.post('/administrator', formData)
            .then(response => {
                if (response.data.code === 201) {
                    alert(response.data.message)
                } else {
                    window.location.href = "${pageContext.request.contextPath}/admin"
                }
            })
            .catch(error => {
                this.message = error.response.data.message;
                // 处理失败的情况
            });
    }
</script>
</body>
</html>

