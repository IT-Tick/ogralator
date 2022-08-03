#!/bin/sh

export LANG=C.UTF-8

# Get current version
pub_version_field=$(cat pubspec.yaml | grep -m 1 "version:")

pub_version=$(echo "$pub_version_field" | cut -d " " -f 2)

build_number=$(echo "$pub_version" | cut -d "+" -f 2)
version_number=$(echo "$pub_version" | cut -d "+" -f 1)

echo "INFO:: Pub version: \"$pub_version\""

major=$(echo "$version_number" | cut -d "." -f 1)
minor=$(echo "$version_number" | cut -d "." -f 2)
patch=$(echo "$version_number" | cut -d "." -f 3)

# Get git change logs
git_tag=$(git tag | grep "v$version_number")
git_last_commit=$(git rev-list HEAD | head -1)
git_first_commit=$(git rev-list --max-parents=0 HEAD)


if [[ $git_tag ]]
then
  echo "INFO:: Tag $git_tag found"
  echo "INFO:: Found tag with name \"$git_tag\""
  git_start_ref=$git_tag
else
  echo "WARNING:: Couldn't find tag with name \"v$version_number\""
  echo "INFO:: Falling back to the first commit"
  git_start_ref=$git_first_commit
fi

git_logs=$(git log --pretty="%s" $git_start_ref...$git_last_commit)

# Split change logs

breaking_logs=$(echo "$git_logs" | grep -i "^BREAKING CHANGE")
feat_logs=$(echo "$git_logs" | grep -i '^feat')
fix_logs=$(echo "$git_logs" | grep -i "^fix")
perf_logs=$(echo "$git_logs" | grep -i "^perf")

# Get upgraded version
if [[ $breaking_logs ]]
then
  echo "INFO:: Breaking changes found. Upgrading major version"
  major=$(($major + 1))
elif [[ $feat_logs ]]
then
  echo "INFO:: New features found. Upgrading minor version"
  minor=$(($minor + 1))
elif [[ $fix_logs  || $perf_logs ]]
then
  echo "INFO:: New fixes found. Upgrading patch version"
  patch=$(($patch + 1))
else
  echo "INFO:: No changes found. Nothing to do."
  exit 0
fi

new_version="$major.$minor.$patch"
new_build_number=$(($build_number + 1))
new_pub_version="$new_version+$new_build_number"
echo "INFO:: New version is \"$new_pub_version\""

# Create change logs
today=$(date +"%Y-%m-%d")
md_changelogs="## Version $new_version ($new_build_number) - $today\n\n"
txt_changelogs="Version $new_version ($new_build_number) - $today\n\n"

if [[ $breaking_logs ]]
then
  md_changelogs+="### Breaking changes\n\n"
  txt_changelogs+="Breaking changes\n\n"

  items_list=$(echo `echo "$breaking_logs"  | cut -d ":" -f 2- | xargs -I @ echo "- @\n"`)
  md_changelogs+=$items_list
  txt_changelogs+=$items_list

  md_changelogs+="\n"
  txt_changelogs+="\n"
fi

if [[ $feat_logs ]]
then
  md_changelogs+="### New features\n\n"
  txt_changelogs+="New features\n\n"

  items_list=$(echo `echo "$feat_logs"  | cut -d ":" -f 2- | xargs -I @ echo "- @\n"`)
  md_changelogs+=$items_list
  txt_changelogs+=$items_list

  md_changelogs+="\n"
  txt_changelogs+="\n"
fi

if [[ $perf_logs ]]
then
  md_changelogs+="### Performance enhancements\n\n"
  txt_changelogs+="Performance enhancements\n\n"

  items_list=$(echo `echo "$perf_logs"  | cut -d ":" -f 2- | xargs -I @ echo "- @\n"`)
  md_changelogs+=$items_list
  txt_changelogs+=$items_list

  md_changelogs+="\n"
  txt_changelogs+="\n"
fi

if [[ $fix_logs ]]
then
  md_changelogs+="### Fixes\n\n"
  txt_changelogs+="Fixes\n\n"

  items_list=$(echo `echo "$fix_logs"  | cut -d ":" -f 2- | xargs -I @ echo "- @\n"`)
  md_changelogs+=$items_list
  txt_changelogs+=$items_list

  md_changelogs+="\n"
  txt_changelogs+="\n"
fi

# Update pubspec.yaml
echo "INFO:: Updating \"pubspec.yaml\" version to \"$new_pub_version\""
cat pubspec.yaml | sed "/$pub_version_field/s//version: $new_pub_version/"  > pubspec.yaml

# Update CHANGELOG.md
changelog_placeholder="<!--#-->"

echo "INFO:: Updating \"CHANGELOG.md\""
cat CHANGELOG.md | sed "/^$changelog_placeholder/a $md_changelogs" > CHANGELOG.md

# Add fastlane android change log
changelog_path="./android/fastlane/metadata/android/ar/changelogs"

echo "INFO:: Creating android change log for build number \"$new_build_number\""
echo -e $txt_changelogs > $changelog_path/$new_build_number.txt

# Commit to git
git add \
  ./pubspec.yaml \
  ./CHANGELOG.md \
  $changelog_path/$new_build_number.txt

git commit -m "chore: release v$new_version"
git tag v$new_version

exit 0

