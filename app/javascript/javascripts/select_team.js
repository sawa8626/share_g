function selectTeam () {
  const teamSelect = document.getElementById('team-select');
  const teamList = document.getElementById('hidden-lists');
  const teams = document.getElementsByClassName('hidden-list')
  teamSelect.addEventListener('mouseover', () => {
    teamList.setAttribute('style', 'display:block');
  });
  teamList.addEventListener('mouseout', () => {
    teamList.removeAttribute('style', 'display:block');
  });
};

window.addEventListener('DOMContentLoaded', selectTeam);
