echo "---------------------- variables ----------------------"
if [[ $(git describe --tags $(git rev-list --tags --max-count=1) | grep -oP '^((([0-9]+)\.([0-9]+)\.([0-9]+)))$') ]];
then
    latest_tag=$(git describe --tags $(git rev-list --tags --max-count=1))
    nr_of_differences=$(git diff --name-only main $latest_tag | wc -l)
    if [[ $latest_tag == '0.0.0' && $nr_of_differences -eq 0 ]];
    then
        echo "zero_release=true" | tee -a release.properties
        echo "new_release=false" | tee -a release.properties
        echo "latest_tag=${latest_tag}" | tee -a release.properties
        echo "nr_of_differences=${nr_of_differences}" | tee -a release.properties
        echo "new_tag=${latest_tag}" | tee -a release.properties
    elif [[ $nr_of_differences -gt 0 ]];
    then
        echo "zero_release=false" | tee -a release.properties
        echo "new_release=true" | tee -a release.properties
    else
        echo "zero_release=false" | tee -a release.properties
        echo "new_release=false" | tee -a release.properties
        echo "latest_tag=${latest_tag}" | tee -a release.properties
        echo "nr_of_differences=${nr_of_differences}" | tee -a release.properties
        echo "new_tag=${latest_tag}" | tee -a release.properties
    fi
else
    latest_tag="0.0.0"
    new_tag="0.0.0"
    nr_of_differences=0
    git tag -a ${new_tag} -m "release ${new_tag}"
    git push origin ${new_tag} --quiet
    echo "zero_release=true" | tee -a release.properties
    echo "new_release=false" | tee -a release.properties
    echo "latest_tag=${latest_tag}" | tee -a release.properties
    echo "nr_of_differences=${nr_of_differences}" | tee -a release.properties
	echo "new_tag=${new_tag}" | tee -a release.properties
fi

if [ $nr_of_differences -gt 0 ]; then
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
  current_date=$(date +"%Y-%m-%d")
  changelog_file="CHANGELOG.md"

  if [ -f "$changelog_file" ]; then
    echo "Update changelog"
    sed -i "s/\[NEXT_RELEASE_VERSION\]/$new_tag ($current_date)/" $changelog_file
    git add $changelog_file
    git commit -m "update_changelog_skip_build"
    git push --set-upstream origin main
  fi

  echo "Create git tag"
  git tag -a ${new_tag} -m "release ${new_tag}"
  git push origin ${new_tag} --quiet

  echo "latest_tag=${latest_tag}" | tee -a release.properties
  echo "nr_of_differences=${nr_of_differences}" | tee -a release.properties
  echo "new_tag=${new_tag}" | tee -a release.properties
fi
echo "---------------------- variables ----------------------"