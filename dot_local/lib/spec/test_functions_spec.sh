# tests for dot_local/bin/functions.sh

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
        # Mock docker command
        docker() { echo "${@}"; }

        It 'should pass arguments to envs'
            When call super-linter FOO=BAR
            The stdout should regexp "-e FOO=BAR"
        End
    End
End
