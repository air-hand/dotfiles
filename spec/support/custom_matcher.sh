#shellcheck shell=bash
# custom from https://github.com/shellspec/shellspec/blob/master/examples/spec/support/custom_matcher.sh
shellspec_syntax 'shellspec_matcher_regexp'
shellspec_syntax_alias 'shellspec_matcher_regex' 'shellspec_matcher_regexp'

shellspec_matcher_regexp() {
  shellspec_matcher__match() {
    SHELLSPEC_EXPECT="$1"
    [ "${SHELLSPEC_SUBJECT+x}" ] || return 1
    # bash regex match operator
    [[ $SHELLSPEC_SUBJECT =~ $SHELLSPEC_EXPECT ]] || return 1
    return 0
  }

  # Message when the matcher fails with "should"
  shellspec_matcher__failure_message() {
    shellspec_putsn "expected: $1 match $2"
  }

  # Message when the matcher fails with "should not"
  shellspec_matcher__failure_message_when_negated() {
    shellspec_putsn "expected: $1 not match $2"
  }

  # checking for parameter count
  shellspec_syntax_param count [ $# -eq 1 ] || return 0
  shellspec_matcher_do_match "$@"
}
