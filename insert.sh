latest_tag=$(git describe --tags $(git rev-list --tags --max-count=1))
changelog_file="CHANGELOG.md"
number_line=$(grep -n $latest_tag $changelog_file | cut -d : -f 1)
sed -i $number_line' i ## [NEXT_RELEASE_VERSION]\n### Added\\Updated\\Delete \n- \n' $changelog_file