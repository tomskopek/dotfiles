document.addEventListener("keydown", (event) => {
  if (event.ctrlKey && event.key === "d") {
    toggleCommentsAndRecommendations();
  }
  if (event.ctrlKey && event.key === "p") {
    togglePlayerControls();
  }
});

function toggleCommentsAndRecommendations() {
  const comments = document.querySelector("#comments");
  const recommendations = document.querySelector("#related");

  if (comments) {
    comments.style.display = comments.style.display === "none" ? "block" : "none";
  }

  if (recommendations) {
    recommendations.style.display = recommendations.style.display === "none" ? "block" : "none";
  }
}

function togglePlayerControls() {
  const player = document.querySelector(".html5-video-player");

  if (player) {
    const controls = player.querySelector(".ytp-chrome-bottom");
    const gradient = player.querySelector(".ytp-gradient-bottom");
    if (controls && gradient) {
      const isHidden = controls.style.display === "none";
      controls.style.display = isHidden ? "flex" : "none";
      gradient.style.display = isHidden ? "block" : "none"; 
    }
  }
}
