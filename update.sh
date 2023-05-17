echo "fetching subtrees"
git fetch vwl1 master
git subtree pull --prefix ./vwl1 vwl1 vwl1 main --squash

git fetch vwl2 master
git subtree pull --prefix ./vwl2 vwl2 vwl2 main --squash

git fetch vwl3 master
git subtree pull --prefix ./vwl3 vwl3 vwl3 master --squash

git fetch vwl4 master
git subtree pull --prefix ./vwl4 vwl4 vwl4 master --squash

echo "updating TOC"
python3 TOC.py

echo "pushing changes"

date=$(date '+%Y-%m-%d')
git add .
git commit -m "Update: $(date '+%Y-%m-%d')"
git push

echo "finished"