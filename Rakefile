require 'rake/testtask'
$LOAD_PATH << "lib"

task :console do
  require 'irb'
  require 'irb/completion'
  require 'show_bill'
  ARGV.clear
  IRB.start
end

namespace :test do
  [:unit,:acceptance].each do |test_type|
    Rake::TestTask.new(test_type) do |t|
      t.libs << "lib"
      t.test_files = FileList["test/#{test_type}/**/*_test.rb"]
      t.verbose = true
    end
  end
end
