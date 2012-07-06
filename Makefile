REBAR=./rebar
CODE_DIR=apps/lastock
CT_LOG_DIR=apps/lastock/ctest/*/logs

all:
	${REBAR} compile

gc:
	@echo 'Removing all emacs backup files'
	@find . -name "*~" -exec rm -f {} \;
	@find . -name "erl_crash.dump" -exec rm -f {} \;
	@rm -f {CODE_DIR}/src/*.P
	@rm -f {CODE_DIR}/src/*/*.P
	@rm -f {CODE_DIR}/src/*.beam
	@rm -f {CODE_DIR}/src/*/*.beam
	@echo 'Removing all common_test logs'
	@rm -rf ${CT_LOG_DIR}/*.*
	@rm -f ${CT_LOG_DIR}/variables-ct*

test: all
	@make ct

dialzye: all
	@cd apps/lastock; dialzyer -Wrace_conditions ebin/*.beam
