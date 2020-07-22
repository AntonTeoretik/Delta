# Using Git

## Know where you are
`git status`
This will tell you your current branch, as well as any tracked (added) and untracked changes.

## Creating a branch
- Navigate to where you want to branch off from.
- `git checkout -b <branch-name>`
You are now on your new branch.

## Commiting changes
You first have to specify all changes you want to commit. You can track all changes with
`git add .`
or the (nearly) equivalent
`git add -A`

Now you can commit.
Commit your changes with
`git commit -m "Change things"

## Pushing (Uploading) changes
To push your changes, use the command `git push origin <your-branch>`
