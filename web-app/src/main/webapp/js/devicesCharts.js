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

analyticsHistory= {

    historicalTempLabel: ['0s'],
    historicalTempSeries: [0],
    historicalHumidLabel: ['0s'],
    historicalHumidSeries: [0],
    historicalWindDirLabel: ['0s'],
    historicalWindDirSeries: [0],

    temp :[],
    humid :[],
    windDir:[],
    historicalTemp: {},
    historicalHumid: {},
    historicalWindDir: {},

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
            return  Math.round(elapsed / msPerDay) + ' days ago';
        } else if (elapsed < msPerYear) {
            return  Math.round(elapsed / msPerMonth) + ' months ago';
        } else {
            return  Math.round(elapsed / msPerYear) + ' years ago';
        }
    },

    redrawGraphs: function (events) {

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




                analyticsHistory.historicalTempLabel.push(sinceText);
                analyticsHistory.historicalTempSeries.push(temperature);

                analyticsHistory.historicalHumidLabel.push(sinceText);
                analyticsHistory.historicalHumidSeries.push(humidity);

                analyticsHistory.historicalWindDirLabel.push(sinceText);
                analyticsHistory.historicalWindDirSeries.push(windDir);



                analyticsHistory.historicalHumid.update();
                analyticsHistory.historicalWindDir.update();


            }
        } else {
            //if there is no records in this period display no records
            console.log('no records');
            analyticsHistory.historicalTempLabel.length = 0;
            analyticsHistory.historicalTempSeries.length = 0;
            analyticsHistory.historicalHumidLabel.length = 0;
            analyticsHistory.historicalHumidSeries.length = 0;
            analyticsHistory.historicalWindDirLabel.length = 0;
            analyticsHistory.historicalWindDirSeries.length = 0;


            analyticsHistory.historicalTemp.update();
            analyticsHistory.historicalHumid.update();
            analyticsHistory.historicalWindDir.update();

        }



    }

};