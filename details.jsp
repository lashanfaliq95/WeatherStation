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
    if (id == null) {
        response.sendRedirect("devices.jsp");
        return;
    }

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

    JSONObject   device = new JSONObject(result.toString());
    JSONObject  enrolmentInfo = device.getJSONObject("enrolmentInfo");
    try {

    }catch(JSONException e){
        %>
Error occurred while fetching device info.
<%
    }
%>
<html>
<head>
    <title>Device Details</title>

    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/material-icons.css" rel="stylesheet" />
    <link href="css/material-dashboard.css" rel="stylesheet" />
    <link href="css/daterangepicker.css" rel="stylesheet" />
    <link href="css/font-awesome.min.css" rel="stylesheet">
</head>
<body>
<div class="wrapper">
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
            <ul class="nav">
                <li>
                    <a href="./devices.jsp">
                        <i class="material-icons">list</i>
                        <p style="font-weight: bold;">Device List</p>
                    </a>
                </li>
                <li class="active">
                    <a href="#">
                        <i class="material-icons">timeline</i>
                        <p>Analytics</p>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="main-panel">
        <%@include file="includes/nav-menu.jsp" %>
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-2">
                        <div class="card card-profile">
                            <div class="card-avatar">
                                <a href="#">
                                    <img class="img" src="images/weatherstationicon.jpg" />
                                </a>
                            </div>
                            <div class="content"> <div class="card-header" data-background-color="purple">
                                <h6 class="category text-gray">ID: <%=device.getString("deviceIdentifier")%>
                                </h6>
                                <h4 class="card-title"><%=device.getString("name")%>
                                </h4>
                                <p class="card-content">
                                    Owned by <%=enrolmentInfo.getString("owner")%>.
                                    Installed on <%=new Date(enrolmentInfo.getLong("dateOfEnrolment")).toString()%>.
                                    <%=device.getString("description")%>
                                </p>
                            </div>
                        </div>
                    </div>
                    <!--selection tab -->
                    <div class="col-md-10">
                        <div class="card card-nav-tabs">
                            <div class="card-header" data-background-color="blue">
                                <div class="nav-tabs-navigation">
                                    <div class="nav-tabs-wrapper">
                                        <span class="nav-tabs-title">Analytics: </span>
                                        <ul class="nav nav-tabs" data-tabs="tabs">
                                            <li class="active" id="realtimeTab">
                                                <a href="#realtime" data-toggle="tab">
                                                    <i class="material-icons">access_alarms</i> Realtime
                                                    <div class="ripple-container"></div>
                                                </a>
                                            </li>
                                            <li class="" id="historicalTab">
                                                <a href="#historical" data-toggle="tab">
                                                    <i class="material-icons">history</i> Historical
                                                    <div class="ripple-container"></div>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <!-- attributes displayed on top -->
                            <div class="card-content">
                                <div class="tab-content">
                                    <div class="tab-pane active" id="realtime">
                                        <div style="margin-right: 10%; margin-left: 10%; margin-bottom: 5%;">
                                            <h3>Quicklook Weather stats</h3>
                                            <div class="row">
                                                <!-- temperature -->
                                                <div class="col-lg-4 col-md-6 col-sm-6">
                                                    <div class="card card-stats">
                                                        <div id="temp_status_color" class="card-header"
                                                             data-background-color="grey">
                                                            <img  src="images/temperature-controlled.jpg" >

                                                        </div>

                                                        <div class="card-content">
                                                            <p class="category">Temperature</p>
                                                            <h3 class="title" id="temperature_status">Unknown</h3>
                                                        </div>
                                                        <div class="card-footer">
                                                            <div class="stats" id="temperature_status_alert">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--humidity-->
                                                <div class="col-lg-4 col-md-6 col-sm-6">
                                                    <div class="card card-stats">
                                                        <div id="humidity_status_color" class="card-header"
                                                             data-background-color="grey">
                                                            <img   src="images/Humidity.png">

                                                        </div>
                                                        <div class="card-content">
                                                            <p class="category">Humidity</p>
                                                            <h3 class="title" id="humidity_status">Unknown</h3>
                                                        </div>
                                                        <div class="card-footer">
                                                            <div class="stats" id="humidity_status_alert">

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- wind direction -->
                                                <div class="col-lg-4 col-md-6 col-sm-6">
                                                    <div class="card card-stats">
                                                        <div id="wind_status_color" class="card-header"
                                                             data-background-color="grey">
                                                            <img  src="images/images.jpeg" width="20" height="20">
                                                        </div>
                                                        <div class="card-content">
                                                            <p class="category">Wind Direction</p>
                                                            <h3 class="title" id="wind_status">Unknown</h3>
                                                        </div>
                                                        <div class="card-footer">
                                                            <div class="stats" id="wind_status_alert">

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <%--<h3>Device Activity Log</h3>--%>
                                            <%--<table id="realtime_alerts" class="table" style="font-size: 15px">--%>
                                                <%--<thead>--%>
                                                <%--<tr>--%>
                                                    <%--<th>Time</th>--%>
                                                    <%--<th>Message</th>--%>
                                                <%--</tr>--%>
                                                <%--</thead>--%>
                                                <%--<tbody>--%>
                                                <%--<tr style="background-color: #dfffd3">--%>
                                                    <%--<td></td>--%>
                                                    <%--<td>No new alerts to display.</td>--%>
                                                <%--</tr>--%>
                                                <%--</tbody>--%>
                                            <%--</table>--%>
                                        <%--</div>--%>
                                        <!-- temperature realtime-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="red"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimeTemp"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Temperature</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimeTempLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 4 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- humidity realtime -->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="blue"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimeHumid"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Humidity</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimeHumidLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 7 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime wind direction -->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="purple"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimeWindDir"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Wind Direction</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimeWindDirLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime dew point forecast -->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="orange"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimedewptf"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Dew point forecast</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimedewptfLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime wind chill frequency -->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="green"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimewindchillf"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Wind chill frequency</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimewindchillfLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime wind speed mph-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="red"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimewindspeed"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Wind Speed</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimewindspeedLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime wind gust mph-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="blue"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimewindgust"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Wind Gust</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimewindgustLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime raining-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="orange"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimeraining"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Raining</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimerainingLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime daily raining-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="purple"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimedailyraining"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Daily Raining</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimedailyrainingLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime weekly raining-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="green"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimeweeklyraining"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Weekly Raining</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimeweeklyrainingLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime monthly raining-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="purple"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimemonthlyraining"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Monthly Raining</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimemonthlyrainingLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime yearly raining-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="blue"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimeyearlyraining"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Yearly Raining</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimeyearlyrainingLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime solar radiation-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="green"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimesolarradiation"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Solar Radiation</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimesolarradiationLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime UV-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="orange"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimeuv"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Ultra Violet</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimeuvLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime indoor temperature-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="red"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimeindoortemp"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Indoor Temperature</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimeindoortempLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime indoor humidity-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="purple"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimeindoorhumid"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Indoor Humidity</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimeindoorhumidLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime baromin-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="blue"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimebaromin"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Baromin</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimebarominLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime lowbatt-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="green"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="realtimelowbatt"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">lowbatt</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="realtimelowbattLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- historical tab -->
                                    <div class="tab-pane" id="historical">
                                        <div style="margin-right: 10%; margin-left: 10%; margin-bottom: 5%;">
                                            <h4>Select Date-range</h4>
                                            <input type="text" name="daterange" id="daterange"
                                                   value="01/01/2017 1:30 PM - 01/01/2017 2:00 PM"
                                                   class="form-control" />
                                        </div>
                                        <!-- historical temperature -->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="orange"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicalTemp"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Temperature</h4>
                                                <p class="category" id="historicalTempAlert">
                                                    <span class="text-success"><i class="fa fa-long-arrow-down"></i> 10% </span>
                                                    decrease in Temperature.</p>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats">
                                                    <i class="material-icons">access_time</i> updated 4 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- historical humidity -->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="red"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicalHumid"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Humidity</h4>
                                                <p class="category"  id="historicalHumidAlert">
                                                    <span class="text-success"><i
                                                            class="fa fa-long-arrow-up"></i> 5% </span> increase in
                                                    Temperature.</p>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats">
                                                    <i class="material-icons">access_time</i> updated 7 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- historical wind direction -->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="purple"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicalWindDir"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Wind Direction</h4>
                                                <p class="category"  id="historicalWindDirAlert">
                                                    <span class="text-success"><i
                                                            class="fa fa-long-arrow-up"></i> 5% </span> increase in
                                                    Temperature.</p>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats">
                                                    <i class="material-icons">access_time</i> updated 7 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- historical dew point forecast -->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="blue"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicaldewptf"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Dew point forecast</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="historicaldewptfLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- historical wind chill frequency -->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="green"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicalwindchillf"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Wind chill frequency</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="historicalwindchillfLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- historical wind speed mph-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="orange"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicalwindspeed"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Wind Speed</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="historicalwindspeedLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- historical wind gust mph-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="red"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicalwindgust"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Wind Gust</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="historicalwindgustLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime raining-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="purple"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicalraining"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Raining</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="historicalrainingLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- historical daily raining-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="blue"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicaldailyraining"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Daily Raining</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="historicaldailyrainingLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime weekly raining-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="green"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicalweeklyraining"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Weekly Raining</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="historicalweeklyrainingLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- historical monthly raining-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="orange"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicalmonthlyraining"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Monthly Raining</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="historicalmonthlyrainingLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime yearly raining-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="red"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicalyearlyraining"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Yearly Raining</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="historicalyearlyrainingLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- historical solar radiation-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="purple"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicalsolarradiation"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Solar Radiation</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="historicalsolarradiationLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- historical UV-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="blue"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicaluv"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Ultra Violet</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="historicaluvLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime indoor temperature-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="green"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicalindoortempf"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Indoor Temperature</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="historicalindoortempfLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime indoor humidity-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="orange"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicalindoorhumidity"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Indoor Humidity</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="historicalindoorhumidityLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- realtime baromin-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="red"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicalbaromin"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">Baromin</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="historicalbarominLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>
                                        <!-- historical lowbatt-->
                                        <div class="card">
                                            <div class="card-header card-chart" data-background-color="purple"
                                                 style="height: 30%;">
                                                <div class="ct-chart" id="historicallowbatt"></div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="title">lowbatt</h4>
                                            </div>
                                            <div class="card-footer">
                                                <div class="stats" id="historicallowbattLastUpdated">
                                                    <i class="material-icons">access_time</i> updated 9 minutes ago
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="footer">
            <div class="container-fluid">
                <p class="copyright pull-right">
                    &copy;
                    <script>
                        document.write(new Date().getFullYear())
                    </script>
                    <a href="http://www.wso2.com">WSO2</a> Inc.
                </p>
            </div>
        </footer>
    </div>
</div>
</body>
<script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/bootstrap-datepicker.js" type="text/javascript"></script>
<script src="js/moment.min.js" type="text/javascript"></script>
<script src="js/daterangepicker.js" type="text/javascript"></script>
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
<script type="text/javascript">
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
        $("#temperature_status").html(temperature);

        //humidity status
        $("#humidity_status").html(humidity);

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
            $("#temperature_status").html("Unknown");
            $("#temperature_status_alert").parent().remove();

            //humidity status
            $("#humidity_status").html("Unknown");
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
