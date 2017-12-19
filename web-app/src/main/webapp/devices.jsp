
<%@include file="includes/authenticate.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Weather station List</title>

    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/material-icons.css" rel="stylesheet" />
    <link href="css/material-dashboard.css" rel="stylesheet" />
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/updates.css" rel="stylesheet">

</head>
<body>
<div class="wrapper">
    <%@include file="includes/nav-menu.jsp" %>
    <div class="sidebar" data-color="blue" data-image="images/login_bg2.jpg">
        <!--
    Tip 1: You can change the color of the sidebar using: data-color="purple | blue | green | orange | red"

    Tip 2: you can also add an image using data-image tag
-->
        <div class="logo">
            <a href="#" class="simple-text">
                <strong>Weather</strong>Station
            </a>
        </div>

        <div class="sidebar-wrapper">
            <form class="searchbox_1" action="">
                <input type="search" id="search" class="search_1" placeholder="Search by device name"/>
            </form>
        </div>
    </div>
    <div class="main-withoutSidebar">

        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card card-plain">
                            <div class="card-header" data-background-color="blue">
                                <h4 class="title">Weather stations enrolled</h4>
                                <p class="category">Below are the list of weather stations enrolled with the server</p>
                                <table style="width:100%">
                                    <tr>
                                        <th><button class="btn btn-white" data-toggle="modal" data-target="#newDeviceModal">Add
                                            Weather station
                                        </button></th>
                                        <th><button class="btn btn-white pull-right"   data-toggle="modal" data-target="#paginate">Paginate
                                        </button></th>
                                        <th><button class="btn btn-white" onclick="getAllDevices(),removeNav();">
                                            <i class="material-icons">refresh</i>Refresh Table
                                        </button></th>
                                    </tr>
                                </table>

                                <%--Popup modal for adding new device--%>
                                <div class="modal fade" id="newDeviceModal" tabindex="-1" role="dialog"
                                     aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal"
                                                        aria-hidden="true">&times
                                                </button>
                                                <h4 class="modal-title" id="myModalLabel" style="color:cornflowerblue;">Enter
                                                    Weather station
                                                    Details</h4>
                                            </div>
                                            <form id="new-device-form" method="post">
                                                <div class="form-group" style="padding-left: 10%; padding-right: 10%;">
                                                    <input type="text" name="deviceId" id="deviceId" value=""
                                                           placeholder="Device ID"
                                                           class="form-control" />
                                                </div>
                                                <div class="form-group" style="padding-left: 10%; padding-right: 10%;">
                                                    <input type="text" value="" placeholder="Device Name"
                                                           name="deviceName" id="deviceName"
                                                           class="form-control" />
                                                </div>
                                                <div class="form-group" style="padding-left: 10%; padding-right: 10%;">
                                                    <input type="text" value="" placeholder="Device description"
                                                           name="deviceDesc" id="deviceDesc"
                                                           class="form-control" />
                                                </div>
                                            </form>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default btn-simple"
                                                        data-dismiss="modal">Close
                                                </button>
                                                <button type="button" class="btn btn-info btn-simple"
                                                        onclick="addNewDevice()">Add
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%--Popup modal for paginating--%>
                                <div class="modal fade" id="paginate" tabindex="-1" role="dialog"
                                     aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal"
                                                        aria-hidden="true">&times
                                                </button>
                                                <h4 class="modal-title"  style="color:cornflowerblue;">Paginate Options</h4>
                                            </div>
                                            <form id="paginate-form" method="post">
                                                <div class="form-group" style="padding-left: 10%; padding-right: 10%;">
                                                    <input type="number" name="paginateNum" id="paginateNum" value=""
                                                           placeholder="Paginate number"
                                                           class="form-control" />
                                                </div>
                                            </form>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default btn-simple"
                                                        data-dismiss="modal">Close
                                                </button>
                                                <button type="button" class="btn btn-info btn-simple"
                                                        onclick="removeNav();paginate(document.getElementById('paginateNum').value)">Paginate
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%--Popup modal for editing share settings--%>
                                <div class="modal fade" id="shareSettingsModal" tabindex="-1" role="dialog"
                                     aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal"
                                                        aria-hidden="true">&times;
                                                </button>
                                                <h4 class="modal-title" id="myModalLabel2" style="color:purple;">Edit
                                                    Share
                                                    Settings</h4>
                                            </div>
                                            <%--<div class="modal-body" style="color:black;">--%>
                                            <%--Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean. A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth. Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.--%>
                                            <%--</div>--%>
                                            <form>
                                                <div class="form-group" style="padding-left: 10%; padding-right: 10%;">
                                                    <input type="text" value="" placeholder="User ID"
                                                           class="form-control" />
                                                </div>
                                                <%--<div class="form-group" style="padding-left: 10%; padding-right: 10%;">--%>
                                                <%--<input type="text" value="" placeholder="Device Name" class="form-control" />--%>
                                                <%--</div>--%>
                                                <%--<div class="form-group" style="padding-left: 10%; padding-right: 10%;">--%>
                                                <%--<input type="text" value="" placeholder="Device description" class="form-control" />--%>
                                                <%--</div>--%>
                                            </form>
                                            <div style="margin-right: 10%; margin-left: 10%">
                                                <table class="table" style="font-size: 15px">
                                                    <thead>
                                                    <tr>
                                                        <th class="text-center">#</th>
                                                        <th>Name</th>
                                                        <th class="text-left">Actions</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <tr>
                                                        <td class="text-center">1</td>
                                                        <td>Andrew Mike</td>
                                                        <td class="td-actions text-right">
                                                            <button type="button" rel="tooltip" title="View Profile"
                                                                    class="btn btn-info btn-simple btn-xs">
                                                                <i class="fa fa-user"></i>
                                                            </button>
                                                            <button type="button" rel="tooltip" title="Remove"
                                                                    class="btn btn-danger btn-simple btn-xs">
                                                                <i class="fa fa-times"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-center">2</td>
                                                        <td>John Doe</td>
                                                        <td class="td-actions text-right">
                                                            <button type="button" rel="tooltip" title="View Profile"
                                                                    class="btn btn-info btn-simple btn-xs">
                                                                <i class="fa fa-user"></i>
                                                            </button>
                                                            <button type="button" rel="tooltip" title="Remove"
                                                                    class="btn btn-danger btn-simple btn-xs">
                                                                <i class="fa fa-times"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-center">3</td>
                                                        <td>Alex Mike</td>
                                                        <td class="td-actions text-right">
                                                            <button type="button" rel="tooltip" title="View Profile"
                                                                    class="btn btn-info btn-simple btn-xs">
                                                                <i class="fa fa-user"></i>
                                                            </button>
                                                            <button type="button" rel="tooltip" title="Remove"
                                                                    class="btn btn-danger btn-simple btn-xs">
                                                                <i class="fa fa-times"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-center">3</td>
                                                        <td>Alex Mike</td>
                                                        <td class="td-actions text-right">
                                                            <button type="button" rel="tooltip" title="View Profile"
                                                                    class="btn btn-info btn-simple btn-xs">
                                                                <i class="fa fa-user"></i>
                                                            </button>
                                                            <button type="button" rel="tooltip" title="Remove"
                                                                    class="btn btn-danger btn-simple btn-xs">
                                                                <i class="fa fa-times"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-center">3</td>
                                                        <td>Alex Mike</td>
                                                        <td class="td-actions text-right">
                                                            <button type="button" rel="tooltip" title="View Profile"
                                                                    class="btn btn-info btn-simple btn-xs">
                                                                <i class="fa fa-user"></i>
                                                            </button>
                                                            <button type="button" rel="tooltip" title="Remove"
                                                                    class="btn btn-danger btn-simple btn-xs">
                                                                <i class="fa fa-times"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-center">3</td>
                                                        <td>Alex Mike</td>
                                                        <td class="td-actions text-right">
                                                            <button type="button" rel="tooltip" title="View Profile"
                                                                    class="btn btn-info btn-simple btn-xs">
                                                                <i class="fa fa-user"></i>
                                                            </button>
                                                            <button type="button" rel="tooltip" title="Remove"
                                                                    class="btn btn-danger btn-simple btn-xs">
                                                                <i class="fa fa-times"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-center">3</td>
                                                        <td>Alex Mike</td>
                                                        <td class="td-actions text-right">
                                                            <button type="button" rel="tooltip" title="View Profile"
                                                                    class="btn btn-info btn-simple btn-xs">
                                                                <i class="fa fa-user"></i>
                                                            </button>
                                                            <button type="button" rel="tooltip" title="Remove"
                                                                    class="btn btn-danger btn-simple btn-xs">
                                                                <i class="fa fa-times"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default btn-simple"
                                                        data-dismiss="modal">Close
                                                </button>
                                                <button type="button" class="btn btn-info btn-simple">Save</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-content table-responsive">
                                <table class="table table-hover" id="devices-listing">
                                    <thead>
                                    <th>Device Name</th>
                                    <th>Temperature</th>
                                    <th>Humidity</th>
                                    <th>Owner</th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td colspan="6">Loading...</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div id="nav"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <footer class="footer" style="bottom: 0; position: relative; width: 10%;margin-right: 1%;float: right">
                <p class="copyright pull-right">
                    &copy;
                    <script>
                        document.write(new Date().getFullYear())
                    </script>
                    <a href="https://wso2.com/iot">WSO2 Inc.</a>
                </p>

            </footer>
        </div>

    </div>

