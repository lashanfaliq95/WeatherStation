<%@include file="includes/authenticate.jsp" %>

<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href="imagesg/apple-icon.png" />
    <link rel="icon" type="image/png" href="images/favicon.png" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>Material Dashboard by Creative Tim</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />
    <!-- Bootstrap core CSS     -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <!--  Material Dashboard CSS    -->
    <link href="css/material-dashboard.css?v=1.2.0" rel="stylesheet" />
    <link href="css/updates1.css" rel="stylesheet" />
    <link href="css/updates.css" rel="stylesheet"/>

    <!--  CSS for Demo Purpose, don't include it in your project     -->

    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300|Material+Icons' rel='stylesheet' type='text/css'>
</head>

<body>
<div class="wrapper">
    <div class="main-panel-full">
        <nav class="navbar navbar-transparent navbar-absolute">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#"> Table List </a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a id="redirect">
                                <i class="material-icons">history</i>
                                <p>Analytics</p>
                            </a>
                        </li>
                        <li >
                            <a href="./devices.jsp">
                                <p style="font-weight: bold;"><i class="material-icons">list</i>Device List</p>
                            </a>
                        </li>
                        <li class="dropdown pull-right">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="material-icons">person</i>
                                <%--<span class="notification">5</span>--%>
                                <p class="hidden-lg hidden-md">Profile</p>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="logout.jsp">Logout</a>
                                </li>
                            </ul>
                        </li>


                    </ul>
                </div>
            </div>
        </nav>
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-2">
                        <div class="card" id="temp" style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="red">
                                <div class="ct-chart" id="RealTimeTempChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Temperature</h4>
                                <p class="category">
                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimeTempLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="card" id='humid' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="blue">
                                <div class="ct-chart" id="RealTimeHumidityChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Humidity</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimeHumidLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="card" id='winddir' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="green">
                                <div class="ct-chart" id="RealTimeWindDirChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Wind Direction</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimeWindDirLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="card" id='windspeed' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="purple">
                                <div class="ct-chart" id="RealTimeWindSpeedChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Wind Speed</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimewindspeedmphLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="card" id='indoorTemp' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="orange">
                                <div class="ct-chart" id="RealTimeIndoorTempChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Indoor Temperature</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimeindoortempLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="card" id='indoorHumid' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="yellow">
                                <div class="ct-chart" id="RealTimeIndoorHumidityChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Indoor Humidity</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimeindoorhumidLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-2">
                        <div class="card" id='windgust' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="orange">
                                <div class="ct-chart" id="RealTimeWindGustChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Wind Gust</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimewindgustLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="card" id='dewpoint' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="purple">
                                <div class="ct-chart" id="RealTimeDewPointChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Dew Point</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimedewptfLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="card" id='windchill' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="red">
                                <div class="ct-chart" id="RealTimeWindChillChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Wind Chill</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimewindchillfLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="card" id='raining' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="yellow">
                                <div class="ct-chart" id="RealTimeRainingChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Raining</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimerainingLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="card" id='baromin' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="green">
                                <div class="ct-chart" id="RealTimeBarominChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Baromin</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimebarominLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="card" id='lowbatt' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="blue">
                                <div class="ct-chart" id="RealTimeLowbatChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Lowbatt</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimelowbattLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-2">
                        <div class="card" id='dailyraining' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="green">
                                <div class="ct-chart" id="RealTimeDailyRainingChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Daily Raining</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimedailyrainingLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="card" id='weeklyraining' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="yellow">
                                <div class="ct-chart" id="RealTimeWeeklyRainingChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Weekly raining</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimeweeklyrainingLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="card" id='monthlyraining' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="orange">
                                <div class="ct-chart" id="RealTimeMonthlyRainingChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Monthly Raining</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimemonthlyrainingLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="card" id='yearlyraining' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="purple">
                                <div class="ct-chart" id="RealTimeYearlyRainingChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Yearly Raining</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimeyearlyrainingLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="card" id='solarradiation' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="red">
                                <div class="ct-chart" id="RealTimeSolarRadiationChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Solar Radiation</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimesolarradiationLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="card" id='uv' style="cursor: pointer" onclick=redirect(this)>
                            <div class="card-header card-chart" data-background-color="blue">
                                <div class="ct-chart" id="RealTimeUltraVioletChart"></div>
                            </div>
                            <div class="card-content">
                                <h4 class="title">Ultra Violet</h4>
                                <p class="category">

                            </div>
                            <div class="card-footer">
                                <div class="stats" id="realtimeuvLastUpdated">
                                    <i class="material-icons">access_time</i> Yet to be updated
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <footer class="footer">
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
</body>
<script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/material.min.js" type="text/javascript"></script>
<!--  Charts Plugin -->
<script src="js/chartist.min.js"></script>
<!--  Dynamic Elements plugin -->
<script src="js/arrive.min.js"></script>
<!--  PerfectScrollbar Library -->
<script src="js/perfect-scrollbar.jquery.min.js"></script>
<!--  Notifications Plugin    -->
<script src="js/bootstrap-notify.js"></script>
<!-- Material Dashboard javascript methods -->
<script src="js/material-dashboard.js?v=1.2.0"></script>
<script src="js/historical-analytics.js"></script>
<script src="js/realtime-analytics.js"></script>
<script src="js/bootstrap-datepicker.js" type="text/javascript"></script>
<script src="js/moment.min.js" type="text/javascript"></script>
<script src="js/daterangepicker.js" type="text/javascript"></script>
<script type="text/javascript">
//function to expand and refresh chart on click
        function redirect(ele) {
            $('#' + ele.id).toggleClass('modal');
            $('div.card-chart').toggleClass('maxHeight');
            $('div.card').toggleClass('padzero');
            realtimeGraphRefresh();
        }
