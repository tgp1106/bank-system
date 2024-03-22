<%--
  Created by IntelliJ IDEA.
  User: tgp
  Date: 2023/9/13
  Time: 17:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ page import="entity.User" %>
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
        <label for="money">转账金额：</label>
        <input type="text" class="form-control" id="money" placeholder="请输入要转账的金额">
      </div>
      <div class="form-group">
        <label for="transferee">转账人：</label>
        <input type="text" class="form-control" id="transferee" placeholder="请输入转入人的姓名">
      </div>
      <button type="button" class="btn btn-primary btn-block" onclick="transfer()">提交</button>

    </form>
  </div>
</div>

<script>

  function transfer() {

    var money = document.getElementById("money").value
    var transferee = document.getElementById("transferee").value
    var username = '<%= user.getUserName() %>'
    var password = '<%= user.getPassWord() %>'
    var formData = {

      "userName": username,
      "money": money,
      "transferee": transferee,
      "passWord":password

    }

    axios.post('${pageContext.request.contextPath}/transfer', formData)
            .then(response => {
              console.log(response)
              if (response.data.code === 201) {
                alert(response.data.message)
              } else {
                alert(response.data.data)
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
