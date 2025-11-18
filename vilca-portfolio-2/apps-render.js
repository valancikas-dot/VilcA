function renderApps(lang = "lt") {
    const container = document.querySelector(".projects-grid");
    if (!container) return;
    container.innerHTML = "";

    apps.forEach(app => {
        const card = document.createElement("div");
        card.className = "project-card";
        card.innerHTML = `
            <img src="${app.image}" alt="${app.title[lang]} logo" style="height:64px;">
            <div class="project-title">${app.title[lang]}</div>
            <div class="project-description">${app.description[lang]}</div>
            <a href="${app.link}?lang=${lang}" class="btn">${translations[lang].btn_projects}</a>
        `;
        container.appendChild(card);
    });
}
