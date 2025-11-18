const translations = {
    lt: {
        nav_home: "Pradžia",
        nav_about: "Apie",
        nav_projects: "Projektai",
        nav_contact: "Kontaktai",
        hero_title: "Mobiliųjų aplikacijų studija",
        hero_subtitle: "Sveiki atvykę į mūsų sukurtų programėlių pasaulį",
        btn_projects: "Peržiūrėti projektus",
        btn_contact: "Susisiekti",
        contact_name: "Vardas",
        contact_email: "El. paštas",
        contact_message: "Žinutė",
        contact_btn: "Siųsti",
        copyright: "© 2025 VilcA Mobile Apps. Visos teisės saugomos."
    },
    en: {
        nav_home: "Home",
        nav_about: "About",
        nav_projects: "Projects",
        nav_contact: "Contact",
        hero_title: "Mobile App Studio",
        hero_subtitle: "Welcome to the world of apps we create.",
        btn_projects: "View Projects",
        btn_contact: "Contact",
        contact_name: "Name",
        contact_email: "Email",
        contact_message: "Message",
        contact_btn: "Send",
        copyright: "© 2025 VilcA Mobile Apps. All rights reserved."
    }
};

function getLang() {
    const params = new URLSearchParams(window.location.search);
    return params.get("lang") || "lt";
}

let currentLang = getLang();

function applyTranslations() {
    document.querySelectorAll("[data-i18n]").forEach(el => {
        const key = el.getAttribute("data-i18n");
        el.textContent = translations[currentLang][key] || `MISSING: ${key}`;
    });

    document.getElementById("name").placeholder = translations[currentLang].contact_name;
    document.getElementById("email").placeholder = translations[currentLang].contact_email;
    document.getElementById("message").placeholder = translations[currentLang].contact_message;
    document.getElementById("contact-btn").textContent = translations[currentLang].contact_btn;
}

function switchLanguage(lang) {
    currentLang = lang;
    const url = new URL(window.location.href);
    url.searchParams.set("lang", lang);
    window.history.replaceState({}, "", url);
    applyTranslations();
}
