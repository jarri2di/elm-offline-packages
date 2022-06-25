import got from 'got';
import fs from 'fs';
import path from 'path';

const packagesUrl = 'https://package.elm-lang.org/all-packages';
const outputFile = '../scripts/elm-packages.txt';

(async () => {
  try {
    console.log('Retrieving list of packages...');
    const response = await got(packagesUrl).json();
    const packages = Object.keys(response);
    fs.writeFileSync(
      path.join(process.argv[1], '..', outputFile),
      packages.toString().replace(/,/g, '\n')
    );
    console.log('Package list has been generated. Ready for installing.');
  } catch (error) {
    console.log(error);
  }
})();
