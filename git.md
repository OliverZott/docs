# Useful GIT commands

- `git status`
- `git log`
- `git diff`
- `git remote -v`
- `git config --global user.email`
  - `--local` by default if nothing
- `git config --global user.name`
- `git config --global user.name "John Doe"`
- `git config --global --list`

## Git merge branches

[link](https://blog.devgenius.io/how-to-merge-two-repositories-on-git-b0ed5e3b4448)

[link](https://medium.com/altcampus/how-to-merge-two-or-multiple-git-repositories-into-one-9f8a5209913f)

``` shell
git clone <https/ssh-link-for-repo1>
git remote add <your-custom-remote-name> <https/ssh-for-repo2>
git remote -v
git fetch <your-custom-remote-name>
git checkout -b <new-branch-name> <your-custom-remote-name>/master
git merge <new-branch-name> --allow-unrelated-histories
```

remote name: e.g. **origin**

## Git create branch with current changes

[link](<https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/git-create-new-branch-with-local-changes-current-saved>)

``` shell
git swtich -b new-git-branch
git add .
git commit -m "Add local changes to new git branch"`
git switch master
git clean -f
```
