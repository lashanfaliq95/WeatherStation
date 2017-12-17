<%--
  Created by IntelliJ IDEA.
  User: lashan
  Date: 12/15/17
  Time: 10:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="org.apache.http.HttpResponse" %>
<%@page import="org.apache.http.client.methods.HttpPost" %>
<%@ page import="org.apache.http.conn.ssl.SSLConnectionSocketFactory" %>
<%@ page import="org.apache.http.conn.ssl.SSLContextBuilder" %>
<%@ page import="org.apache.http.conn.ssl.TrustSelfSignedStrategy" %>
<%@ page import="org.apache.http.entity.ContentType" %>
<%@ page import="org.apache.http.entity.StringEntity" %>
<%@ page import="org.apache.http.impl.client.CloseableHttpClient" %>
<%@ page import="org.apache.http.impl.client.HttpClients" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.net.URISyntaxException" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page import="java.security.KeyManagementException" %>
<%@ page import="org.json.JSONException" %>
<%@include file="includes/authenticate.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");
    String cookie = request.getHeader("Cookie");

    URI invokerURI = null;
    try {
        invokerURI = new URL(request.getScheme(),
                request.getServerName(),
                request.getServerPort(), request.getContextPath() + "/invoker/execute").toURI();
    } catch (URISyntaxException e) {
        e.printStackTrace();
    }
    HttpPost invokerEndpoint = new HttpPost(invokerURI);
    invokerEndpoint.setHeader("Cookie", cookie);

    StringEntity entity = new StringEntity("uri=/devices/weatherstation/" + id + "&method=get",
            ContentType.APPLICATION_FORM_URLENCODED);
    invokerEndpoint.setEntity(entity);

    SSLContextBuilder builder = new SSLContextBuilder();
    builder.loadTrustMaterial(null, new TrustSelfSignedStrategy());
    SSLConnectionSocketFactory sslsf = null;
    try {
        sslsf = new SSLConnectionSocketFactory(builder.build());
    } catch (NoSuchAlgorithmException e) {
        e.printStackTrace();
    } catch (KeyManagementException e) {
        e.printStackTrace();
    }
    CloseableHttpClient client = HttpClients.custom().setSSLSocketFactory(
            sslsf).build();
    HttpResponse invokerResponse = client.execute(invokerEndpoint);

    if (invokerResponse.getStatusLine().getStatusCode() == 401) {
        return;
    }

    BufferedReader rd = new BufferedReader(new InputStreamReader(invokerResponse.getEntity().getContent()));

    StringBuilder result = new StringBuilder();
    String line = "";
    while ((line = rd.readLine()) != null) {
        result.append(line);
    }


    try {
        JSONObject   device = new JSONObject(result.toString());
        JSONObject  enrolmentInfo = device.getJSONObject("enrolmentInfo");
    }catch(JSONException e){
%>
Error occurred while fetching device info.
<%
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Real time weather data</title>
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />
        <!-- Bootstrap core CSS     -->
        <link href="css/bootstrap.min.css" rel="stylesheet" />
        <!--  Material Dashboard CSS    -->
        <link href="css/material-dashboard.css?v=1.2.0" rel="stylesheet" />
        <link href="css/updates.css" rel="stylesheet" />
</head>
<body>
<div class="expandedChart">
<div class="card">
    <div class="card-header card-chart" data-background-color="red">
        <div class="ct-chart" id="RealTimeTempChart" ></div>
    </div>
    <div class="card-content">
        <h4 class="title">Temperature</h4>
        <p class="category">
            <span class="text-success"><i class="fa fa-long-arrow-up"></i> 55% </span> increase in today sales.</p>
    </div>
    <div class="card-footer">
        <div class="stats">
            <i class="material-icons">access_time</i> updated 4 minutes ago
        </div>
    </div>
</div>
</div>
</body>
<script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/material.min.js" type="text/javascript"></script>
<script src="js/bootstrap-datepicker.js" type="text/javascript"></script>
<script src="js/moment.min.js" type="text/javascript"></script>
<script src="js/daterangepicker.js" type="text/javascript"></script>
<!--  Charts Plugin -->
<script src="js/chartist.min.js"></script>
<!--  Dynamic Elements plugin -->
<script src="js/arrive.min.js"></script>

<!--  Notifications Plugin    -->
<script src="js/bootstrap-notify.js"></script>
<!-- Material Dashboard javascript methods -->
<script src="js/material-dashboard.js?v=1.2.0"></script>
<script src="js/historical-analytics.js"></script>
<script src="js/realtime-analytics.js"></script>

<script type="text/javascript">
    window.onload = console.log(localStorage.getItem("id"));

    function datePickerCallback(startD, endD) {
        var eventsSuccess = function (data) {
            var records = JSON.parse(data);
            console.log('records'+data);
            analyticsHistory.redrawGraphs(records);
        };

        var index = 0;
        var length = 100;

        $.ajax({
            type: "POST",
            url: "invoker/execute",
            data: {
                "uri": "/events/weatherstation/<%=id%>?offset=" + index + "&limit=" + length + "&from=" + new Date(
                    startD.format('YYYY-MM-DD H:mm:ss')).getTime() + "&to=" + new Date(
                    endD.format('YYYY-MM-DD H:mm:ss')).getTime(),
                "method": "get"
            },
            success: eventsSuccess
        });
    };

    $(function () {
        $('#daterange').daterangepicker({
            timePicker: true,
            timePickerIncrement: 30,
            locale: {
                format: 'MM/DD/YYYY h:mm A'
            },
            ranges: {
                'Today': [moment(), moment()],
                'Yesterday': [moment().subtract(1, 'days'),
                    moment().subtract(1, 'days')],
                'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                'This Month': [moment().startOf('month'), moment().endOf('month')],
                'Last Month': [moment().subtract(1, 'month').startOf('month'),
                    moment().subtract(1, 'month').endOf('month')]
            }
        }, datePickerCallback);

        $(window).scroll(function () {
            if ($('#daterange').length) {
                $('#daterange').daterangepicker("close");
            }
        })
    });
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
                + "deviceId=<%=id%>&deviceType=weatherstation&websocketToken=<%=request.getSession(false).getAttribute(LoginController.ATTR_ACCESS_TOKEN)%>";
            realtimeGraphRefresh(wsStatsEndpoint);

            var wsAlertEndpoint = "<%=pageContext.getServletContext().getInitParameter("websocketEndpoint")%>/secured-websocket/iot.per.device.stream.carbon.super.weatherstation.alert/1.0.0?"
                + "deviceId=<%=id%>&deviceType=weatherstation&websocketToken=<%=request.getSession(false).getAttribute(LoginController.ATTR_ACCESS_TOKEN)%>";
            displayAlerts(wsAlertEndpoint);
        });
    });
    document.getElementById("realtimeTab").addEventListener("click", realtimeGraphRefresh());
    document.getElementById("historicalTab").addEventListener("click", historyGraphRefresh);

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
                            '<td>'+alerts[i].message+'</td>' +
                            '</tr>';
                        realtimeAlerts.find('tbody').append(row);
                    }
                };
            }
        }

        function disconnect() {
            if (ws != null) {
                ws.close();
                ws = null;
            }
        }
    }

    function historyGraphRefresh() {
        analyticsHistory.initDashboardPageCharts();
        var start = moment().subtract(1, 'days');
        var end = moment();
        datePickerCallback(start, end);
    }

    function updateStatusCards(sinceText, temperature, humidity, windDir) {

        //temperature status
        $("#temperature").html(temperature);

        //humidity status
        $("#humidity").html(humidity);

        //metal status
        $("#wind_status").html(windDir);
    }

    var lastKnown = {};
    var lastKnownSuccess = function (data) {
        var record = JSON.parse(data).records[0];

        if (record) {
            lastKnown = record;
            var sinceText = timeDifference(new Date(), new Date(record.timestamp), false) + " ago";
            var temperature = record.values.tempf;
            var humidity = record.values.humidity;
            var windDir = record.values.winddir;
            updateStatusCards(sinceText, temperature, humidity, windDir);
        } else {
            //temperature status
            $("#temperature").html("Unknown");
            $("#temperature_status_alert").parent().remove();

            //humidity status
            $("#humidity").html("Unknown");
            $("#humidity_status_alert").parent().remove();

            //wind direction status
            $("#wind_status").html("Unknown");
            $("#wind_status_alert").parent().remove();
        }
    };
    $.ajax({
        type: "POST",
        url: "invoker/execute",
        data: {
            "uri": "/events/last-known/weatherstation/<%=id%>",
            "method": "get"
        },
        success: lastKnownSuccess
    });
</script>
</html>

