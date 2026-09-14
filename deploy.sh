#!/bin/bash
# Nasadí Chůvičku na GitHub Pages (zdarma, HTTPS). Spustit jednou; opakované spuštění jen pushne změny.
set -e
cd "$(dirname "$0")"
REPO=chuvicka
USER=$(gh api user -q .login)
git init -q 2>/dev/null || true
git branch -M main
git add index.html peerjs.min.js deploy.sh
git commit -qm "Chůvička – WebRTC baby monitor" 2>/dev/null || true
if ! git remote get-url origin >/dev/null 2>&1; then
  gh repo create "$REPO" --public --source=. --push
  gh api -X POST "repos/$USER/$REPO/pages" -f build_type=legacy -f 'source[branch]=main' -f 'source[path]=/' >/dev/null
else
  git push -q origin main
fi
echo
echo "Hotovo. Za cca 1 minutu bude stránka na:  https://$USER.github.io/$REPO/"
