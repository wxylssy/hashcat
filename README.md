## 说明 ##

这是 **hashcat** 的一个 fork，**hashcat** 是一个基于OpenCL的密码哈希恢复程序，可使用GPU高速计算，速度非常快，由于算法都写在相应模块中，所以不支持自定义算法类型，本fork主要是为解决自定义算法类型。

支持的算法类型在这里：https://hashcat.net/wiki/doku.php?id=example_hashes

## 注意事项 ##

**hashcat** 对签名算法进行了大量优化，但是给修改带来了很大困难，不能在内核模块中直接修改签名函数，因为数据是经过转化的。

一个算法类型分2个文件，一个**模块文件**和一个**内核文件**，具体以类型的数字为文件名定义，分别位于：

内核文件在 **OpenCL** 文件夹下

模块文件在 **src/modules** 文件夹下

读取和载入哈希文件在模块文件函数 **int module_hash_decode** 中

```
int module_hash_decode(...
{
...
  //token.token_cnt  = 2，是后面的附加数据，比如 $salt
  token.token_cnt  = 1;

  token.len_min[0] = 32;
  token.len_max[0] = 32;
  token.attr[0]    = TOKEN_ATTR_VERIFY_LENGTH
                   | TOKEN_ATTR_VERIFY_HEX;
                  
  ...
  //注意这里是 -O 参数，就是优化模式的时候字节是先减去了算法常量比如MD5M_A，在算法实现过程中返回的结果字节最后不需要加常量！
  if (hashconfig->opti_type & OPTI_TYPE_OPTIMIZED_KERNEL)
  {
    digest[0] -= MD5M_A;
    digest[1] -= MD5M_B;
    digest[2] -= MD5M_C;
    digest[3] -= MD5M_D;
  }
...
}
```

具体算法实现是在内核文件中，注意内核文件中这样的转换方法 hc_swap32

```
    const u32x a1 = hc_swap32 (ctx1.h[0]);
    const u32x b1 = hc_swap32 (ctx1.h[1]);
    const u32x c1 = hc_swap32 (ctx1.h[2]);
    const u32x d1 = hc_swap32 (ctx1.h[3]);
```

可以打印字节看结果是否正确
```
printf("\nmd5: %08x %08x %08x %08x \n",hc_swap32(a),hc_swap32(d),hc_swap32(c),hc_swap32(b));
//或者
printf("\nmd5: %08x %08x %08x %08x \n",a,d,c,b);

//打印数据
printf("\nmd5data1: %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x \n",w0_t,w1_t,w2_t,w3_t,w4_t,w5_t,w6_t,w7_t,w8_t,w9_t,wa_t,wb_t,wc_t,wd_t,we_t,wf_t);
```

由于 **hashcat** 会进行自检，在测试中需要加 **--self-test-disable** 选项。检查代码在 **src/hashcat.c** 文件第 **702** 行的 **outer_loop** 函数中的**if**语句块。当然这个检查代码不应该去掉，只需要在算法修改完成后在模块文件中修改正确哈希即可完成自检。

```
static const char *ST_PASS        = "hashcat";
static const char *ST_HASH = "63ec5f6113843f5d229e2d49c068d983a9670d02:57677783202322766743";
```

检查选项函数 **scr/user_options.c -> user_options_check_files**

内核载入函数 **scr/interface.c -> hashconfig_init**

**scr/user_options.c** 第 **2568** 行是载入一个固定模块，具体作用未分析：

```
generate_source_kernel_filename (false, ATTACK_EXEC_OUTSIDE_KERNEL, ATTACK_KERN_STRAIGHT, 400, 0, folder_config->shared_dir, kernelfile);
```

##  当然如果有能力的可以不用修改模块，直接添加模块，我现在还没去详细研究。 ##

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
