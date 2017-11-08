# config/initializers/carrierwave.rb

CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = ENV["AWS_BUCKET"]
  config.aws_acl    = 'public-read'

  config.aws_credentials = {
    access_key_id:     ENV["AWS_ACCESS_KEY"],
    secret_access_key: ENV["AWS_SECRET_KEY"],
    region:            ENV["AWS_REGION"]
  }

  # These lines fix a bug in development where you get an upload error that says "Errno::ETXTBSY in Instructor::CoursesController#create Text file busy @ unlink_internal"
  # But it breaks resizing in development?  Who knows.
  config.cache_dir = '/tmp/uploads'
  config.root = '/public/uploads/tmp'

end