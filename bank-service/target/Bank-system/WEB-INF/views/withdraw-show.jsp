<%--
  Created by IntelliJ IDEA.
  User: tgp
  Date: 2023/9/13
  Time: 15:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>左上角显示的表单</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        .container {
            display: flex;
            justify-content: flex-start; /* 左对齐 */
            align-items: flex-start; /* 上对齐 */
            height: 100vh;
            padding: 20px; /* 添加一些内边距 */
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

    <%
        User user = (User)pageContext.getSession().getAttribute("loginUser");
    %>

</head>
<body>
<div class="container">
    <div class="form-container">
        <form>
            <div class="form-group">
                <label for="amount">取款金额：</label>
                <input type="text" class="form-control" id="amount" placeholder="请输入取款金额">
            </div>
            <button type="button" class="btn btn-primary btn-block" onclick="deposit()">提交</button>

        </form>
    </div>
</div>

<script>

    function deposit() {

        var money = document.getElementById("amount").value
        var username = '<%= user.getUserName() %>'
        var password = '<%= user.getPassWord() %>'
        var formData = {

            "username": username,
            "money": money,
            "password": password

        }

        axios.post('${pageContext.request.contextPath}/withdraw', formData)
            .then(response => {
                console.log(response)
                if (response.data.code === 201) {
                    alert(response.data.message)
                } else {
                    alert(response.data.message)
                    window.location.href = "${pageContext.request.contextPath}/index"
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
