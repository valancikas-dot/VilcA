// AVAILABLE LANGUAGES
const translations = {
    lt: {
        title: "Fazero",
        features: "Funkcijos",
        price: "Kaina",
        target: "Kam skirta?",
        back: "Grįžti atgal",
        privacy: "Privatumo politika",
        feature_1: "<b>Elektros instaliacijų bandymai ir matavimai</b><br>Atlikite visus reikalingus bandymus pagal LST HD 60364 standartą.",
        feature_2: "<b>Automatinis protokolų generavimas</b><br>PDF protokolai su visais matavimų duomenimis ir atitikties patvirtinimu.",
        feature_3: "<b>Elektroninis instaliacijos žurnalas</b><br>Saugokite visą instaliacijos istoriją vienoje vietoje.",
        feature_4: "<b>Offline/Online sinchronizacija</b><br>Dirbkite be interneto, duomenys automatiškai sinchronizuojasi.",
        feature_5: "<b>Matavimo prietaisų valdymas</b><br>Registruokite ir valdykite matavimo prietaisų kalibracijas.",
        feature_6: "<b>Norminė atitiktis</b><br>Automatinė tikrinimo ir validavimo sistema pagal standartus.",
        price_text: "14.99 €/mėn.",
        target_text: "Elektrikams, elektros inžinieriams, elektros instaliacijos įmonėms, atsakingiems už elektros ūkį."
    },
    en: {
        title: "Fazero",
        features: "Features",
        price: "Price",
        target: "Target user",
        back: "Go back",
        privacy: "Privacy Policy",
        feature_1: "<b>Electrical installation testing and measurements</b><br>Perform all required tests according to IEC 60364 standard.",
        feature_2: "<b>Automatic protocol generation</b><br>PDF reports with all measurement data and compliance confirmation.",
        feature_3: "<b>Electronic installation log</b><br>Store complete installation history in one place.",
        feature_4: "<b>Offline/Online synchronization</b><br>Work without internet, data syncs automatically.",
        feature_5: "<b>Measurement device management</b><br>Register and manage measurement device calibrations.",
        feature_6: "<b>Standards compliance</b><br>Automatic verification and validation system per standards.",
        price_text: "€14.99/month",
        target_text: "For electricians, electrical engineers, electrical installation companies, and those responsible for electrical systems."
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
        el.innerHTML = translations[currentLang][key] || `MISSING: ${key}`;
    });
}
function switchLanguage(lang) {
    currentLang = lang;
    const url = new URL(window.location.href);
    url.searchParams.set("lang", lang);
    window.history.replaceState({}, "", url);
    applyTranslations();
}
document.addEventListener("DOMContentLoaded", applyTranslations);
