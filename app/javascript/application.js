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

document.addEventListener("turbo:load", () => {
  const container = document.body;

  function createFallingLeaf() {
    const leaf = document.createElement("img");
    leaf.src = "/assets/momiji.png"; // app/assets/images/momiji.png
    leaf.classList.add("fixed", "top-0", "z-50", "pointer-events-none");

    // ランダム位置・サイズ
    const size = Math.random() * 40 + 20; // 20px〜60px
    const left = Math.random() * window.innerWidth;
    leaf.style.width = `${size}px`;
    leaf.style.left = `${left}px`;

    // アニメーション用のスタイル
    const duration = Math.random() * 5 + 5; // 5〜10秒で落ちる
    leaf.style.animation = `fall ${duration}s linear forwards`;

    container.appendChild(leaf);

    // アニメーション終了後に削除
    setTimeout(() => {
      leaf.remove();
    }, duration * 1000);
  }

  // 一定間隔で紅葉を生成
  setInterval(createFallingLeaf, 800); // 0.8秒ごとに1枚
});