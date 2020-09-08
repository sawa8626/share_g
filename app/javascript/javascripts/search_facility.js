function getCity() {
  const prefecture = document.getElementById('facility-prefecture');
  prefecture.addEventListener('change', () => {
    const prefectureSelect = prefecture.value;
    const XHR = new XMLHttpRequest();
    XHR.open('POST', '/facilities/prefecture', true);
    XHR.responseType = 'json';
    XHR.send(prefectureSelect);
    XHR.onload = () => {
      const cities = XHR.response.cities;
      if (XHR.status == 200) {
        cities.forEach(e => {
          let citySelect = document.getElementById('facility-city');
          let cityOption = document.createElement('option');
          cityOption.text = e.city;
          cityOption.value = e.city;
          citySelect.appendChild(cityOption);
        });
        prefecture.addEventListener('change', () => {
          cities.forEach(function(e, index) {
            let citySelect = document.getElementById('facility-city');
            citySelect.remove((index + 1));
          });
        });
      }
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
      } else {
        return null;
      }
    };
    XHR.onerror = () => {
      alert("Request failed");
    };
  });
};

function getName() {
  const city = document.getElementById('facility-city');
  city.addEventListener('change', () => {
    const citySelect = city.value;
    const XHR = new XMLHttpRequest();
    XHR.open('POST', '/facilities/city', true);
    XHR.responseType = 'json';
    XHR.send(citySelect);
    XHR.onload = () => {
      const names = XHR.response.names;
      const prefecture = document.getElementById('facility-prefecture');
      if (XHR.status == 200) {
        names.forEach(e => {
          let nameSelect = document.getElementById('facility-name');
          let nameOption = document.createElement('option');
          nameOption.text = e.name;
          nameOption.value = e.name;
          nameSelect.appendChild(nameOption);
        });
        prefecture.addEventListener('change', () => {
          names.forEach(function(e, index) {
            let nameSelect = document.getElementById('facility-name');
            nameSelect.remove((index + 1));
          });
        });
        city.addEventListener('change', () => {
          names.forEach(function(e, index) {
            let nameSelect = document.getElementById('facility-name');
            nameSelect.remove((index + 1));
          });
        });
      }
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
      } else {
        return null;
      }
    };
    XHR.onerror = () => {
      alert("Request failed");
    };
  });
};

function getArea() {
  const name = document.getElementById('facility-name');
  name.addEventListener('change', () => {
    const nameSelect = name.value;
    const XHR = new XMLHttpRequest();
    XHR.open('POST', '/facilities/name', true);
    XHR.responseType = 'json';
    XHR.send(nameSelect);
    XHR.onload = () => {
      const areas = XHR.response.areas;
      const prefecture = document.getElementById('facility-prefecture');
      const city = document.getElementById('facility-city');
      if (XHR.status == 200) {
        areas.forEach(e => {
          let areaSelect = document.getElementById('facility-area');
          let areaOption = document.createElement('option');
          areaOption.text = e.area;
          areaOption.value = e.area;
          areaSelect.appendChild(areaOption);
        });
        prefecture.addEventListener('change', () => {
          areas.forEach(function(e, index) {
            let areaSelect = document.getElementById('facility-area');
            areaSelect.remove((index + 1));
          });
        });
        city.addEventListener('change', () => {
          areas.forEach(function(e, index) {
            let areaSelect = document.getElementById('facility-area');
            areaSelect.remove((index + 1));
          });
        });
        name.addEventListener('change', () => {
          areas.forEach(function(e, index) {
            let areaSelect = document.getElementById('facility-area');
            areaSelect.remove((index + 1));
          });
        });
      }
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
      } else {
        return null;
      }
    };
    XHR.onerror = () => {
      alert("Request failed");
    };
  });
};

function putLink() {
  const name = document.getElementById('facility-name');
  const area = document.getElementById('facility-area');
  area.addEventListener('change', () => {
    const nameSelect = name.value;
    const areaSelect = area.value;
    const selections = { name: nameSelect, 'area': areaSelect };
    const jsonText = JSON.stringify(selections);
    if (areaSelect == '---') {
      return null;
    } else {
      const XHR = new XMLHttpRequest();
      XHR.open('POST', 'facilities/area', true);
      XHR.responseType = 'json';
      XHR.send(jsonText);
      XHR.onload = () => {
        if (XHR.status == 200) {
          const facilityId = XHR.response.facility_id[0].id;
          const btn = document.getElementById('search-facility-btn');
          btn.href = `/facilities/${facilityId}/reservations`;
        }
        if (XHR.status != 200) {
          alert(`Error ${XHR.status}: ${XHR.statusText}`);
        } else {
          return null;
        }
      };
      XHR.onerror = () => {
        alert("Request failed");
      };
    }
  });
};

window.addEventListener('DOMContentLoaded', getCity);
window.addEventListener('DOMContentLoaded', getName);
window.addEventListener('DOMContentLoaded', getArea);
window.addEventListener('DOMContentLoaded', putLink);
