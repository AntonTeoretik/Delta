# Using Git
To use any of the git commands open your console either in the directory or a subdirectory of your git project.

## Know where you are
```
git status
```
This will tell you your current branch, as well as any tracked (added) and untracked changes.

## Change branches
To change your current branch, use the command
`git checkout <branch-name>`

## Creating a branch
- Navigate to where you want to branch off from.
- Enter the command `git checkout -b <branch-name>`

You are now on your new branch.

## Committing changes
You first have to specify all changes you want to commit. You can track all changes with
`git add .`
or the (nearly) equivalent
`git add -A`

Now you can commit.
Commit your changes with
`git commit -m "Change things"`

## Pushing (uploading) changes
To push your changes, use the command `git push origin <your-branch>`

## View all commits
To see a graph of the entire history of commits, use the command
`git log --oneline --graph --all`

## Fetching and merging changes
If the state of the online repository changes, you need to `git fetch` before you can see those changes.

If your current branch has changes, you can merge those changes with `git merge origin/<branch-name>`

You can do both of these in one command with `git pull origin <branch-name>`

*Make sure you are on the correct branch when merging or pulling.*
