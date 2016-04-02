## stay-mirror

Mirrors npm modules recursively [soon] from source into IPFS, with one command.

The goal is to be able to take any npm module, run `stay-mirror $module` and it will mirror all the dependencies and the module itself.

## Usage

`./mirror-sh $MODULE $VERSION`

```
➜  ./mirror.sh colors 1.1.1
Have you created a fork that is available at git@github.com:EverythingStays/colors-stay.git? <y/N> y
Getting details about colors@1.1.1...
Repository: http://github.com/Marak/colors.js.git
Dependencies:
null
Normalizing the repository URL http://github.com/Marak/colors.js.git
Cloning http://github.com/Marak/colors.js.git...
Cloning into './modules/colors-stay'...
remote: Counting objects: 446, done.
remote: Total 446 (delta 0), reused 0 (delta 0), pack-reused 446
Receiving objects: 100% (446/446), 257.58 KiB | 66.00 KiB/s, done.
Resolving deltas: 100% (222/222), done.
Checking connectivity... done.
Checking out version 5958f1677d827fec37275427476499d84613e4a4...
Note: checking out '5958f1677d827fec37275427476499d84613e4a4'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

git checkout -b <new-branch-name>

HEAD is now at 5958f16... [dist] Bump to v1.1.1
Checking out new branch v1.1.1-stay...
Switched to a new branch 'v1.1.1-stay'
Adding to IPFS...
Tagging v1.1.1-stay-release | v1.1.1-QmRQ2t24XhUwjGLNLYh4Jp1kkG7qiSv8wKHhJr7DfFo4w3

You need a passphrase to unlock the secret key for
user: "Victor Bjelkholm <victorbjelkholm@gmail.com>"
4096-bit RSA key, ID AA430AE9, created 2016-03-30

Adding remote...
Pushing with tags...
Counting objects: 1, done.
Writing objects: 100% (1/1), 837 bytes | 0 bytes/s, done.
Total 1 (delta 0), reused 0 (delta 0)
To git@github.com:EverythingStays/colors-stay.git
  * [new branch]      v1.1.1-stay -> v1.1.1-stay
  * [new tag]         v1.1.1-stay-release -> v1.1.1-stay-release
```
