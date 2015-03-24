use strict;
use warnings;
use Test::More;
use FindBin;

require 'nodebrew';

my $brew_dir = "$FindBin::Bin/.nodebrew";
my $nodebrew_url = 'http://127.0.0.1:8000/nodebrew';
my $bash_completion_url = 'http://127.0.0.1:8000/completions/bash/nodebrew-completion';
my $zsh_completion_url = 'http://127.0.0.1:8000/completions/zsh/_nodebrew';
my $remote_list_url = 'http://127.0.0.1:8000/list.html';
my $fetcher = Nodebrew::Fetcher::get('curl');
my $tarballs = [
    'http://127.0.0.1:8000/tarball',
];
my $tarballs_binary = [
    'http://127.0.0.1:8000/tarball_binary',
];
my $nodebrew = Nodebrew->new(
    brew_dir => $brew_dir,
    nodebrew_url => $nodebrew_url,
    bash_completion_url => $bash_completion_url,
    zsh_completion_url => $zsh_completion_url,
    remote_list_url => $remote_list_url,
    fetcher => $fetcher,
    tarballs => $tarballs,
    tarballs_binary => $tarballs_binary,
);

is $nodebrew->{brew_dir}, $brew_dir;
is $nodebrew->{src_dir}, "$brew_dir/src";
is $nodebrew->{node_dir}, "$brew_dir/node";
is $nodebrew->{iojs_dir}, "$brew_dir/iojs";
is $nodebrew->{current_dir}, "$brew_dir/current";
is $nodebrew->{current}, "$brew_dir/current/node";
is $nodebrew->{default_dir}, "$brew_dir/default";
is $nodebrew->{nodebrew_url}, $nodebrew_url;
is $nodebrew->{bash_completion_url}, $bash_completion_url;
is $nodebrew->{zsh_completion_url}, $zsh_completion_url;
is $nodebrew->{remote_list_url}, $remote_list_url;
is $nodebrew->{fetcher}, $fetcher;
is $nodebrew->{tarballs}, $tarballs;
is $nodebrew->{tarballs_binary}, $tarballs_binary;

eval {
    Nodebrew->new(
        brew_dir => $brew_dir,
        nodebrew_url => $nodebrew_url,
        bash_completion_url => $bash_completion_url,
        zsh_completion_url => $zsh_completion_url,
        remote_list_url => $remote_list_url,
        fetcher => $fetcher,
    );
};

like $@, qr/^required tarballs/;

done_testing;
