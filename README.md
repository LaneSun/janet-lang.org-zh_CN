# janet-lang.org

[![Zulip](https://img.shields.io/badge/zulip-join_chat-brightgreen.svg)](https://janet.zulipchat.com)

这是 [Janet](https://janet-lang.org) 编程语言网站的源代码。它是一个由 [mendoza](https://github.com/bakpakin/mendoza) 构建的静态网站，mendoza 是一个静态站点生成器。

## 前置条件

使用捆绑的 janet 合并源文件构建此网站。

```sh
git clone https://github.com/janet-lang/janet-lang.org
cd janet-lang.org
make
make run
```

## 构建

要构建，只需使用 `make` 或 `make build`。

## 监视更改

这需要先安装 `inotify-tools`，它可以在大多数 Linux 发行版上轻松安装。要监视更改，请使用 `make watch`。

## 在 localhost:8000 上运行

```
make run
```

## 编写内容

`content` 目录中所有扩展名为 `.mdz` 的页面都将由 mendoza 解析，并转换为同名但扩展名为 `.html` 的 HTML 文件。这种标记语言类似于 Racket 文档工具 [Scribble](https://docs.racket-lang.org/scribble/)，但它当然是用 Janet 编写的，并且是 Janet 的一种方言。更多信息请参见 [mendoza](https://github.com/bakpakin/mendoza)。

请注意，虽然 [`spork` 的文档通过 janet-lang.org](https://janet-lang.org/spork/index.html) 提供，但相应的源文件位于 [spork](https://github.com/janet-lang/spork) 仓库中，因此在某些情况下，最好在那里提交问题和 PR。

## 添加示例

只需在 `examples` 目录中添加一个以绑定名称命名的文件，扩展名为 `.janet`，即可为相应的绑定提供示例。

为了应对某些 Janet 符号的名称中包含对某些文件系统和/或操作系统组合不太友好的字符，使用了一种转义方案。

对于给定的符号，使用 `content/api/examples.janet` 脚本来生成合适的文件名。例如，对于 `array/new`，执行：

```
$ janet content/api/examples.janet array/new
```

应输出：

```
array_47new.janet
```

如果该文件已存在，你可以直接将示例代码追加到现有文件中。

构建站点时，新的示例将包含在生成的文档中。请确保你的示例具有正确的 Janet 语法，因为语法错误将导致整个站点无法构建。如果示例语法有效（使用 `janet -k example/my-fn.janet` 加载时退出码为 0），则可能是 mendoza 的 Janet 语法高亮器存在 bug，你可以在 mendoza 中提交一个 bug。
