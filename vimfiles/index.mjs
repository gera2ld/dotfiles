import { spawn } from 'child_process';
import { link, mkdir, readFile, rm, symlink, writeFile } from 'fs/promises';
import { homedir, platform } from 'os';
import { dirname, join } from 'path';
import { fileURLToPath } from 'url';
import which from 'which';

const isWin = platform() === 'win32';
const dotVim = join(homedir(), '.vim');
const configRoot = join(homedir(), isWin ? 'AppData/Local' : '.config');
const uniLink = isWin ? link : symlink;
let vimExe;

// Vim in Windows does not support `\\`
function normalizePath(path) {
  return path.replace(/\\/g, '/');
}

async function linkForce(src, dst) {
  try {
    await rm(dst);
  } catch {
    // ignore
  }
  await uniLink(src, dst);
}

async function runCommand(cmd, args, opts) {
  const p = spawn(cmd, args, { stdio: 'inherit', ...opts });
  return new Promise((resolve, reject) => {
    p.on('exit', (code) => {
      if (code) reject(code);
      else resolve();
    });
  });
}

async function preparePython() {
  const poetry = await which('poetry');
  if (!poetry) {
    console.error('Poetry is not found, skipping Python');
    return;
  }
  console.log('Prepare Python...');
  await runCommand(poetry, ['install', '--only', 'main']);
}

async function installForNvim() {
  const exe = await which('nvim', { nothrow: true });
  if (!exe) {
    console.log('Neovim is not found');
    return;
  }
  vimExe ||= exe;
  console.log('Install for Neovim...');
  const configDir = join(configRoot, 'nvim');
  await mkdir(configDir, { recursive: true });
}

async function installForVim() {
  const exe = await which('vim', { nothrow: true });
  if (!exe) {
    console.log('Vim is not found');
    return;
  }
  vimExe ||= exe;
  console.log('Install for Vim...');
  const configDir = join(homedir(), '.vim');
  await mkdir(configDir, { recursive: true });
}

async function downloadFile(url, out) {
  await mkdir(dirname(out), { recursive: true });
  const res = await fetch(url);
  const content = await res.text();
  await writeFile(out, content);
}

async function installPlugins() {
  if (!vimExe) {
    throw new Error('Neither Vim or Neovim is found');
  }
  console.log('Install plugins...');
  await downloadFile(
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
    join(dotVim, 'autoload/plug.vim'),
  );
  // Install Vim plugins
  await runCommand(vimExe, ['+PlugInstall', '+qall']);
  // Install Coc plugins
  const extDir = join(configRoot, 'coc/extensions');
  await mkdir(extDir, { recursive: true });
  const pkgPath = join(extDir, 'package.json');
  let pkg;
  try {
    pkg = JSON.parse(await readFile(pkgPath));
  } catch {
    // ignore
  }
  pkg = {
    dependencies: Object.assign(
      Object.fromEntries(
        [
          '@yaegassy/coc-marksman',
          '@yaegassy/coc-volar', // deprecate 'coc-vetur'
          'coc-css',
          'coc-deno',
          'coc-emmet',
          'coc-eslint',
          'coc-floaterm',
          'coc-format-json',
          'coc-git',
          'coc-go',
          'coc-highlight',
          'coc-html',
          'coc-jest',
          'coc-json',
          'coc-lists',
          'coc-markmap',
          'coc-pairs',
          'coc-powershell',
          'coc-prettier',
          'coc-pyright',
          'coc-reveal',
          'coc-rls',
          'coc-snippets',
          'coc-svelte',
          // 'coc-tsserver', // disabled in favor of coc-volar
          'coc-yank',
          'coc-zls',
        ].map((name) => [name, '>=0.0.0']),
      ),
      pkg?.dependencies,
    ),
  };
  await writeFile(pkgPath, JSON.stringify(pkg, null, 2));
  await runCommand('npm', ['x', '-y', 'npm-check-updates', '--', '-u'], {
    cwd: extDir,
  });
  await runCommand(
    'npm',
    [
      'install',
      '--global-style',
      '--ingore-scripts',
      '--no-bin-links',
      '--no-package-lock',
      '--only=prod',
    ],
    { cwd: extDir },
  );
}

async function main() {
  await preparePython();
  await installForNvim();
  await installForVim();
  await installPlugins();
}

main().catch((err) => {
  console.error(err);
  process.exitCode = 1;
});
