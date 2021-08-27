rm -rf dist &&
yarn build &&
cd dist &&
git init &&
git add . &&
git commit -m 'update' &&
git branch -M main &&
git remote add origin git@github.com:tgbf2674/Vue3UI-website.git &&
git push -f -u origin master &&
cd ..
