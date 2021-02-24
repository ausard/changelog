  new_tag=$major_version.$minor_version.$patch_version
  current_date=$(date +"%Y-%m-%d")
  changelog_file="CHANGELOG.md"

if [ -f "$changelog_file" ]; then
    echo "Update changelog"
    sed -i "s/\[NEXT_RELEASE_VERSION\]/$new_tag ($current_date)/" $changelog_file
    git add $changelog_file
    git commit -m "update_changelog_skip_build"
    git push --set-upstream origin master
fi