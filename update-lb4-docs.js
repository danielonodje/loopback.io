const fs = require('fs-extra');
const path = require('path');

const srcDocs = path.resolve(__dirname,'node_modules/@loopback/docs/site');
const destDocs = path.resolve(__dirname, 'pages/en/lb4');


try {
  fs.removeSync(destDocs);
} catch (err) {
  console.error('failed to cleanup previous docs folder %s', err.stack);
  process.exit(1);
}

function copyDocs(src, dest) {
  try {
    fs.copySync(src, dest);
  } catch (err) {
    console.error('failed to copy latest docs %s', err.stack);
    process.exit(1);
  }
}

copyDocs(srcDocs, destDocs);

const fileToUpdate = path.resolve(destDocs, 'Testing-the-API.md');

try {
  let contents = fs.readFileSync(fileToUpdate, 'utf-8');
  contents = contents.replace('include previous.md', 'include previous.html');
  fs.writeFileSync(fileToUpdate, contents, 'utf-8');
} catch (err) {
  console.error('failed to replace relative link %s', err.stack);
  process.exit(1);
}
