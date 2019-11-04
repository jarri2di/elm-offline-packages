# elm-offline-packages

Download current elm-lang packages for offline development.

```bash
# Make sure elm is installed
npm install -g elm

# Install app
npm install

# Refresh packages.txt
npm start

# Download packages
cd scripts
./generate_packages.sh

# Save as tar.gz (optional)
 cd ~/ && tar czvf elm-packages.tar.gz .elm
```
