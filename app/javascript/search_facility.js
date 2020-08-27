function getData() {
  const prefecture = document.getElementById('facility-prefecture');
  prefecture.addEventListener('change', (e) => {
    const prefectureSelect = prefecture.value;
    const XHR = new XMLHttpRequest();
    XHR.open('GET', `/facilities/${prefectureSelect}`, true);
    XHR.responseType = 'json';
    XHR.send();
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

window.addEventListener('DOMContentLoaded', getData);