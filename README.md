Jimakun
=======

About
-----

* MacでTerminalから字幕出すようなツール
* Show a subtitle from Terminal for MacOS/X

Requirements
------------

* Xcode CommandLine Tools

Install
-------

### Homebrew

```sh
$ brew tap iyuuya/Jimakun
$ brew install --HEAD jimakun
```

### Self Build

```sh
$ git clone https://github.com/iyuuya/Jimakun.git
$ cd Jimakun
$ make
```

Usage
-----

```
jimakun [OPTIONS] [MESSAGES]

Set Options:
  -c --color [RRGGBB]      set subtitle color
  -e --edge-color [RRGGBB] set subtitle edge color
  -t --thickness [N]       set thickness(N:0-20)
  -f --font [NAME SIZE]    set font name and size

Helper Options:
  -h --help                show this message
     --font-names        -- show font names
```

Demo
----

![デモ](https://raw.githubusercontent.com/iyuuya/Jimakun/master/doc/jimakun_demo.gif "Demo")

TODO
----

* リファクタリング
* デモちゃんと撮り直す
* ...

Contributing
------------

Bug reports and pull requests are welcome on GitHub at https://github.com/iyuuya/Jimakun.
