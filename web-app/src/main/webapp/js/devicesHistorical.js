/*
* Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
*
* WSO2 Inc. licenses this file to you under the Apache License,
* Version 2.0 (the "License"); you may not use this file except
* in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing,
* software distributed under the License is distributed on an
* "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
* KIND, either express or implied. See the License for the
* specific language governing permissions and limitations
* under the License.
*/

analyticsHistory = {
    historicalTempLabel: ['0s'],
    historicalTempSeries: [0],
    historicalHumidLabel: ['0s'],
    historicalHumidSeries: [0],
    historicalWindDirLabel: ['0s'],
    historicalWindDirSeries: [0],

    historicalTemp: {},
    historicalHumid: {},
    historicalWindDir: {},

    initDashboardPageCharts: function () {
        /* ----------==========     Historical Temperature Chart initialization    ==========---------- */
        dataHistoricalTempChart = {
            labels: analyticsHistory.historicalTempLabel,
            series: [
                analyticsHistory.historicalTempSeries
            ]
        };

        optionsHistoricalTempChart = {
            lineSmooth: Chartist.Interpolation.cardinal({
                tension: 0
            }),
            showArea: true,
            low: 0,
            high: 50, // creative tim: we recommend you to set the high sa the biggest value + something for a better
                      // look
            chartPadding: {
                top: 0,
                right: 0,
                bottom: 0,
                left: 0
            }
        };

        analyticsHistory.historicalTemp =
            new Chartist.Line('#HistoricalTempChart', dataHistoricalTempChart, optionsHistoricalTempChart);
        md.startAnimationForLineChart(analyticsHistory.historicalTemp);

        /* ----------==========     Historical Humidity Chart initialization    ==========---------- */
        dataHistoricalHumidChart = {
            labels: analyticsHistory.historicalHumidLabel,
            series: [
                analyticsHistory.historicalHumidSeries
            ]
        };

        optionsHistoricalHumidChart = {
            lineSmooth: Chartist.Interpolation.cardinal({
                tension: 0
            }),
            showArea: true,
            low: 0,
            high: 50, // creative tim: we recommend you to set the high sa the biggest value + something for a better
                      // look
            chartPadding: {
                top: 0,
                right: 0,
                bottom: 0,
                left: 0
            }
        };

        analyticsHistory.historicalHumid =
            new Chartist.Line('#HistoricalHumidityChart', dataHistoricalHumidChart, optionsHistoricalHumidChart);
        md.startAnimationForLineChart(analyticsHistory.historicalHumid);

        /* ----------==========     Historical Wind direction Chart initialization    ==========---------- */
        dataHistoricalWindDirChart = {
            labels: analyticsHistory.historicalWindDirLabel,
            series: [
                analyticsHistory.historicalWindDirSeries
            ]
        };

        optionsHistoricalWindDirChart = {
            lineSmooth: Chartist.Interpolation.cardinal({
                tension: 0
            }),
            showArea: true,
            low: 0,
            high: 50, // creative tim: we recommend you to set the high sa the biggest value + something for a better
                      // look
            chartPadding: {
                top: 0,
                right: 0,
                bottom: 0,
                left: 0
            }
        };

        analyticsHistory.historicalWindDir =
            new Chartist.Line('#HistoricalWindDirChart', dataHistoricalWindDirChart, optionsHistoricalWindDirChart);
        md.startAnimationForLineChart(analyticsHistory.historicalWindDir);


    },

    timeDifference: function (current, previous) {
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
    },

    redrawGraphs: function (events) {
        analyticsHistory.historicalTemp.update();
        analyticsHistory.historicalHumid.update();
        analyticsHistory.historicalWindDir.update();

        var sumTemp = 0;
        var sumHumid = 0;
        var sumWindDir=0;

        if (events.count > 0) {
            console.log('have records');
            var currentTime = new Date();
            analyticsHistory.historicalTempLabel.length = 0;
            analyticsHistory.historicalTempSeries.length = 0;
            analyticsHistory.historicalHumidLabel.length = 0;
            analyticsHistory.historicalHumidSeries.length = 0;
            analyticsHistory.historicalWindDirLabel.length = 0;
            analyticsHistory.historicalWindDirSeries.length = 0;

            for (var i = 0; i < events.records.length; i++) {

                var record= events.records[i];

                var sinceText = analyticsHistory.timeDifference(currentTime, new Date(record.timestamp));
                var dataPoint=record.values;
                var temperature = dataPoint.tempf;
                var humidity = dataPoint.humidity;
                var windDir=dataPoint.winddir;


                if (temperature)
                    sumTemp += temperature;

                if (humidity)
                    sumHumid += humidity;

                if (windDir)
                    sumWindDir += windDir;


                if (i === events.records.length - 1) {
                    var avgHumid = sumHumid / events.records.length;
                    var avgTemp = sumTemp / events.records.length;
                    var avgWindDir = sumWindDir / events.records.length;

                    $("#historicalTempAlert").html("<span class=\"text-success\"><i class=\"fa fa-bolt\"></i> " + avgTemp.toFixed(2) + " </span>average Temperature.");
                    $("#historicalHumidAlert").html("<span class=\"text-success\"><i class=\"fa fa-bolt\"></i> " + avgHumid.toFixed(2) + " </span> average Humidity.");
                    $("#historicalWindDirAlert").html("<span class=\"text-success\"><i class=\"fa fa-bolt\"></i> " + avgWindDir.toFixed(2) + " </span> average wind Direction.");

                }

                analyticsHistory.historicalTempLabel.push(sinceText);
                analyticsHistory.historicalTempSeries.push(temperature);

                analyticsHistory.historicalHumidLabel.push(sinceText);
                analyticsHistory.historicalHumidSeries.push(humidity);

                analyticsHistory.historicalWindDirLabel.push(sinceText);
                analyticsHistory.historicalWindDirSeries.push(windDir);


                analyticsHistory.historicalTemp.update();
                analyticsHistory.historicalHumid.update();
                analyticsHistory.historicalWindDir.update();



            }
        } else {
            //if there is no records in this period display no records
            console.log('no records');
            analyticsHistory.historicalTempLabel = ['0s'];
            analyticsHistory.historicalTempSeries = [0];

            analyticsHistory.historicalTemp.update({
                labels: analyticsHistory.historicalTempLabel,
                series: [
                    analyticsHistory.historicalTempSeries
                ]
            });
            analyticsHistory.historicalHumid.update({
                labels: analyticsHistory.historicalTempLabel,
                series: [
                    analyticsHistory.historicalTempSeries
                ]
            });
            analyticsHistory.historicalWindDir.update({
                labels: analyticsHistory.historicalTempLabel,
                series: [
                    analyticsHistory.historicalTempSeries
                ]
            });


        }



    }

};