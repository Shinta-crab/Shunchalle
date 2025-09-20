// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener("turbo:load", () => {
  const section = document.querySelector(".fade-section");
  const button = document.querySelector(".fade-button");

  if (!section || !button) return;

  const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        // h1 + p をフェードイン
        section.classList.remove("opacity-0");

        // 少し遅れてボタンを「パッと」表示
        setTimeout(() => {
          button.classList.remove("opacity-0", "scale-90");
        }, 1000); // 1秒遅れ
        observer.unobserve(section);
      }
    });
  });

  observer.observe(section);
});
