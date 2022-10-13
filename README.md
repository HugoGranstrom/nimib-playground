# nimib-playground
An experiment at creating a playground-like experience for creating one-off nimibs

## The idea
If you want to explain a piece of code to someone, it is convinient to use the [Nim playground](play.nim-lang.org) to show the code.
But what if you want to explain the code more than that? You could add a bunch of comments to the code. For shorter pieces of code it works,
but if you want to also show what the different parts of the code actually does (printing out their results for example), then it gets harder.

The other extreme would be that you write a proper blog post in for example [nimib](https://github.com/pietroppeter/nimib) where you divide the
code into smaller bits and add explainations and shows the outputs. This is not as convinient to do currently if it's just a one-off thing. 
Nimib-playground is an experiment to try and bridge these two extremes. It allow you to easily create one-off nimibs that you can publish to
for example Github pages (or any other git-based service) with a single command. It will then give you a link to the document which you can share
with people. 

## Usage
### Setup
This you will just have to do once:
1. Fork this repo and remove the contents of the `docs/` and `drafts/` folders.
2. Enable Github pages for your repo and note the link to the website.
3. Edit `nimblePlayground.nimble` and change the `webAddress` variable to the link to your website. In my case I do:
```nim
let webAddress = "https://hugogranstrom.github.io/nimib-playground/"
```

### Creating a nimib
To create a nimib can be done using
```
nimble newNimib <prefix>
```
where `<prefix>` is what name you want to give to the nimib that you will create. This will create a folder in `drafts/` named `<prefix>--currentDate--currentTime/`. This folder will have a single file in it, `index.nim` which contains the bare minimum nimib boilerplate. This file is your new nimib and this is the file that you will edit. For your convinice, the program will echo the path to this `index.nim` file if your editor supports clicking links. 

### Publish a nimib
To publish a nimib you use the following task:
```
nimble publishNimib <prefix>
```
where `<prefix>` is the prefix you created the nimib with.

> if you create multiple nimibs with the same prefix, this command will complain that you have multiple matching nimibs. In that case, specify enough of the folder name so that it can distinguish between them.

After running this, it will move the folder to `docs/`, commit it and push it to your repo. It will echo the URL you can reach your newly published nimib on.

> It may take a few minutes until Github Pages has updated the page.

## Feedback
If you have any ideas for how to improve this, I'm all ears 👂️
