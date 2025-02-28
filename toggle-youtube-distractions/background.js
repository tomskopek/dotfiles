chrome.commands.onCommand.addListener((command) => {
  if (command === "toggle-controls") {
    chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
      if (tabs.length > 0) {
        chrome.scripting.executeScript({
          target: { tabId: tabs[0].id },
          function: toggleYouTubeControls
        });
      }
    });
  }
});

function toggleYouTubeControls() {
  const player = document.querySelector(".html5-video-player");
  if (player) {
    const controls = player.querySelector(".ytp-chrome-bottom");
    if (controls) {
      controls.style.display = controls.style.display === "none" ? "flex" : "none";
    }
  }
}
