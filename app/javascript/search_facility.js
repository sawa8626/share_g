function getCity() {
  const prefecture = document.getElementById('facility-prefecture');
  prefecture.addEventListener('change', (e) => {
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
        prefecture.addEventListener('change', (e) => {
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
  city.addEventListener('change', (e) => {
    const citySelect = city.value;
    const XHR = new XMLHttpRequest();
    XHR.open('POST', `/facilities/city`, true);
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
        prefecture.addEventListener('change', (e) => {
          names.forEach(function(e, index) {
            let nameSelect = document.getElementById('facility-name');
            nameSelect.remove((index + 1));
          });
        });
        city.addEventListener('change', (e) => {
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

window.addEventListener('DOMContentLoaded', getCity);
window.addEventListener('DOMContentLoaded', getName);
