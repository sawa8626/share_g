function selectReserveTeam () {
  const release = document.getElementById('release-box');
  release.addEventListener('click', () => {
    if(release.checked) {
      const hiddenSelect = document.getElementById('hidden-select');
      hiddenSelect.setAttribute('style', 'display:block');
    };
  });
};

window.addEventListener('DOMContentLoaded', selectReserveTeam);
