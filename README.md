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
jimakun messages [color_code] [edge_color_code] [thickness] [font_name font_size]

jimakun "Hello World"
jimakun "Red Character" FF0000
jimakun "Blue Edge" FF0000 0000FF

jimakun -f # Show names of font
```

Demo
----

![デモ](https://raw.githubusercontent.com/iyuuya/Jimakun/master/doc/jimakun_demo.gif "Demo")

TODO
----

* リファクタリング
* コマンドラインオプション周辺の整備
* デモちゃんと撮り直す
* ...

Contributing
------------

Bug reports and pull requests are welcome on GitHub at https://github.com/iyuuya/Jimakun.
