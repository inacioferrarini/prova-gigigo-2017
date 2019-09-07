## About
This project is my evalutation for Company. As it was granted to me creative freedom, I used what made sense for me, taking into consideration, the project size and complexity, avoiding an over complicated and over engineered app, while, at the same time, keeping the project as simple as possible.

## Helpers
This project used some external tooling for helping with project sturtup and 
maintainability.

### Startup
I used my project setup/startup script, https://github.com/inacioferrarini/ios-project-setup to setup the project, template files and so.

### Cocoapods
Used to manage external dependencies. Carthage is an option, but, as I am much more familiar with Cocoapods than Carthage, I've choose Cocoapods.

### Bundler
Grants that all Ruby Gems in use (mainly by external tools written in Ruby) use the versions specified at the Gemfile.

### Rake
Allows me to automate some routine tasks, saving time on future usage.

### Slather
Creates a nice code coverage report.

	### OClint
	Avoids coding style violations.

## External Dependencies / Libraries
### Quick / Nimble
Used to better support Unit tests.

### OHHTTPStubs
Used to mock network requests and better testability.

## Usage
### Generate Code Coverage Report
```{r, engine='bash', count_lines}
rake slather
```

### Generate Code Style Report
```{r, engine='bash', count_lines}
rake oclint
```
