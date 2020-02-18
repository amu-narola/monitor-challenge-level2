task :deploy do
  system 'zip -r app.zip app.rb vendor test_app samples Rakefile db'
  system 'aws lambda run_application --function-name handler --zip-file fileb://app.zip'
end

