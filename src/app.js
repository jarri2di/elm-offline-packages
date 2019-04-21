const fs = require('fs');
const Nightmare = require('nightmare');

const nightmare = Nightmare({ show: false });
const url = 'https://package.elm-lang.org';

function getUniquePackages(packagesFromHtml) {
  const uniquePackages = [];
  packagesFromHtml.sort().forEach(rawPackage => {
    const sanitizedPackage = rawPackage.replace('/packages/', '');
    if (uniquePackages.indexOf(sanitizedPackage) < 0) {
      uniquePackages.push(sanitizedPackage);
    }
  });

  return uniquePackages;
}

function saveToFile(data) {
  fs.writeFileSync('packages.txt', data);
}

nightmare
  .goto(url)
  .wait('body')
  .evaluate(() => document.querySelector('body > div.center > div.catalog').innerHTML)
  .end()
  .then(response => {
    const packagesFromHtml = response.match(/\/packages\/[\w-]+\/[\w-]+/g);
    const uniquePackages = getUniquePackages(packagesFromHtml);
    saveToFile(uniquePackages.toString().replace(/,/g, '\n'));
    console.log('Package list saved to packages.txt');
    process.exit();
  })
  .catch(error => {
    console.error(error);
  });
