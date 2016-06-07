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
  UserInformation.where(user_id: param[:id]).first_or_create
end

# admin permission create

# Theme customization
[
    {id: 1, theme_color: 'blue'}
].each do |param|
  ThemeCustomization.where(id: param[:id]).first_or_create( theme_color: param[:theme_color])
end


[
    {id: 1, name: 'January'},
    {id: 2, name: 'February'},
    {id: 3, name: 'March'},
    {id: 4, name: 'April'},
    {id: 5, name: 'May'},
    {id: 6, name: 'June'},
    {id: 7, name: 'July'},
    {id: 8, name: 'August'},
    {id: 9, name: 'September'},
    {id: 10, name: 'October'},
    {id: 11, name: 'November'},
    {id: 12, name: 'December'}
].each do |param|
  Month.where(id: param[:id], name: param[:name]).first_or_create
end


[
    {id: 2, name: '2016'},
    {id: 3, name: '2017'},
    {id: 4, name: '2018'},
    {id: 5, name: '2019'},
    {id: 6, name: '2020'},
    {id: 7, name: '2021'},
    {id: 8, name: '2022'},
    {id: 9, name: '2023'},
    {id: 10, name: '2024'},
    {id: 11, name: '2025'}
].each do |param|
  Year.where(id: param[:id], name: param[:name]).first_or_create
end


[
    {id: 1, name: 'Demo Name', short_name: 'DN', description: 'some thing'}
].each do |param|
  CompanyInformation.where(id: param[:id]).first_or_create( name: param[:name], short_name: param[:short_name], description: param[:description])
end