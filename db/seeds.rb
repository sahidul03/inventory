# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



# For super admin create
[
    {id: 1, email: 'sahidul03@gmail.com', password: 'asdf@#098', user_type: 1},
    {id: 2, email: 'asad@gmail.com', password: 'asdf@#098', user_type: 1},
    {id: 3, email: 'studentcare@gmail.com', password: 'asdf@#098', user_type: 1},
].each do |param|
  User.where(id: param[:id]).first_or_create( email: param[:email], password: param[:password], user_type: param[:user_type])
  AdminPermission.where(user_id: param[:id]).first_or_create(super_admin: false)
end

# admin permission create

# Theme customization
[
    {id: 1, theme_color: 'blue'}
].each do |param|
  ThemeCustomization.where(id: param[:id]).first_or_create( theme_color: param[:theme_color])
end
