const portfolioTranslations = {
  lt: {
    nav_home: 'Pradžia',
    nav_about: 'Apie',
    nav_projects: 'Projektai',
    nav_contact: 'Kontaktai',
    hero_title: 'Mobiliųjų aplikacijų studija',
    hero_subtitle: 'Kuriame iOS ir Android sprendimus, kurie padeda verslui augti.',
    btn_projects: 'Peržiūrėti projektus',
    btn_contact: 'Susisiekti',
    about_title: 'Apie VilcA',
    about_subtitle: 'Nuo idėjos iki paleidimo – padedu suplanuoti, sukurti ir palaikyti programėles.',
    about_text1: 'Esu kurėjas, kuris technines žinias jungia su verslo poreikiais ir aiškiu procesu.',
    about_text2: 'Svarbiausia – naudotojo patirtis, todėl kiekvienas sprendimas kuriamas testuojant realius scenarijus.',
    projects_title: 'Projektai',
    projects_subtitle: 'Pagrindiniai produktai, kurie šiuo metu kuria vertę klientams.',
    rangis_title: 'Rangis – statybų valdymas',
    rangis_desc: 'Išmanus statybos darbų planavimas, užduočių priskyrimas, ataskaitos ir likučių rinka.',
    forceplan_title: 'Forceplan – įdarbinimo agentūroms',
    forceplan_desc: 'Agentūrų procesų valdymas: kandidatai, algalapiai, sąskaitos ir vidinė komunikacija.',
    contact_title: 'Susisiekite su mumis',
    contact_subtitle: 'Siūlykite savo idėjas programėlėms – atrašome per 1 darbo dieną.',
    contact_name: 'Vardas',
    contact_email: 'El. paštas',
    contact_message: 'Žinutė',
    contact_btn: 'Siųsti žinutę',
    copyright: '© ' + new Date().getFullYear() + ' VilcA Mobile Apps. Visos teisės saugomos.'
  },
  en: {
    nav_home: 'Home',
    nav_about: 'About',
    nav_projects: 'Projects',
    nav_contact: 'Contact',
    hero_title: 'Mobile app studio',
    hero_subtitle: 'We craft iOS and Android products that help businesses grow.',
    btn_projects: 'View projects',
    btn_contact: 'Contact me',
    about_title: 'About VilcA',
    about_subtitle: 'From idea to launch – I plan, design and maintain mobile apps.',
    about_text1: 'I connect engineering with business needs and a transparent delivery process.',
    about_text2: 'User experience is key, so every feature is validated against real scenarios.',
    projects_title: 'Projects',
    projects_subtitle: 'Flagship apps that currently deliver value to my clients.',
    rangis_title: 'Rangis – construction management',
    rangis_desc: 'Smart planning for construction teams: tasks, reports and leftover materials trade.',
    forceplan_title: 'Forceplan – for agencies',
    forceplan_desc: 'Hiring agency toolbox: candidates, payslips, invoices and internal comms.',
    contact_title: 'Contact us',
    contact_subtitle: 'Pitch your app ideas – we usually reply within one business day.',
    contact_name: 'Name',
    contact_email: 'Email',
    contact_message: 'Message',
    contact_btn: 'Send message',
    copyright: '© ' + new Date().getFullYear() + ' VilcA Mobile Apps. All rights reserved.'
  }
};

function getPortfolioLang() {
  const params = new URLSearchParams(window.location.search);
  return params.get('lang') || 'lt';
}

let currentLang = getPortfolioLang();

function applyTranslations() {
  const dict = portfolioTranslations[currentLang] || portfolioTranslations.lt;

  document.querySelectorAll('[data-i18n]').forEach((el) => {
    const key = el.getAttribute('data-i18n');
    const value = dict[key];
    if (!value) {
      el.textContent = `MISSING: ${key}`;
      return;
    }
    el.textContent = value;
  });

  const placeholderMap = [
    { id: 'name', key: 'contact_name' },
    { id: 'email', key: 'contact_email' },
    { id: 'message', key: 'contact_message' }
  ];

  placeholderMap.forEach(({ id, key }) => {
    const el = document.getElementById(id);
    if (el && dict[key]) {
      el.placeholder = dict[key];
    }
  });

  const contactBtn = document.getElementById('contact-btn');
  if (contactBtn && dict.contact_btn) {
    contactBtn.textContent = dict.contact_btn;
  }

  document.querySelectorAll('[data-lang-link]').forEach((link) => {
    const base = link.getAttribute('data-lang-link');
    if (base) {
      link.setAttribute('href', `${base}?lang=${currentLang}`);
    }
  });
}

function switchLanguage(lang) {
  currentLang = lang;
  const url = new URL(window.location.href);
  url.searchParams.set('lang', lang);
  window.history.replaceState({}, '', url);
  applyTranslations();
}

document.addEventListener('DOMContentLoaded', applyTranslations);
