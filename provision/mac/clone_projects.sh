  gh repo list rodrimaia --limit 1000 --json name --jq ".[]|.name"  | while read -r repo _; do
      gh repo clone "$repo" "~/projects/$repo" -- --recursive
    done
