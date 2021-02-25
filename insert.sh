latest_tag=$(git describe --tags $(git rev-list --tags --max-count=1))
changelog_file="CHANGELOG.md"
  if [ -f "$changelog_file" ]; then
    echo "Insert pattern in changelog"
    number_line=$(grep -n $latest_tag $changelog_file | cut -d : -f 1)
    if [ $number_line -gt 0 ]; then
        sed -i $number_line' i ## [NEXT_RELEASE_VERSION]\n### Added\|Updated\|Delete \n- \n' $changelog_file
    else
        sed -i '$ a ## [NEXT_RELEASE_VERSION]\n### Added\|Updated\|Delete \n- \n' $changelog_file
    fi 
    git add $changelog_file
    git commit -m "update_changelog_skip_build"
    git push 
  fi