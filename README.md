# ELFKit

Library for parsing ELF files to obtain various information.

<!-- # Badges -->

[![Github issues](https://img.shields.io/github/issues/p-x9/ELFKit)](https://github.com/p-x9/ELFKit/issues)
[![Github forks](https://img.shields.io/github/forks/p-x9/ELFKit)](https://github.com/p-x9/ELFKit/network/members)
[![Github stars](https://img.shields.io/github/stars/p-x9/ELFKit)](https://github.com/p-x9/ELFKit/stargazers)
[![Github top language](https://img.shields.io/github/languages/top/p-x9/ELFKit)](https://github.com/p-x9/ELFKit/)

## Features

- parse segments
- parse sections
- parse dynamics
- symbol list
- get all cstrings
- rebase infos
- notes
- ...

## Usage

### Load from file

For reading from file, use the `ELFFile` structure.

Reading from a file can be as follows.

```swift
let path = "Path to MachO file"
let url = URL(fileURLWithPath: path)

let elf = try ELFFile(url: url)
```

### Example Codes

There are a variety of uses, but most show a basic example that prints output to the Test directory.

#### Load from file

The following file contains sample code.
[ELFFilePrintTests](./Tests/ELFKitTests/ELFFilePrintTests.swift)

## Related Projects

- [MachOKit](https://github.com/p-x9/MachOKit)
    A swift library for parsing MachO binaries

## License

ELFKit is released under the MIT License. See [LICENSE](./LICENSE)
