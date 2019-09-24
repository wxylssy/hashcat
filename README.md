## 说明 ##

这是 **hashcat** 的一个 fork，**hashcat** 是一个基于OpenCL的密码哈希恢复程序，可使用GPU高速计算，速度非常快，由于算法都写在相应模块中，所以不支持自定义算法类型，本fork主要是为解决自定义算法类型。

## 注意事项 ##
由于 **hashcat** 会进行自检，所以需要去掉相关检查代码，否则需要加 --self-test-disable 选项，为了方便，已去除。具体在 hashcat.c 文件第702行的 outer_loop 函数中，将if语句块注释掉。

## 函数标记 ##
检查选项 scr/user_options.c -> user_options_check_files
内核载入 scr/interface.c -> hashconfig_init

scr/user_options.c 第2568行是载入基础内核模块：
generate_source_kernel_filename (false, ATTACK_EXEC_OUTSIDE_KERNEL, ATTACK_KERN_STRAIGHT, 400, 0, folder_config->shared_dir, kernelfile);

## *hashcat* ##

**hashcat** is the world's fastest and most advanced password recovery utility, supporting five unique modes of attack for over 200 highly-optimized hashing algorithms. hashcat currently supports CPUs, GPUs, and other hardware accelerators on Linux, Windows, and macOS, and has facilities to help enable distributed password cracking.

### License ###

**hashcat** is licensed under the MIT license. Refer to [docs/license.txt](docs/license.txt) for more information.

### Installation ###

Download the [latest release](https://hashcat.net/hashcat/) and unpack it in the desired location. Please remember to use `7z x` when unpacking the archive from the command line to ensure full file paths remain intact.

### Usage/Help ###

Please refer to the [Hashcat Wiki](https://hashcat.net/wiki/) and the output of `--help` for usage information and general help. A list of frequently asked questions may also be found [here](https://hashcat.net/wiki/doku.php?id=frequently_asked_questions). The [Hashcat Forum](https://hashcat.net/forum/) also contains a plethora of information.

### Building ###

Refer to [BUILD.md](BUILD.md) for instructions on how to build **hashcat** from source.

Tests:

Travis | Appveyor | Coverity
------ | -------- | --------
[![Hashcat Travis Build status](https://travis-ci.org/hashcat/hashcat.svg?branch=master)](https://travis-ci.org/hashcat/hashcat) | [![Hashcat Appveyor Build status](https://ci.appveyor.com/api/projects/status/github/hashcat/hashcat?branch=master&svg=true)](https://ci.appveyor.com/project/jsteube/hashcat) | [![Coverity Scan Build Status](https://scan.coverity.com/projects/11753/badge.svg)](https://scan.coverity.com/projects/hashcat)

### Contributing ###

Contributions are welcome and encouraged, provided your code is of sufficient quality. Before submitting a pull request, please ensure your code adheres to the following requirements:

1. Licensed under MIT license, or dedicated to the public domain (BSD, GPL, etc. code is incompatible)
2. Adheres to gnu99 standard
3. Compiles cleanly with no warnings when compiled with `-W -Wall -std=gnu99`
4. Uses [Allman-style](https://en.wikipedia.org/wiki/Indent_style#Allman_style) code blocks & indentation
5. Uses 2-spaces as the indentation or a tab if it's required (for example: Makefiles)
6. Uses lower-case function and variable names
7. Avoids the use of `!` and uses positive conditionals wherever possible (e.g., `if (foo == 0)` instead of `if (!foo)`, and `if (foo)` instead of `if (foo != 0)`)
8. Use code like array[index + 0] if you also need to do array[index + 1], to keep it aligned

You can use GNU Indent to help assist you with the style requirements:

```
indent -st -bad -bap -sc -bl -bli0 -ncdw -nce -cli0 -cbi0 -pcs -cs -npsl -bs -nbc -bls -blf -lp -i2 -ts2 -nut -l1024 -nbbo -fca -lc1024 -fc1
```

Your pull request should fully describe the functionality you are adding/removing or the problem you are solving. Regardless of whether your patch modifies one line or one thousand lines, you must describe what has prompted and/or motivated the change.

Solve only one problem in each pull request. If you're fixing a bug and adding a new feature, you need to make two separate pull requests. If you're fixing three bugs, you need to make three separate pull requests. If you're adding four new features, you need to make four separate pull requests. So on, and so forth.

If your patch fixes a bug, please be sure there is an [issue](https://github.com/hashcat/hashcat/issues) open for the bug before submitting a pull request. If your patch aims to improve performance or optimize an algorithm, be sure to quantify your optimizations and document the trade-offs, and back up your claims with benchmarks and metrics.

In order to maintain the quality and integrity of the **hashcat** source tree, all pull requests must be reviewed and signed off by at least two [board members](https://github.com/orgs/hashcat/people) before being merged. The [project lead](https://github.com/jsteube) has the ultimate authority in deciding whether to accept or reject a pull request. Do not be discouraged if your pull request is rejected!

### Happy Cracking!
