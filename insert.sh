
match_start='and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).'
match_end='## 1.1.0 (2021-02-24)'
insert='[NEXT_RELEASE_VERSION]'
changelog_file="CHANGELOG.md"
# sed -i '/\[$match_end\]/i $insert' $changelog_file
sed -i '6 a ## [NEXT_RELEASE_VERSION]\n### Added\\Updated\\Delete \n- \n' $changelog_file