//get the id of the device
    var id=localStorage.getItem("deviceId");
    console.log(id);
    document.getElementById("redirect").href="details.jsp?id="+id;
</script>
<script type="text/javascript">
    var alerts = [];

    function timeDifference(current, previous, isShort) {
        var msPerMinute = 60 * 1000;
        var msPerHour = msPerMinute * 60;
        var msPerDay = msPerHour * 24;
        var msPerMonth = msPerDay * 30;
        var msPerYear = msPerDay * 365;

        var elapsed = current - previous;

        if (elapsed < msPerMinute) {
            return Math.round(elapsed / 1000) + ' seconds ago';
        } else if (elapsed < msPerHour) {
            return Math.round(elapsed / msPerMinute) + ' minutes ago';
        } else if (elapsed < msPerDay) {
            return Math.round(elapsed / msPerHour) + ' hours ago';
        } else if (elapsed < msPerMonth) {
            return 'approximately ' + Math.round(elapsed / msPerDay) + ' days ago';
        } else if (elapsed < msPerYear) {
            return 'approximately ' + Math.round(elapsed / msPerMonth) + ' months ago';
        } else {
            return 'approximately ' + Math.round(elapsed / msPerYear) + ' years ago';
        }
    }

    $(document).ready(function () {
        $(document).ready(function () {
            var wsStatsEndpoint = "<%=pageContext.getServletContext().getInitParameter("websocketEndpoint")%>/secured-websocket/iot.per.device.stream.carbon.super.weatherstation/1.0.0?"
            + "deviceId="+id+"&deviceType=weatherstation&websocketToken=<%=request.getSession(false).getAttribute(LoginController.ATTR_ACCESS_TOKEN)%>";
            realtimeGraphRefresh(wsStatsEndpoint);

            var wsAlertEndpoint = "<%=pageContext.getServletContext().getInitParameter("websocketEndpoint")%>/secured-websocket/iot.per.device.stream.carbon.super.weatherstation.alert/1.0.0?"
            + "deviceId="+id+"&deviceType=weatherstation&websocketToken=<%=request.getSession(false).getAttribute(LoginController.ATTR_ACCESS_TOKEN)%>";
            displayAlerts(wsAlertEndpoint);
        });
    });
    function realtimeGraphRefresh(wsEndpoint) {
        realtimeAnalytics.initDashboardPageCharts(wsEndpoint);
    }

    function displayAlerts(wsEndpoint) {
        connect(wsEndpoint);
        var ws;
        // close websocket when page is about to be unloaded
        // fixes broken pipe issue
        window.onbeforeunload = function () {
            disconnect();
        };

        //websocket connection
        function connect(target) {
            if ('WebSocket' in window) {
                ws = new WebSocket(target);
            } else if ('MozWebSocket' in window) {
                ws = new MozWebSocket(target);
            } else {
                console.log('WebSocket is not supported by this browser.');
            }
            if (ws) {
                ws.onmessage = function (event) {
                    var data = event.data;
                    console.log(data);
                    var alert = JSON.parse(data).event.payloadData;
                    alerts.unshift(alert);
                    if (alerts.length > 5) {
                        alerts = alerts.slice(0, -1);
                    }
                    var realtimeAlerts = $('#realtime_alerts');
                    realtimeAlerts.find('tbody').empty();
                    for (var i = 0; i < alerts.length; i++) {
                        var row = '<tr ' + (alerts[i].level === 'Warn' ? 'style="background-color: #faffd7">' : '>') +
                            '<td>' + new Date().toLocaleString() + '</td>' +
                            '<td>' + alerts[i].message + '</td>' +
                            '</tr>';
                        realtimeAlerts.find('tbody').append(row);
                    }
                }
            }
        }

        function disconnect() {
            if (ws != null) {
                ws.close();
                ws = null;
            }
        }
    }

    function updateStatusCards(sinceText, temperature, humidity, windDir) {

        //temperature status
        $("#temperature").html(temperature);

        //humidity status
        $("#humidity").html(humidity);

        //metal status
        $("#wind_status").html(windDir);
    }



</script>

</html>