<%--
  Created by IntelliJ IDEA.
  User: tgp
  Date: 2023/9/14
  Time: 16:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>居中显示的表单</title>
  <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://cdn.bootcdn.net/ajax/libs/vue/2.5.0/vue.min.js"></script>
  <script src="https://cdn.bootcdn.net/ajax/libs/axios/1.3.6/axios.min.js"></script>
</head>


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
    max-width: 600px;
    width: 100%;
  }
  .form-group {
    margin-bottom: 20px;
  }
  .send-code-btn {
    display: block; /* 设置为块级元素，使按钮独占一行 */
    margin-top: 10px;
  }
</style>

<div class="container">
  <div class="form-container">
    <h2 class="text-center">找回密码</h2>
    <form>
      <div class="form-group">
        <label for="username">用户名</label>
        <input type="text" class="form-control" id="username" placeholder="请输入用户名">
      </div>
      <div class="form-group">
        <label for="phone">用户手机号</label>
        <input type="text" class="form-control" id="phone" placeholder="请输入用户手机号">
      </div>
      <div class="form-group">
        <label for="newpassword">新的密码</label>
        <input type="password" class="form-control" id="newpassword" placeholder="请输入新的密码">
      </div>
      <button type="button" class="btn btn-primary send-code-btn" onclick="retrievepassword()">发送验证码</button>
      <div class="form-group">
        <label for="code">验证码</label>
        <input type="text" class="form-control" id="code" placeholder="请输入验证码">
      </div>
      <button type="button" class="btn btn-primary btn-block" onclick="findback()">找回密码</button>
      <button type="button" class="btn btn-primary btn-block" onclick="window.location.href='/login.jsp'">返回登录页面</button>
    </form>
  </div>
</div>


  <script>

  function retrievepassword() {

    var phone = document.getElementById("phone").value
    var username = document.getElementById("username").value
    var formData = {
      "userName":username,
      "phone":phone,

    }

    axios.post('${pageContext.request.contextPath}/retrievepassword', formData)
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

  function findback() {


    var userName = document.getElementById("username").value
    var code = document.getElementById("code").value
    var newPassword = document.getElementById("newpassword").value

    var formData2 = {
      "userName":userName,
      "code":code,
      "newPassword":newPassword
    }

    axios.post('${pageContext.request.contextPath}/findback', formData2)
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
