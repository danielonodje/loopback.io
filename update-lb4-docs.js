const fs = require('fs-extra');
const path = require('path');

const srcDocs = path.resolve(__dirname, 'node_modules', '@loopback', 'docs', 'site');
const srcImages = path.resolve(srcDocs, 'imgs');

const destDocs = path.resolve(__dirname, 'pages', 'en', 'lb4');
const destImages = path.resolve(__dirname, 'images', 'lb4');

async function copyDocs(src, dest) {
    try {
        await fs.copy(src, dest);
    } catch (err) {
        console.error('failed to copy docs %s', err.stack);
    }

}

copyDocs(srcDocs, destDocs);
copyDocs(srcImages, destImages);
await fs.remove(path.resolve(destDocs, 'imgs'));

const fileToUpdate = path.resolve(destDocs, 'Testing-the-API.md');

try {
    let contents = fs.readFileSync(fileToUpdate, 'utf-8');
    contents = contents.replace('include previous.md', 'include previous.html');
    fs.writeFileSync(fileToUpdate, contents,'utf-8');
} catch (err) {
    console.error('failed to replace relative link %s', err.stack);
}

