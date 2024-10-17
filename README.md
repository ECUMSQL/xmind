# the tips of git

 1. on your first push, you must add all files modified to the git flash, which usually occurs when you have created new files
 git add . or the exact files names

 2. you must add your modifition to the git repo before you git them to github. And remember fill out the version number, which can help you manage your code between different service computer
git commit -m "version number"

 3. you must solve the counter between your local repo and the github repo. The most common way is that delete your local repo and pull the github repo.But the premise of that is that the local repo is behind the github repo. The other way is to discard all the changes of your local repo.
 git pull origin (the branch name)

 4. when you want to push your local repo.
 git push origin (the branch name)