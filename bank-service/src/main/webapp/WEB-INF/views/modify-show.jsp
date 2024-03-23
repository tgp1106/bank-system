<%--
  Created by IntelliJ IDEA.
  User: tgp
  Date: 2023/9/13
  Time: 20:56
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
                <label for="password">用户密码</label>
                <input type="text" class="form-control" id="password" placeholder="请输入新的用户密码">
            </div>
            <div class="form-group">
                <label for="phone">用户手机号</label>
                <input type="text" class="form-control" id="phone" placeholder="请输入新的用户手机号">
            </div>
            <div class="form-group">
                <div>修改头像</div>
                <input type="file" class="form-control-file" id="file" accept="image/*">
            </div>
            <button type="button" class="btn btn-primary btn-block" onclick="modify()">提交</button>
        </form>
    </div>
    <!-- Bootstrap 模态框 -->
    <div class="modal fade" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    只能选择一张图片，请重新选择！
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    let fileName = "";
    // 文件上传函数
    function uploadFile(file) {
        var formData = new FormData();
        formData.append('file', file);
        return axios.post('${pageContext.request.contextPath}/uploadFile', formData)
            .then(response => {
                console.log(response);
                return response.data.data;
            })
            .catch(error => {
                console.error('文件上传失败:', error);
                return null;
            });
    }
    document.getElementById('file').addEventListener('change', function() {
        var fileInput = this;
        if (fileInput.files.length > 1) {
            $('#myModal').modal('show'); // 显示模态框
            fileInput.value = ''; // 清空文件输入框
            return;
        }
        var file = this.files[0];
        // 上传文件
        uploadFile(file)
            .then(fileUrl => {
                if (fileUrl) {
                    // 文件上传成功，提交表单
                    fileName = fileUrl;
                } else {
                    console.error('获取文件访问地址失败');
                }
            });
    });

    function modify() {

        var phone = document.getElementById("phone").value
        var password = document.getElementById("password").value
        var username = '<%= user.getUserName() %>'
        var formData = {
            "userName":username,
            "phone":phone,
            "passWord": password,
            "fileUrl": fileName,
        }
        console.log("表单提交" + fileName);
        axios.post('${pageContext.request.contextPath}/modify', formData)
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