</div>
</body>
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/material.min.js" type="text/javascript"></script>
<script src="js/nouislider.min.js" type="text/javascript"></script>
<script src="js/bootstrap-datepicker.js" type="text/javascript"></script>
<script src="js/material-kit.js" type="text/javascript"></script>
<script src="js/bootstrap-notify.js" type="text/javascript"></script>
<script src="js/material-dashboard.js" type="text/javascript"></script>
<script type="text/javascript">

 var devices=[];
 function firstFunction(_callback){
     // do some asynchronous work
     // and when the asynchronous stuff is complete
     getAllDevices();
     _callback();
 }

 function secondFunction(){
     // call first function and pass in a callback function which
     // first function runs when it has completed

 }

 function paginate(val){

     //$('#devices-listing tr').toggleClass('paginate');
     var rowsShown = parseInt(val);
     var rowsTotal = devices.length;

     var numPages = rowsTotal/rowsShown;
     for(i = 0;i < numPages;i++) {
         var pageNum = i + 1;
         $('#nav').append('<a href="#" rel="'+i+'">'+pageNum+'</a> ');
     }
     $('#devices-listing tbody tr').hide();
     $('#devices-listing tbody tr').slice(0, rowsShown).show();
     $('#nav a:first').addClass('active');
     $('#nav a').bind('click', function(){
         $('#nav a').removeClass('active');
         $(this).addClass('active');
         var currPage = $(this).attr('rel');
         var startItem = currPage * rowsShown;
         var endItem = startItem + rowsShown;
         $('#devices-listing tbody tr').css('opacity','0.0').hide().slice(startItem, endItem).
         css('display','table-row').animate({opacity:1}, 300);
         console.log(endItem);
     });
 }

