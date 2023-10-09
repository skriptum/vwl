cd "/Users/marten/Tresors/m's tresor/3 Projekte/34 Web/34.02 docsify vwl"

echo pwd
echo "updating TOC"
python3 TOC.py

echo "pushing changes"

date=$(date '+%Y-%m-%d')
git add .
git commit -m "Update $date"
git push

echo "finished"