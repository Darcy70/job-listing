# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "This seed file will automatically create one admin account, 10 jobs been published and another 10 been hiddend "

create_account = User.create([email: 'example@gmail.com', password: '12345678', is_admin: true, is_website_admin: true, name: "Powerful User"])
puts "Admin account has been created "

create_locations = Location.create([{ name: 'Beijing', sort: 1 }, { name: 'Shanghai', sort: 2 }, { name: 'New York', sort: 3 }, { name: 'Tokyo', sort: 4 }, { name: 'Los Angeles', sort: 5 } ])
puts "5 locations created."


create_categorys = Category.create([{ name: 'Technology', icon: 'fa fa-laptop' , sort: 1, is_lock: true }, { name: 'Product', icon: 'fa fa-tasks' , sort: 2, is_lock: true }, { name: 'Design', icon: 'fa fa-photo' , sort: 3, is_lock: true }])
puts "3 categories created."

create_jobs = for i in 1..10 do
  Job.create!([title: "Job No.#{i}", description: " This is the No.#{i} public job been created", contact_email: "JobCreatedBySeedNumber#{i}@example.com",  wage_lower_bound: rand(10..49)*100, wage_upper_bound: rand(50..99)*100, is_hidden: false, company: "No.#{i} company!" ])
end
puts "10 Public jobs have been created. "


create_jobs = for i in 1..10 do
  Job.create!([title: "Job No.#{i}", description: " This is the No.#{i} hidden job been created ", contact_email: "JobCreatedBySeedNumber#{i}@example.com", wage_lower_bound: rand(10..49)*100, wage_upper_bound: rand(50..99)*100, is_hidden: true, company: "No.#{i} company!"])
end
puts "10 Hidden jos have been created. "
