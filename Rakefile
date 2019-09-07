
desc "Executes pod install and fix files messed up by Cocoapods."
task :install do
sh "bundle exec pod install"
end

desc "Executes pod update and fix files messed up by Cocoapods."
task :update do
sh "bundle exec pod update"
end

desc "Generates Slather Code Coverage Report."
task :slather do
sh "rm -rf ~/Library/Developer/Xcode/DerivedData/*"
sh "rm -rf ~/Library/Developer/CoreSimulator/*"
sh "rm -rf slather-report"
sh "xcodebuild clean build -workspace YouTubeVideos.xcworkspace -scheme YouTubeVideos -destination 'platform=iOS Simulator,name=iPhone SE' VALID_ARCHS=x86_64 test | xcpretty"
sh "bundle exec slather > /dev/null"
sh "open slather-report/index.html > /dev/null"
end

desc "Generates Code Style Report."
task :oclint do
sh "echo oclint ... "
end

