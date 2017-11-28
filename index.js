const puppeteer = require('puppeteer');

(async () => {
    const start = new Date();
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.goto('https://www.chromestatus.com', {waitUntil: 'domcontentloaded'});
    await page.emulateMedia(null);
    await page.pdf({path: 'hn.pdf', printBackground: true});

    await browser.close();

    const end = new Date();

    console.log((end - start) / 1000);

})();