<%--
  Created by IntelliJ IDEA.
  User: tgp
  Date: 2023/9/13
  Time: 10:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html>
<head>
    <title>居中显示的表单</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.bootcdn.net/ajax/libs/vue/2.5.0/vue.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/axios/1.3.6/axios.min.js"></script>
    <style>
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            max-width: 400px;
            width: 100%;
        }
        .form-group {
            margin-bottom: 20px;
        }
    </style>

</head>
<body>
<div class="container">
    <div class="form-container">
        <h2 class="text-center">注册界面</h2>
        <form>
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" class="form-control" id="username" placeholder="请输入用户名">
            </div>
            <div class="form-group">
                <label for="password">用户密码</label>
                <input type="text" class="form-control" id="password" placeholder="请输入用户密码">
            </div>
            <div class="form-group">
                <label for="phone">用户手机号</label>
                <input type="text" class="form-control" id="phone" placeholder="请输入用户手机号">
            </div>
            <button type="button" class="btn btn-primary btn-block" onclick="register()">提交</button>
            <button type="button" class="btn btn-primary btn-block" onclick="window.location.href='login.jsp'">返回到登录页面</button>
        </form>
    </div>
</div>

<script>

    function register() {

        var username = document.getElementById("username").value
        var password = document.getElementById("password").value
        var phone = document.getElementById("phone").value

        var formData = {
            "userName": username,
            "passWord": password,
            "phoneNumber":phone
        }



        axios.post('${pageContext.request.contextPath}/toregister', formData)
            .then(response => {
                console.log(response)
                if (response.data.code === 201) {
                    alert(response.data.message)
                } else {
                    alert(response.data.data)
                }
            })
            .catch(error => {
                this.message = error.response.data.message;
                // 处理失败的情况
            });
    }

</script>
<script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
