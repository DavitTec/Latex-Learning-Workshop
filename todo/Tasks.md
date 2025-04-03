# Tasks


- [ ] **FIX:** below to write the correct procedure
  
- [ ] Copy current state of master branch into this docs branch
  
  - [ ] should use tags to mark events in history
  - [ ] Create a tag, that provide its name and the commit it should point to
  - [ ] provide a branch name instead of a commit hash
  - [ ] tag will point to the current tip commit of this branch.
  
    - ```bash
      git tag #001 docs
      ```
  - [ ] Force updating the branch:
  
    - ```bash
      git branch -f docs master
      ```
  - [ ] Pushing the state you want to the branch in the remote repository
  
    - ```bash
      git push origin master:docs
      ```
  
  - [ ] Merging the branch with the `ours` strategy (`-s ours`), to create a new commit with the wanted state. Then pushing to the remote repository.
  
    - ```bash
      git checkout master
      git merge docs  #Merge
      
      git push . docs:master  #Local push
      ```
  
      
  
  - [ ] 
  
  - [ ] 

