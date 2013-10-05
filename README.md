Hatena2md
=========

Hatena2md is app to get hatena diary entries in markdown style.

Get all hatena diary entries by [Hatena Atompub](developer.hatena.ne.jp/ja/documents/blog/apis/atom).  
And convert that entries to markdown style by [Pandoc-Ruby](https://github.com/alphabetum/pandoc-ruby).

**You must install [Pandoc](http://johnmacfarlane.net/pandoc/) to use Pandoc-ruby.**

USAGE
-----

Firstly edit auth.yml.
Write Hatena-id and password in auth.yml.

auth.yml
```
id: you
pass: password
```

Next, type follow command.

```
bundle install --path vendor/bundle
bundle exec ruby hatena2md.rb
```

And then you get all hatena diary entries in HTML and Markdown in follow directries.

```
Hatena2md
  \html
  \source
```

License 
----------
Copyright &copy; 2013 kaakaa
Distributed under the terms of [MIT License][mit].

[MIT]: http://www.opensource.org/licenses/mit-license.php
