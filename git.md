# GIT

- merges (standard, squash, rebase): [link1](https://mattrickard.com/squash-merge-or-rebase) [link2](https://www.youtube.com/watch?v=pvlTs8ukbNE)
- fast forward... no merge commit

## Workflow

1. Create a Feature Branch e.g.: `YT-23_add_api_controller`
1. Commit and push code regularly and smart with standardized commit message e.g.: `feat: Add controller for user api endpoint #YT-23`
1. Before opening Pull Request, merge Main into Feature Branch and solve conflicts
1. Code Review by other developer
1. If ok, Reviewer completes merge
1. Cleanup: delete local and remote Feature Branch

## Git Merge Strategies

| Merge Type       | Pros                                           | Cons                                        | Best For |
|-----------------|-----------------------------------------------|---------------------------------------------|---------|
| **Standard Merge** (`git merge`) | Keeps history, simple | Creates cluttered history | Team projects, debugging |
| **Squash Merge** (`git merge --squash`) | Clean history, one commit per feature | Loses individual commit details | Feature branch merges |
| **Rebase** (`git rebase`) | Linear history, no merge commits | Can cause conflicts, rewrites history | Keeping branches updated |

## Commit Messages

### General

- Use present tense: Instead of “Fixed bug” (past tense), write “Fix bug” (present tense).
This keeps consistency with Git's commit descriptions.
- Be concise but informative: A commit message should clearly explain the what and why, not just the how. Avoid vague statements like “Update code” and
instead describe the change, e.g., “Improve performance of data processing by optimizing loop structure.”
- Limit line length: Keep subject lines to 50 characters or less, and body text lines to 72 characters to ensure readability in different interfaces
- Separate subject from body: The first line should be a short summary. If necessary, add further explanation below after a blank line.

### Formatting

- Start with keyword
  - **feat:**
  - **fix:**
  - **chore:**
  - **docs:**
  - **refactor:**
  - **test:**
- Use **short imperative statement**, e.g., “Add unit tests for login validation”
- Use bullet points or paragraphs to explain why the change was made and any important details
- Use **ticket number** instead description, if existing!

### Examples

- Youtrack issue tracker:
  - `[commit message text] #issueID [command 1] [command 2] ... [command n] and/or [state]
    [issue comment text]`
  - `chore: Change issue state #YT-33 In Progress`
- Github issue tracker:
  - ``

## Useful GIT commands

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
