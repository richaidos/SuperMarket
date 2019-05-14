<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/resources/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" sizes="96x96" href="${pageContext.request.contextPath}/resources/assets/img/favicon.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Supermarket</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


    <!-- Bootstrap core CSS     -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/paper-dashboard.css" rel="stylesheet"/>

    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/demo.css" rel="stylesheet" />

    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
    <link href="${pageContext.request.contextPath}/resources/assets/css/themify-icons.css" rel="stylesheet">
    <script type="text/JavaScript"
            src="${pageContext.request.contextPath}/resources/js/jquery-1.9.1.min.js">
    </script>

    <script type="text/javascript">
        function doAjax() {
            var inputText = $("#writteus").val();
            $.ajax({
                url : 'getUserName',
                type: 'GET',
                dataType: 'json',
                contentType: 'application/json',
                mimeType: 'application/json',
                data : ({
                    text: inputText
                }),
                success: function (data) {
                    console.log(data);
                    if(inputText.length > 1) {
                        if (data != true) {
                            $("#result_text").text("Such login does not exist");
                            $('#result_text').css('color', 'red');
                        } else {
                            $("#result_text").text("Login is found");
                            $('#result_text').css('color', 'green');
                        }
                    }else{
                        $("#result_text").text("Please fill login input");
                        $('#result_text').css('color', 'black');
                    }
                    /*
                    var result = '"'+data.text+'", '+data.count+' characters';
                    $("#result_text").text(result);*/
                }
            });
        }
    </script>
</head>

<body>
<div class="login-page">
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">Supermarket MVC</a>
            </div>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="ti-panel"></i>
                        <p>Login Form</p>
                    </a>
                </li>
            </ul>
        </div>
    </nav>
</div>



<div class="content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="header">
                        <h4 class="title">Authorization Form</h4>
                        <p class="category">Log in using your username and password</p>
                    </div>
                    <div class="content table-responsive table-full-width">
                        <form action="auth" method="POST">
                            <table class="table table-striped">
                                <tbody>
                                <tr>
                                    <th>Login</th>
                                    <td>
                                        <input class="form-control border-input myinputclass" type="text" id="writteus" name="login" placeholder="login" onblur="doAjax()" required>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Password</th>
                                    <td><input class="form-control border-input myinputclass" type="password" name="password" placeholder="password" required></td>
                                </tr>
                                <tr>
                                    <th>Login Status</th>
                                    <td>
                                        <span id="result_text"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Submit</th>
                                    <td><button type="submit" class="btn btn-default">Log in</button></td>
                                </tr>
                                </tbody>
                            </table>
                        </form>

                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<footer class="footer">
    <div class="container-fluid">
        <div class="copyright pull-center">
            &copy; <script>document.write(new Date().getFullYear())</script>, made by <a href="https://vk.com/richaidos">Baktaev Aidos</a>
        </div>
    </div>
</footer>


</div>



</body>

<!--   Core JS Files
<script src="${pageContext.request.contextPath}/resources/assets/js/jquery-1.10.2.js" type="text/javascript"></script>-->
<script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js" type="text/javascript"></script>

<!--  Checkbox, Radio & Switch Plugins -->
<script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-checkbox-radio.js"></script>

<!--  Charts Plugin -->
<script src="${pageContext.request.contextPath}/resources/assets/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-notify.js"></script>

<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>

<!-- Paper Dashboard Core javascript and methods for Demo purpose -->
<script src="${pageContext.request.contextPath}/resources/assets/js/paper-dashboard.js"></script>

<!-- Paper Dashboard DEMO methods, don't include it in your project! -->
<script src="${pageContext.request.contextPath}/resources/assets/js/demo.js"></script>


</html>
