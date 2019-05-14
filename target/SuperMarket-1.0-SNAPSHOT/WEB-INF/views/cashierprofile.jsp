<%@ page import="com.supermarket.models.Users" %>
<%@ page import="java.util.List" %>
<%@ page import="com.supermarket.models.TransactionHistory" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/resources/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" sizes="96x96" href="${pageContext.request.contextPath}/resources/assets/img/favicon.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Profile</title>

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
    <link href="${pageContext.request.contextPath}/resources/assets/css/style.css" rel="stylesheet" />

    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
    <link href="${pageContext.request.contextPath}/resources/assets/css/themify-icons.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/assets/js/jquery-1.10.2.js" type="text/javascript"></script>
</head>
<body>
<%
    Users user = (Users)session.getAttribute("userData");

    List<TransactionHistory> historyList = null;
    if(null != request.getAttribute("historyList")){
        historyList = (List<TransactionHistory>)request.getAttribute("historyList");
    }

%>


<script>
    function doCheck() {
        var inputText1 = $("#password").val();
        var inputText2 = $("#confirm_password").val();
        if(inputText2.length > 0 || inputText1.length > 0) {
            if (inputText1 == inputText2) {
                $('#message').html('Matching').css('color', 'green');
                $("#updatebutton").prop("disabled",false);
            } else {
                $('#message').html('Not Matching').css('color', 'red');
                $("#updatebutton").prop("disabled",true);
            }
        }else{
            $('#message').html('').css('color', 'black');
            $("#updatebutton").prop("disabled",false);
        }
    }
//
//    function checkaddUserStatus() {
//        if($("#addcashierform").hasClass("is-active")){
//            $('#addcashierform').removeClass('is-active');
//            $("#statusicon").css({ WebkitTransform: 'rotate(' + 0 + 'deg)'});
//        }else{
//            $('#addcashierform').addClass('is-active');
//            $("#statusicon").css({ WebkitTransform: 'rotate(' + 45 + 'deg)'});
//        }
//    }
    

</script>
<div class="wrapper">
    <div class="sidebar" data-background-color="white" data-active-color="danger">

        <!--
            Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black"
            Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
        -->

        <div class="sidebar-wrapper">
            <div class="logo">
                <a href="/profile" class="simple-text">
                    Supermarket
                </a>
            </div>

            <ul class="nav">
                <li class="active">
                    <a href="profile">
                        <i class="ti-user"></i>
                        <p>User Profile</p>
                    </a>
                </li>
                <li>
                    <a href="newtransaction">
                        <i class="ti-bag"></i>
                        <p>New Transaction</p>
                    </a>
                </li>
                <li>
                    <a href="transactionhistory">
                        <i class="ti-write"></i>
                        <p>Transaction History</p>
                    </a>
                </li>

            </ul>
        </div>
    </div>

    <div class="main-panel">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar bar1"></span>
                        <span class="icon-bar bar2"></span>
                        <span class="icon-bar bar3"></span>
                    </button>
                    <a class="navbar-brand" href="#">User Profile</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="logout">
                                <i class="ti-settings"></i>
                                <p>Logout</p>
                            </a>
                        </li>
                    </ul>

                </div>
            </div>
        </nav>

        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-4 col-md-5">
                        <div class="card card-user">
                            <div class="content">
                                <div class="author">
                                    <img class="avatar border-white" src="${pageContext.request.contextPath}/resources/assets/img/faces/face-<%if(user.getRole().getName().equals("ADMIN"))out.print("2");else out.print("0");%>.jpg" alt="..."/>
                                    <h4 class="title"><%out.print(user.getName());%><br />
                                        <small><%out.print(user.getRole().getName());%></small>
                                    </h4>
                                </div>
                            </div>
                            <hr>
                            <div class="text-center">
                                <div class="row">
                                    <div class="col-md-5 col-md-offset-1">
                                        <h5><%out.print(historyList.size());%><br /><small>Transactions</small></h5>
                                    </div>
                                    <div class="col-md-5">
                                        <a href="newtransaction"><h5><i class="ti-clipboard"></i><br /><small>New Transaction</small></h5></a>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8 col-md-7">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Edit Profile</h4>
                            </div>
                            <div class="content">
                                <form action="editprofile" method="post">
                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label>ID</label>
                                                <input disabled name="userid" type="text" class="form-control border-input" placeholder="ID" value="<%out.print(user.getId());%>">
                                                <input name="myuserid" type="hidden" placeholder="ID" value="<%out.print(user.getId());%>">

                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label>Role</label>
                                                <input type="text" class="form-control border-input" disabled placeholder="Role" value="<%out.print(user.getRole().getName());%>">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Login</label>
                                                <input type="text" name="login" class="form-control border-input" placeholder="Login" value="<%out.print(user.getLogin());%>">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>User name</label>
                                                <input name="username" type="text" class="form-control border-input" placeholder="User name" value="<%out.print(user.getName());%>">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Old Password</label>
                                                <input required name="oldpassword" id="oldpassword" type="password" class="form-control border-input" placeholder="Old Password">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>New Password</label>
                                                <input onkeyup="doCheck()" name="newpassword" id="password" type="password" class="form-control border-input" placeholder="New Password">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>Conform Password</label>
                                                <input onkeyup="doCheck()" name="confirm_password" id="confirm_password" type="password" class="form-control border-input" placeholder="Conform Password">
                                            </div>
                                            <span id="message"></span>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <button id="updatebutton" type="submit" class="btn btn-info btn-fill btn-wd">Update Profile</button>
                                    </div>
                                    <div class="clearfix"></div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div id="transactionHistory" class="col-lg-12 col-md-7">

                            <div class="content">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="header">
                                                <h4 class="title">Transaction History</h4>
                                            </div>
                                            <div class="content table-responsive table-full-width">
                                                <table class="table table-striped">
                                                    <thead>
                                                    <th>ID</th>
                                                    <th>Item ID</th>
                                                    <th>Amount</th>
                                                    <th title="Sorted by time (ORDER BY desc)">Time</th>
                                                    <th>Cashier ID</th>
                                                    <th>Total Cost</th>
                                                    </thead>
                                                    <tbody>
                                                    <%
                                                        if(historyList!=null){
                                                            for(TransactionHistory t: historyList){
                                                    %>
                                                    <tr>
                                                        <td><%out.print(t.getId());%></td>
                                                        <td title="<%out.print(t.getItemId().getName());%>"><%out.print(t.getItemId().getId());%></td>
                                                        <td><%out.print(t.getAmount());%></td>
                                                        <td><%out.print(t.getTransactionTime());%></td>
                                                        <td title="<%out.print(t.getUsers().getName());%>"><%out.print(t.getUsers().getId());%></td>
                                                        <td><%out.print(t.getItemId().getPrice()*t.getAmount());%> Tenge</td>
                                                    </tr>

                                                    <%
                                                            }
                                                        }
                                                    %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                    </div>

                    <%--<div class="col-lg-8 col-md-7">--%>
                        <%--<div class="card">--%>
                            <%--<div class="header">--%>
                                <%--<h4 class="title">Actions</h4>--%>
                            <%--</div>--%>
                            <%--<div class="content">--%>
                                <%--<p>Here must be links</p>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
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
</div>


</body>

<!--   Core JS Files   -->

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
