// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener("turbo:load", () => {
  const body = document.body;
  const controller = body.dataset.controller;
  const action = body.dataset.action;

  if (controller === "static_pages" && action === "top") {
    // ===== フェードイン処理 =====
    const section = document.querySelector(".fade-section");
    const button = document.querySelector(".fade-button");

    if (section && button) {
      const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            section.classList.remove("opacity-0"); // h1 + p をフェードイン
            setTimeout(() => {
              button.classList.remove("opacity-0", "scale-90"); // ボタンをパッと表示
            }, 1000);
            observer.unobserve(section);
          }
        });
      });
      observer.observe(section);
    }

    // ===== 紅葉アニメーション処理 =====
    const leavesContainer = document.createElement("div");
    leavesContainer.classList.add("leaves-container");
    document.body.appendChild(leavesContainer);

    function createLeaf() {
      const leaf = document.createElement("img");
      leaf.src = window.momijiAsset; // ERBから渡したパスを利用
      leaf.classList.add("animate-fall", "fixed", "top-0", "z-50", "pointer-events-none");

      // ランダムな位置・サイズ・速度
      leaf.style.left = `${Math.random() * 100}vw`;
      leaf.style.width = `${20 + Math.random() * 40}px`;
      leaf.style.animationDuration = `${5 + Math.random() * 5}s`;

      leavesContainer.appendChild(leaf);

      // アニメーション終了後に削除
      setTimeout(() => {
        leaf.remove();
      }, 10000);
    }

    // 一定間隔で紅葉を生成
    setInterval(createLeaf, 800);  // 0.8秒ごとに1枚
  }
});
