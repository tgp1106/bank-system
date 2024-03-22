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
            background-image: url("https://img.yipic.cn/thumb/9c037f39/93f91b6f/044fd82a/258478d9/big_9c037f3993f91b6f044fd82a258478d9.png?x-oss-process=image/format,webp/sharpen,100");
            background-size: cover;
            background-repeat: no-repeat;
        }
        .login-container {
            width: 600px;
            height: 315px;
            margin: 0 auto;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            border-radius: 15px;
            box-shadow: 0 10px 50px 0px rgb(59, 45, 159);
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
        <div class="title"><span>登录</span></div>
        <div class="input-container">
            <input id="username" type="text" name="username" placeholder="用户名">
            <input id="password" type="password" name="password" placeholder="密码">
        </div>
        <div >
            <span class="message-container" onclick="window.location.href='retrievepassword.jsp'">忘记密码</span>
            <span class="message-container" onclick="window.location.href='administer.jsp'">管理界面</span>
            <span class="message-container" onclick="redirectToRegister()">注册</span>
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
            <span onclick="login()">提交</span>
        </div>
    </div>
</div>
<script>
    function redirectToRegister() {
        window.location.href = "register.jsp";
    }
    function login() {

        var username = document.getElementById("username").value
        var password = document.getElementById("password").value

        var formData = {
            "username": username,
            "password": password
        }


        axios.post('/login', formData)
            .then(response => {
                if (response.data.code === 201) {
                    alert(response.data.message)
                } else {
                    window.location.href = "${pageContext.request.contextPath}/index"
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
