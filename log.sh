latest_tag=$(git describe --tags $(git rev-list --tags --max-count=1))

current_date=$(date +"%Y-%m-%d")
changelog_file="CHANGELOG.md"

last_branch=$(git log --first-parent --merges -1 --oneline)
hotfix_branch='hotfix/'
bugfix_branch='bugfix/'
major_version=$(grep -oP '\w+(?=[.])' <<< "${latest_tag}" | head -1)
minor_version=$(grep -oP '(?<=[.])\w+(?=[.])' <<< "${latest_tag}")
patch_version=$(grep -oP '(?<=[.])\w+' <<< "${latest_tag}" | tail -n 1)

# New projects should start from 1.0.0 the first time they are merged with master
if [[ $major_version == '0' ]];
then
    major_version='1'
    minor_version='0'
    patch_version='0'
elif [[ $last_branch == *$hotfix_branch* ]];
then
	let "patch_version++"
elif [[ $last_branch == *$bugfix_branch* ]];
then
    let "patch_version++"
else
	let "minor_version++"
	patch_version=0
fi
new_tag=$major_version.$minor_version.$patch_version
if [ -f "$changelog_file" ]; then
    echo "Update changelog"
    sed -i "s/\[NEXT_RELEASE_VERSION\]/$new_tag ($current_date)/" $changelog_file
    git add $changelog_file
    git commit -m "update_changelog_skip_build"
    git push --set-upstream origin main
fi