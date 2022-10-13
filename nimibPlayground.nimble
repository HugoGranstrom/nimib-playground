version       = "0.1"
author        = "Hugo Granström"
description   = "nimib playground experiment"
license       = "MIT"

skipDirs = @["drafts/", "docs/"]

requires "nimib >= 0.3.1"

import std/[os, strutils]

let webAddress = "https://hugogranstrom.github.io/nimib-playground/"


task newNimib, "Create a new nimib":
  let commands = commandLineParams()
  var argumentsStart: int
  # Find the task's index
  for i in 0 .. commands.high:
    if nimIdentNormalize("newNimib") == nimIdentNormalize(commands[i]):
      argumentsStart = i + 1

  if argumentsStart > commands.high:
    assert false, "No folder name was given! Usage: nimble newNimib folderPrefix"
  var folderPrefix = commands[argumentsStart]
  folderPrefix.removeSuffix('/')
  let folderName = folderPrefix & "--" & CompileDate & "--" & CompileTime.replace(':', '-')
  echo "Folder name: ", folderName
  mkDir("drafts" / folderName)
  writeFile("drafts" / folderName / "index.nim", """
import nimib

nbInit



nbSave
""")
  echo "Created file: ", currentSourcePath().parentDir() / "drafts" / folderName / "index.nim"

task publishNimib, "Publishes a nimib to your personal nimib playground":
  let commands = commandLineParams()
  var argumentsStart: int
  # Find the task's index
  for i in 0 .. commands.high:
    if nimIdentNormalize("publishNimib") == nimIdentNormalize(commands[i]):
      argumentsStart = i + 1
  if argumentsStart > commands.high:
    assert false, "No folder name was given! Usage: nimble publishNimib folderPrefix"
  var folderPrefix = commands[argumentsStart]
  folderPrefix.removeSuffix('/')
  echo "Folder prefix: ", folderPrefix

  var matchedFolders: seq[string]
  for dir in listDirs("drafts"):
    var dirClean = dir
    dirClean.removePrefix("drafts/")
    if dirClean.startsWith(folderPrefix):
      matchedFolders.add dirClean
  
  if matchedFolders.len == 0:
    echo "No folder found with prefix: ", folderPrefix
  elif matchedFolders.len > 1:
    echo "Ambigous folder prefix. Specify it more precisely. It matches these folders:\n", matchedFolders
  else:
    # Add check here that index.html exists!
    let folderName = matchedFolders[0]
    if not fileExists("drafts" / folderName / "index.html"):
      echo "File is not built! Building index.nim..."
      exec "nim r " & "drafts" / folderName / "index.nim"
    let destFolder = "docs" / folderName
    mvDir("drafts" / folderName, destFolder)
    exec "git add " & destFolder
    exec "git commit -m \"" & folderName & "\""
    exec "git push"
    echo "Your nimib will be published to: ", webAddress / folderName


