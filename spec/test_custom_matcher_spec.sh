Describe 'custome_matcher.sh'
    setup() { :; }
    teardown() { :; }
    BeforeEach 'setup'
    AfterEach 'teardown'

    Describe 'regexp'
        It 'should regexp'
            When call echo 'abc'
            The output should regexp '[abc]{3}'
        End
        It 'should not regexp'
            When call echo 'abc'
            The output should not regexp '^[def]+$'
        End
    End
    Describe 'regex alias'
        It 'should regex'
            When call echo 'abc'
            The output should regex '[abc]{3}'
        End
        It 'should not regex'
            When call echo 'abc'
            The output should not regex '^[def]+$'
        End
    End
End
