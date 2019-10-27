const fs = require('fs');
const client = require('got');
const path = require('path');

const packagesUrl = 'https://package.elm-lang.org/all-packages';
const outputFile = '../scripts/elm-packages.txt';

(async () => {
  try {
    const response = await client.get(packagesUrl, { json: true });
    const packages = Object.keys(response.body);
    fs.writeFileSync(path.join(__dirname, outputFile), packages.toString().replace(/,/g, '\n'));
  } catch (error) {
    console.log(error);
  }
})();
