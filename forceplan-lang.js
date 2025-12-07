// AVAILABLE LANGUAGES
const translations = {
    lt: {
        title: "Forceplan",
        features: "Funkcijos",
        price: "Kaina",
        target: "Kam skirta?",
        back: "Grįžti atgal",
        feature_1: "<b>Darbuotojų valdymas</b><br>Lengvas darbuotojų pridėjimas, informacijos saugojimas, statuso keitimas.",
        feature_2: "<b>Užduočių priskyrimas ir stebėjimas</b><br>Užduočių delegavimas, progresas, terminų kontrolė.",
        feature_3: "<b>Algalapių generavimas</b><br>Automatinis algalapių skaičiavimas ir generavimas.",
        feature_4: "<b>Sąskaitų generavimas</b><br>Greitas sąskaitų išrašymas ir siuntimas klientams.",
        feature_5: "<b>Komandos komunikacija</b><br>Vidinė žinučių sistema, greitas informacijos perdavimas.",
        feature_6: "<b>Ataskaitos ir statistika</b><br>Detalių ataskaitų generavimas, statistikos peržiūra.",
        price_text: "14.99 €/mėn.",
        target_text: "Įmonėms, kurios nori efektyviai valdyti darbuotojus, užduotis, generuoti algalapius ir sąskaitas, stebėti komandos progresą."
    },
    en: {
        title: "Forceplan",
        features: "Features",
        price: "Price",
        target: "Target user",
        back: "Go back",
        feature_1: "<b>Employee management</b><br>Easily add employees, store information, change status.",
        feature_2: "<b>Task assignment and tracking</b><br>Delegate tasks, track progress, control deadlines.",
        feature_3: "<b>Payslip generation</b><br>Automatic calculation and generation of payslips.",
        feature_4: "<b>Invoice generation</b><br>Quickly issue and send invoices to clients.",
        feature_5: "<b>Team communication</b><br>Internal messaging system, fast information sharing.",
        feature_6: "<b>Reports and statistics</b><br>Generate detailed reports, view statistics.",
        price_text: "€14.99/month",
        target_text: "For companies that want to efficiently manage employees, tasks, generate payslips and invoices, and track team progress."
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
