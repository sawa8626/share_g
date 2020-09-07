function selectTeam () {
  const teamSelect = document.getElementById('team-select');
  const teamList = document.getElementById('hidden-lists');
  teamSelect.addEventListener('mouseover', () => {
    teamList.setAttribute('style', 'display:block');
  });
  teamSelect.addEventListener('click', () => {
    teamList.removeAttribute('style', 'display:block');
  });
};

window.addEventListener('DOMContentLoaded', selectTeam);
