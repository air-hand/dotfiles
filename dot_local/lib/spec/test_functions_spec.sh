# tests for dot_local/lib/functions.sh

Describe 'functions.sh'
    setup() { :; }
    teardown() { :; }
    BeforeEach 'setup'
    AfterEach 'teardown'

    Include ../functions.sh

    Describe 'random_string()'
        It 'should return random string default length.'
            When call random_string
            The output should regexp '^[a-zA-Z0-9]{32}$'
        End
        It 'should return random string 8 length.'
            When call random_string 8
            The output should regexp '^[a-zA-Z0-9]{8}$'
        End
    End

    Describe 'multiline2oneline()'
        It 'should return oneline'
            Data
                #|foo
                #|bar
                #|baz
            End
            When call multiline2oneline
            The output should eq "foo\nbar\nbaz\n"
        End
    End

    Describe 'prepend()'
        Describe 'parameters'
            Parameters
                # prefix expected input
                ',' ',aaa ,bbb ,ccc' "aaa bbb ccc"
                '-e ' '-e aaa=FFF -e bbb -e ccc' 'aaa=FFF' 'bbb' 'ccc'
            End

            It 'should prepend strings with prefix.'
                Data:expand "${@:3}"
                When call prepend "$1"
                The output should eq "$2"
            End
        End

        It 'should echo usage to stderr.'
            When call prepend
            The stderr should regexp "Usage: .* | prepend .+"
            The status should be failure
        End
    End

    Describe 'super-linter()'
        # Stub docker command
        docker() { echo "${@}"; }

        It 'should pass arguments to envs'
            When call super-linter FOO=BAR
            The stdout should regexp "-e FOO=BAR"
        End
    End

    Describe 'is_in_container()'
        It 'should return 0 if in container.'
            # stub /proc/1/cgroup
            cat() {
                if [ "${1:-}" != "/proc/1/cgroup" ]; then
                    command cat "$@"
                    return
                fi
                %text
                #| 2:cpu:/docker/foobarbaz
                #| 1:cpuset:/docker/foobarbaz
                #| 0::/docker/foobarbaz
            }

            When call is_in_container
            The status should be success
        End

        It 'should return 1 if not in container.'
            # stub /proc/1/cgroup
            cat() {
                if [ "${1:-}" != "/proc/1/cgroup" ]; then
                    command cat "$@"
                    return
                fi
                %text
                #| 2:cpu:/
                #| 1:cpuset:/
                #| 0::/init.scope
            }

            When call is_in_container
            The status should be failure
        End
    End
End
