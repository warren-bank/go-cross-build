module github.com/go-cross-build

go 1.20

replace golang.org/x/crypto => golang.org/x/crypto v0.33.0
replace golang.org/x/sys => golang.org/x/sys v0.30.0
replace golang.org/x/term => golang.org/x/term v0.29.0
replace golang.org/x/text => golang.org/x/text v0.22.0

require (
	github.com/JohannesEbke/go-imap-sync v0.0.0-20180404203635-6ef4252ff97d
	github.com/emersion/go-imap v1.2.1
	github.com/howeyc/gopass v0.0.0-20210920133722-c8aef6fb66ef
)

require (
	github.com/emersion/go-sasl v0.0.0-20200509203442-7bfe0ed36a21 // indirect
	golang.org/x/crypto v0.38.0 // indirect
	golang.org/x/sys v0.33.0 // indirect
	golang.org/x/term v0.32.0 // indirect
	golang.org/x/text v0.25.0 // indirect
)
