-------------------------------------------------------------------------------
created	:	Fri Sep 27 08:36:12 CST 2024
date	:	.

-------------------------------------------------------------------------------

#   #
```bash			================start================
root@bmc-VirtualBox:/mnt/AEWIN/codebase/ast2500evb/ast2500evb#  git checkout CB-1937
####================output================>
## M       packages/ast2500
## M       packages/common
## M       packages/utilities/packages/fwmutility
## M       packages/utilities/packages/vmcli
## M       packages/utilities/packages/yafuflash
## Switched to branch 'CB-1937'
## Your branch is up to date with 'origin/CB-1937'.
```
then use switch submodule
```bash			================start================
root@bmc-VirtualBox:/mnt/AEWIN/codebase/ast2500evb/ast2500evb#  git submodule foreach  git checkout CB-1937
Entering 'packages/ast2500'
Previous HEAD position was 9e82e1d Updated SPX packages version, changelog [skip ci]
Switched to branch 'CB-1937'
Your branch is up to date with 'origin/CB-1937'.
Entering 'packages/common'
Checking out files: 100% (2172/2172), done.
Previous HEAD position was 6689397d1 Updated SPX packages version, changelog [skip ci]
Switched to branch 'CB-1937'
Your branch is up to date with 'origin/CB-1937'.
Entering 'packages/utilities/packages/createhpmimage'
error: pathspec 'CB-1937' did not match any file(s) known to git.
Stopping at 'packages/utilities/packages/createhpmimage'; script returned non-zero status.
```
> note :  error: pathspec 'CB-1937' did not match any file(s) known to git.

let me check
```bash			================start================
root@bmc-VirtualBox:/mnt/AEWIN/codebase/ast2500evb/ast2500evb#  git status
## On branch CB-1937
## Your branch is up to date with 'origin/CB-1937'.
##
## Changes not staged for commit:
##   (use "git add <file>..." to update what will be committed)
##   (use "git checkout -- <file>..." to discard changes in working directory)
##
##         modified:   packages/ast2500 (new commits)
##         modified:   packages/common (new commits)
##         modified:   packages/utilities/packages/fwmutility (new commits)
##         modified:   packages/utilities/packages/vmcli (new commits)
##         modified:   packages/utilities/packages/yafuflash (new commits)
##
## no changes added to commit (use "git add" and/or "git commit -a")
```
use `git submodule update`
```bash			================start================
root@bmc-VirtualBox:/mnt/AEWIN/codebase/ast2500evb/ast2500evb#  git submodule update
## Submodule path 'packages/ast2500': checked out '98f3191a31c9a9f198c6508af048211b5502773f'
## Submodule path 'packages/common': checked out '7128672a04fce650e458d8956b3fbda40cef47d5'
## Submodule path 'packages/utilities/packages/fwmutility': checked out 'a8b4feb492aec6ccb80e5bffcbea5c4ed5bdf25d'
## Submodule path 'packages/utilities/packages/vmcli': checked out 'e4b9bc5828532f759a7b3e03314b5906d0f53088'
## Submodule path 'packages/utilities/packages/yafuflash': checked out '7cb91cb716d0204bf57b1018add37560869e35e8'
```
