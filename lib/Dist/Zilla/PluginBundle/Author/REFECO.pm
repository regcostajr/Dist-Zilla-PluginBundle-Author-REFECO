package Dist::Zilla::PluginBundle::Author::REFECO;
# ABSTRACT: REFECO dists defaults

use strict;
use warnings;

# AUTHORITY
# VERSION

use Moose 2.2206;
use namespace::clean;
use Dist::Zilla 6.030;

with 'Dist::Zilla::Role::PluginBundle::Easy';

=head1 OVERVIEW

This is the default Dist::Zilla release configuration for REFECO

Reproducible by the following dist.ini config:

    [@Filter]
    -bundle = @Basic
    -remove = GatherDir
    -remove = PruneCruft

    [GatherDir]
    exclude_filename = Makefile.PL
    exclude_filename = LICENSE
    exclude_filename = cpanfile
    exclude_filename = INSTALL
    include_dotfiles = 1

    [PruneCruft]

    [CopyFilesFromBuild]
    copy = Makefile.PL
    copy = LICENSE
    copy = cpanfile
    copy = INSTALL

    [OurPkgVersion]
    [Test::Version]

    [Authority]
    authority = cpan:REFECO
    locate_comment = 1

    [InstallGuide]
    [PodWeaver]
    [PerlTidy]

    [ReadmeAnyFromPod / ReadmePodInRoot]
    type = gfm
    filename = README.md
    location = root
    phase = build

    [ReadmeAnyFromPod]
    type = text
    filename = README
    location = build

    [NextRelease]
    [CPANFile]
    [MetaJSON]
    [GithubMeta]
    [Prereqs::AuthorDeps]
    [Test::Compile]
    [Test::CheckDeps]
    [Test::Portability]
    [Test::Legal]
    [Test::Perl::Critic]
    [Test::DistManifest]
    [PodSyntaxTests]
    [MojibakeTests]
    [MetaTests]

=cut

sub configure {

    my $self = shift;

    my @copy = qw(Makefile.PL LICENSE cpanfile INSTALL);

    $self->add_bundle(
        'Filter' => {
            '-bundle' => '@Basic',
            '-remove' => ['GatherDir', 'PruneCruft']});

    $self->add_plugins(    #
        [
            'GatherDir' => {
                exclude_filename => [@copy],
                include_dotfiles => 1
            }
        ],
        ['PruneCruft'         => {except => [qw(.perlcriticrc .perltidyrc)]}],
        ['CopyFilesFromBuild' => {copy   => [@copy]}],
        'OurPkgVersion',
        'Test::Version',
        [
            'Authority' => {
                authority      => 'cpan:REFECO',
                locate_comment => 1
            }
        ],
        'InstallGuide',
        'PodWeaver',
        'PerlTidy',
        [
            'ReadmeAnyFromPod' => 'Git' => {
                filename => 'README.md',
                location => 'root',
                type     => 'gfm',
                phase    => 'build'
            }
        ],
        [
            'ReadmeAnyFromPod' => 'Dist' => {
                filename => 'README',
                location => 'build',
                type     => 'text'
            }
        ],
        'NextRelease',
        'CPANFile',
        'MetaJSON',
        'GithubMeta',
        'Prereqs::AuthorDeps',
        'Test::Compile',
        'Test::CheckDeps',
        'Test::Portability',
        'Test::Legal',
        'Test::Perl::Critic',
        'Test::DistManifest',
        'PodSyntaxTests',
        'MojibakeTests',
        'MetaTests'
    );
}

1;
