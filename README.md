# Introduction

The intent of this project is to play around with SwiftUI, ReSwift, and other iOS features such as Widgets, App Clips, etc. I'm also hoping that this project can serve as a base for any future development.

## Design Decisions

# Tools, Frameworks, Libraries

For all tools, libraries, etc. used, please reference their documentation for information about the framework. The descriptions below will be specific to the usage within this project.

## Swift Packages Used

### [ReSwift](https://github.com/ReSwift/ReSwift)

### [ReSwift-Thunk](https://github.com/ReSwift/ReSwift-Thunk)

### [SFSafeSymbols](https://github.com/SFSafeSymbols/SFSafeSymbols)

### [Quick](https://github.com/Quick/Quick)

### [Nimble](https://github.com/Quick/Nimble)

## Build Steps/Command Line tools

All versions specified are versions used at the time of writing this. They may change over time and should be maintained by the developers here and in the [MintFile](Mintfile). Incase they are not, ensure you check the appropriate files for the versions to use when running the commands.

**Note:** For anything that generates a file, you'll need to add the folder to the gitignore with a gitkeep like was done with the "ToDo/Resources/Generated" folder. You also need to add a touch and command in the `preGenCommand` of the [project.yml](project.yml) such that xcodegen will add the file to the project structure.

### [Mint](https://github.com/yonaskolb/Mint)

Mint is being used to manage the command line tools used that are compatible with Swift Package Manager.

To install mint you can use brew to manage it's version:

```bash
brew install mint@0.17.2
```

To get started installing all the command line tools you need to bootstrap the project with mint:

```bash
mint bootstrap
```

Since multiple version may be installed depending on the version the specific project uses, you need to specify the version when running the command.

```bash
# E.g. for xcodegen you run
mint run yonaskolb/XcodeGen@2.32.0
```

### [XcodeGen](https://github.com/yonaskolb/XcodeGen)

Xcodegen is a powerful tool for managing and creating the xcodeproj file. This file can be a challenge to maintain when performing merges, so we generate this file instead to reduce the time spent managing the merging of this file and reduce the risk of issues popping up due to improper merges.

```bash
# Manually run using (check Mintfile for proper version)
mint run yonaskolb/XcodeGen@2.32.0
```

### [SwiftGen](https://github.com/SwiftGen/SwiftGen)

SwiftGen removes the requirements for raw strings to be used within the project for Assets specified in the [configuration file](swiftgen.yml). This allows us to remove mistakes of mistyped strings causing the application to not display items properly. It also gives us a system to know when these values have been changed (e.g. renamed) so that we update them within the project itself.

This is set up as a build step using xcodegen's [project file](project.yml) to inject it into the project. Whenever the application is built, these values will be regenerated.

```bash
# Manually run using (check Mintfile for proper version)
mint run SwiftGen/SwiftGen@6.6.2
```

### [SwiftFormat](https://github.com/nicklockwood/SwiftFormat)

SwiftFormat provides us with consistent formatting throughout the project. It helps ensure that the look of the code is always consistent within the project. You need to also maintain the swift-version file so that the formatter knows how to properly format specific items based on the swift version used.

**_TBD When to run this? It's ok as a build step, but as the project get's larger, you'd want to only run this on files with changes as a build step OR maybe only on commit?_**

```bash
# Manually run using (check Mintfile for proper version)
mint run nicklockwood/SwiftFormat@0.50.0
```

### [SwiftLint](https://github.com/realm/SwiftLint)

SwiftLint will ensure that developers are following the latest code standards for swift, a consistent style, breaking up code where needed, and keep the project overall cleanliness maintained. This is run as a build step within the project so that each build will produce the appropriate warnings/errors where items need to be improved.

```bash
# Manually run using (check Mintfile for proper version)
mint run realm/SwiftLint@0.49.1
```
