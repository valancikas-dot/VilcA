const translations = {
    lt: {
        title: "Taxlitas",
        features: "Funkcijos",
        price: "Kaina",
        target: "Kam skirta?",
        back: "Grįžti atgal",
        feature_1: "<b>Automatinės ataskaitos</b><br>Generuokite PVM, pelno ir metines ataskaitas vienu paspaudimu.",
        feature_2: "<b>Išlaidų valdymas</b><br>Kategorijuokite išlaidas, pridėkite kvitus ir gaukite aiškias ataskaitas.",
        feature_3: "<b>Banko suderinimas</b><br>Importuokite operacijas CSV/OFX ir suderinkite automatiškai.",
        feature_4: "<b>Deklaracijų šablonai</b><br>Paruošti vietiniai šablonai mokesčių deklaracijoms.",
        feature_5: "<b>Duomenų saugumas</b><br>Šifruoti duomenys ir atsarginės kopijos.",
        feature_6: "<b>Paprastos finansinės suvestinės</b><br>Aiškios suvestinės savarankiškam verslui.",
        price_text: "7.99 €/mėn.",
        target_text: "Freelanceriams, smulkiam verslui, konsultantams ir savarankiškiems asmenims."
    },
    en: {
        title: "Taxlitas",
        features: "Features",
        price: "Price",
        target: "Target users",
        back: "Go back",
        feature_1: "<b>Automated reports</b><br>Generate VAT, profit and yearly reports with one click.",
        feature_2: "<b>Expense management</b><br>Categorize expenses, attach receipts and get clear summaries.",
        feature_3: "<b>Bank reconciliation</b><br>Import transactions (CSV/OFX) and reconcile automatically.",
        feature_4: "<b>Form templates</b><br>Ready templates for local tax forms and reports.",
        feature_5: "<b>Data security</b><br>Encrypted storage and backup options.",
        feature_6: "<b>Simple dashboards</b><br>Clear financial overviews for freelancers and small businesses.",
        price_text: "€7.99/month",
        target_text: "For freelancers, small businesses, consultants and self-employed." 
    }
};
function getLang() { const params = new URLSearchParams(window.location.search); return params.get('lang') || 'lt'; }
let currentLang = getLang();
function applyTranslations() { document.querySelectorAll('[data-i18n]').forEach(el => { const key = el.getAttribute('data-i18n'); el.innerHTML = translations[currentLang][key] || `MISSING: ${key}`; }); }
function switchLanguage(lang) { currentLang = lang; const url = new URL(window.location.href); url.searchParams.set('lang', lang); window.history.replaceState({}, '', url); applyTranslations(); }
document.addEventListener('DOMContentLoaded', applyTranslations);
