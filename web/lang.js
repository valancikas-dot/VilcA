// AVAILABLE LANGUAGES
const translations = {
    lt: {
        title: "Rangis",
        features: "Funkcijos",
        price: "Kaina",
        target: "Kam skirta?",
        back: "Grįžti atgal",
        feature_1: "<b>Rangos darbų valdymas ir stebėjimas</b><br>Projektų ir užduočių kūrimas, priskyrimas, progresas, terminų kontrolė.",
        feature_2: "<b>Užduočių priskyrimas ir progresas</b><br>Užduočių delegavimas komandos nariams, statuso keitimas, atlikimo žymėjimas.",
        feature_3: "<b>Likusiu medžiagų rinka</b><br>Galimybė matyti ir parduoti likusias statybines medžiagas, ieškoti pasiūlymų.",
        feature_4: "<b>Žinučių komunikacija su pardavėju</b><br>Tiesioginis susirašinėjimas su medžiagų pardavėjais, klausimų uždavimas, pasiūlymų derinimas.",
        feature_5: "<b>Naviguoti į adresą funkcija</b><br>Integruota žemėlapių sistema, leidžianti greitai rasti objekto ar pardavėjo adresą ir gauti maršrutą.",
        price_text: "9.99 €/mėn., nepriklausomai nuo komandos dydžio",
        target_text: "Statybos įmonėms, rangos darbų vadovams, projektų vadovams, komandoms, kurios nori efektyviai valdyti procesus, ir pavieniams specialistams."
    },
    en: {
        title: "Rangis",
        features: "Features",
        price: "Price",
        target: "Target user",
        back: "Go back",
        feature_1: "<b>Construction management and tracking</b><br>Create and manage projects and tasks, assign responsibilities, track progress, control deadlines.",
        feature_2: "<b>Task assignment and progress</b><br>Delegate tasks to team members, change status, mark completion.",
        feature_3: "<b>Leftover materials marketplace</b><br>View and sell leftover materials, search for offers.",
        feature_4: "<b>Messaging with seller</b><br>Direct chat with sellers, ask questions, negotiate.",
        feature_5: "<b>Address navigation</b><br>Integrated map system to find locations and directions.",
        price_text: "€9.99/month, regardless of team size",
        target_text: "For construction companies, managers, teams who want efficient process control, and independent specialists."
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
