require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
# It will help you interpret post methods with parameter "_method" with value "delete" as put

use UsersController
use ProConController
use ListsController
use SessionsController
run ApplicationController