function removeNav() {
    var myNode = document.getElementById("nav");
    while (myNode.firstChild) {
        myNode.removeChild(myNode.firstChild);
    }
}


    $(document).ready(function () {
        // Javascript method's body can be found in assets/js/demos.js
        //demo.initDashboardPageCharts();
        getAllDevices();



    });

    function getDevice(dev, index) {
        var devicesListing = $('#devices-listing');

        var lastKnownSuccess = function (data) {
            var record = JSON.parse(data).records[1];
            var temperature=null;
            var humidity=null;
            if (record) {
                temperature = record.values.tempf;
                humidity = record.values.humidity;
            }
           //console.log(data);
            var myRow = "<tr><a href='#" + dev.deviceIdentifier + "'><td>" + dev.name
                + "</td><td>"
                + (temperature) + "</td><td>" + (humidity) + "</td><td>"
                + dev.enrolmentInfo.owner + "</td><td>"
                + "<button class=\"btn btn-primary btn-fab btn-fab-mini btn-round\" onclick=\"window.location.href='details.jsp?id="+dev.deviceIdentifier+"'\">"
                + "<i class=\"material-icons\">remove_red_eye</i>"
                + "</button></td>"
                + "</a></tr>";
            devicesListing.find('tbody').append(myRow);
            var newIndex = index + 1;
            if (devices.length > newIndex) {
                getDevice(devices[newIndex], newIndex);
            }
            //function to implement the regex search bar
            var $rows = $('#devices-listing tbody tr');
            $('#search').keyup(function() {
                removeNav();
                var val = '^(?=.*\\b' + $.trim($(this).val()).split(/\s+/).join('\\b)(?=.*\\b') + ').*$',
                    reg = RegExp(val, 'i'),
                    text;

                $rows.show().filter(function() {
                    text = $(this).text().replace(/\s+/g, ' ');
                    return !reg.test(text);
                }).hide();});

        };
        $.ajax({
            type: "POST",
            url: "invoker/execute",
            data: {
                "uri": "/events/last-known/weatherstation/" + devices[index].deviceIdentifier,
                "method": "get"
            },
            success: lastKnownSuccess

        });
    }

    function getAllDevices() {
        var success = function (data) {
            devices = JSON.parse(data).devices;
            console.log(devices.length);
            var devicesListing = $('#devices-listing');
            if (devices && devices.length > 0) {
                devicesListing.find('tbody').empty();
                getDevice(devices[0], 0);
            } else {
                var myRow = "<tr><td colspan=\"6\" style=\"padding-top: 30px;\"><strong>No Devices Found</strong></td></tr>";
                devicesListing.find('tbody').replaceWith(myRow);
            }
        };
        $.ajax({
            type: "POST",
            url: "invoker/execute",
            data: {"uri": "/devices/?type=weatherstation&requireDeviceInfo=true&offset=0&limit=100", "method": "get"},
            success: success
        });
    }

    function addNewDevice() {
        var deviceId = $("#deviceId").val();
        var deviceName = $("#deviceName").val();
        var deviceDesc = $("#deviceDesc").val();

        var success = function (data) {
            var config = {};
            config.deviceType = "weatherstation";
            config.deviceName = deviceName;
            config.deviceId = deviceId;

            var configSuccess = function (data) {
                var appResult = JSON.parse(data);

                config.clientId = appResult.clientId;
                config.clientSecret = appResult.clientSecret;
                config.clientSecret = appResult.clientSecret;
                config.accessToken = appResult.accessToken;
                config.refreshToken = appResult.refreshToken;
                config.scope = appResult.scope;
                //downlaod a json file
                var dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(
                    JSON.stringify(config, null, 4));
                var dlAnchorElem = document.createElement('a');
                dlAnchorElem.setAttribute("href", dataStr);
                dlAnchorElem.setAttribute("download", deviceId + ".json");
                dlAnchorElem.setAttribute('visibility', 'hidden');
                dlAnchorElem.setAttribute('display', 'none');
                document.body.appendChild( dlAnchorElem);
                dlAnchorElem.click();
                $('#newDeviceModal').modal('hide');//hide popup after adding a device
                location.reload();//reload page after adding device
            };

            $.ajax({
                type: "GET",
                url: "config?deviceId=" + deviceId,
                success: configSuccess
            });
        };

        var payload = "{\n"
            + "\"name\": \"" + deviceName + "\",\n"
            + "\"deviceIdentifier\": \"" + deviceId + "\",\n"
            + "\"description\": \"" + deviceDesc + "\",\n"
            + "\"type\": \"weatherstation\",\n"
            + "\"enrolmentInfo\": {\"status\": \"ACTIVE\", \"ownership\": \"BYOD\"},\n"
            + "\"properties\": []\n"
            + "}";
        $.ajax({
            type: "POST",
            url: "invoker/execute",
            data: {"uri": "/device/agent/enroll", "method": "post", "payload": payload},
            success: success
        });
    }
</script>

</html>