.PHONY: setup xcodegen

default:
	make setup

setup:
	mint bootstrap
	make xcodegen

xcodegen:
	mint run xcodegen@2.32.0 --spec Shared/project.yml
	mint run xcodegen@2.32.0 --spec Auth/project.yml
	mint run xcodegen@2.32.0 --spec Database/project.yml
	mint run xcodegen@2.32.0 --spec Store/project.yml
	mint run xcodegen@2.32.0 --spec App/project.yml