require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
# interpret post methods with parameter "_method" with value "delete", "patch" as put

use UsersController
use ProConController
use ListsController
use SessionsController
run ApplicationController
