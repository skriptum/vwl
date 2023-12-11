cd "/Users/marten/Nextcloud/uni"

# new TOC
echo "updating TOC"
python3 TOC.py

echo "pushing changes"

date=$(date '+%Y-%m-%d')
git add .
git commit -m "Update $date"
git push

echo "finished"