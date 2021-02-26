echo "----Insert pattern in CHANGELOG---"
branch=$(git branch --show-current)
latest_tag=$(git describe --tags $(git rev-list --tags --max-count=1))

changelog_file="CHANGELOG.md"
if [ ! -f "$changelog_file" ]; then  
    echo '# Changelog
All notable changes to this project will be documented in this file.
 
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
' > CHANGELOG.md 
fi
if ! grep -qF "## [NEXT_RELEASE_VERSION]" $changelog_file; then
  tag_line=$(grep -n '## '$latest_tag'' $changelog_file | cut -d : -f 1)
  if [ $tag_line -gt 0 ]; then    
      sed -i $tag_line' i ## [NEXT_RELEASE_VERSION]\n### Added\|Updated\|Delete \n- \n' $changelog_file
  else
      description_line=$(grep -n 'and this project adheres to \[Semantic Versioning\]' $changelog_file | cut -d : -f 1)
      if [ $description_line -gt 0 ]; then
          sed -i $description_line' a \\n## [NEXT_RELEASE_VERSION]\n### Added\|Updated\|Delete \n- ' $changelog_file
      else 
          sed -i '$ a ## [NEXT_RELEASE_VERSION]\n### Added\|Updated\|Delete \n- \n' $changelog_file
      fi
  fi 
  git add $changelog_file
  git commit -am "update_changelog_skip_build"
  git push 
fi
echo "----------------------------------"