mess=$1
push=$2

echo "$mess $push"

git add .
git commit -m "$mess"
if [ $push == 1 ]
then git push
fi
