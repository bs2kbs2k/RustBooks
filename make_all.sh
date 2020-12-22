cat scripts/books.txt | xargs -L1 bash scripts/make_book.sh
bash scripts/make_unstable.sh "The Rust Unstable Book(Buggy ToC)" https://github.com/rust-lang/rust.git rust src/doc/unstable-book/src
bash scripts/make_TRPL.sh "The Rust Programming Language" unneeded book-nostarch-second-printing src
