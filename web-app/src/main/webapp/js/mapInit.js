var mymap = L.map('mapid').setView([7.9, 80.56274], 8);
L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 18,
    id: 'mapbox.streets',
    accessToken: 'pk.eyJ1IjoibGFzaGFuIiwiYSI6ImNqYmc3dGVybTFlZ3UyeXF3cG8yNGxsdzMifQ.n3QEq0-g5tVFmsQxn3JZ-A',
    closePopupOnClick: false,
}).addTo(mymap);

//adding the legend
var legend = L.control({position: 'topright'});
legend.onAdd = function (map) {
    var div = L.DomUtil.create('div', 'info legend');
    div.innerHTML += '<table><tr><td><i class=\"tiny material-icons\" >wb_sunny</i></td><td>Temperature</td></tr><tr><td><i class=\"tiny material-icons\">opacity</i></td><td> Humidity </td></tr><tr><td><i class=\"tiny material-icons\" >call_made</i></td><td>Wind Direction</td></tr></table>';
    return div;
};
legend.addTo(mymap);

//add devices to map as markers
function addToMap(lat, long, devName, devId, temp, humidity, windDir) {
    var marker = L.marker([lat, long]).addTo(mymap);
    marker.bindPopup("<b id='weatherStation" + devId + "'>Device details</b><br>" + devName + "<br><table><tr><td><i class=\"tiny material-icons\" >wb_sunny</i></td><td>" + temp + "</td></tr><tr><td><i class=\"tiny material-icons\">opacity</i></td><td>" + humidity + "</td></tr><tr><td><i class=\"tiny material-icons\" >call_made</i></td><td>" + windDir + "</td></tr><div style='margin-right:5px '><tr><td><button class=\"btn-primary btn-block\"   onclick=\"window.location.href='details.jsp?id=" + devName + "'\"><i class=\"material-icons\">remove_red_eye</i> </button></td></tr></div></table>", {minWidth: 100});

}
//add devices to map as popups
function addToMapPopoup(lat, long, devName, devId, temp, humidity, windDir) {
    var popupLocation = new L.LatLng(lat, long);
    if(temp==null){
        temp=0;
    }
    if(humidity==null){
        humidity=0;
    }
    if(windDir==null){
        windDir=0;
    }
    var popupContent = "<div onclick=\"window.location.href='details.jsp?id=" + devName +"'\"><b id='weatherStation" + devId +"' >"+devName+"</b><br><table><tr><td><i class=\"tiny material-icons\" >wb_sunny</i></td><td>" + temp + "</td><td><i class=\"tiny material-icons\">opacity</i></td><td>" + humidity + "%</td><td><i class=\"tiny material-icons\" >call_made</i></td><td>" + windDir + "&#9900</td></table></div>";
    popup = new L.Popup({maxWidth: "auto",autoPan:false,closeButton:false,closeOnClick:false});
    popup.setLatLng(popupLocation);
    popup.setContent(popupContent);
    mymap.addLayer(popup);
}

//initialising the input map
var map = L.map('inputMapId').setView([7.65655, 80.77148], 7);

L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);

var popup = L.popup();
var lat;
var lng;

//generates popup and assigns latitude and longitude values to variables
function onMapClick(e) {
    popup
        .setLatLng(e.latlng)
        .setContent("Location with coordinates " + e.latlng.toString() + " is selected")
        .openOn(map);
    lat = e.latlng.lat;
    lng = e.latlng.lng;

    latValue(lat);
    lngValue(lng);

}

// returns value of latitude
function latValue(lat) {
    console.log(lat);
    return lat;
}

// returns value of longitude
function lngValue(lng) {
    console.log(lng);
    return lng;
}

map.on('click', onMapClick);


var devices = [];
var rows = [];
