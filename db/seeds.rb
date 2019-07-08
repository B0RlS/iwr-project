# frozen_string_literal: true

manager_params = {
  name: 'manager',
  surname: 'manager',
  email: 'manager@example.com',
  password: '1234567',
  password_confirmation: '1234567',
  role: :manager
 }

UserCreateService.new(manager_params).call
# This file should contain all the record creation needed
# to seed the database with its default values.
# The data can then be loaded with the rails db:seed command
# (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' },
# { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin_params = {
                name: 'admin',
                surname: 'admin',
                email: 'admin@example.com',
                password: '111111',
                password_confirmation: '111111',
                role: :admin
               }

UserCreateService.new(admin_params).call

programming_languages = [
  'ABAP',
  'C#',
  'C/C++',
  'COBOL',
  'Delphi',
  'Flash',
  'Flex',
  'Java',
  'Javascript / HTML / CSS',
  'Perl',
  'PHP',
  'PL / SQL',
  'Python',
  'Ruby',
  'Rust',
  'SQL',
  'VB',
  'XML / XSL / XSLT'
]

programming_languages.each do |prog_lan|
  Skill.where(name: prog_lan, sphere: 'Programming Language').first_or_create
end

operating_systems = [
  'Android',
  'BlackBerry',
  'iOS',
  'Symbian',
  'Unix / Linux / Solaris',
  'Windows',
  'Windows Phone'
]

operating_systems.each do |os_sys|
  Skill.where(name: os_sys, sphere: 'Operating Systems').first_or_create
end

platforms = [
  'AMAZON',
  'ATG',
  'AZURE',
  'COGNOS',
  'DAY',
  'DOCUMENTUM',
  'SAP',
  'SF.com/FORCE',
  'SHAREPOINT',
  'Tibco',
  'WS Commerce'
]

platforms.each do |platf|
  Skill.where(name: platf, sphere: 'Platforms').first_or_create
end

databases = [
  'Microsoft SQL Server',
  'Oracle',
  'PostgreSQL',
  'MySQL',
  'NoSQL',
  'ETL / OLAP / BI / Data Mining'
]

databases.each do |datab|
  Skill.where(name: datab, sphere: 'Database').first_or_create
end

specialties = [
  'Administrative & Finance',
  'Cloud & DevOps',
  'Consulting & Business Analysis',
  'Data Analysis & Digital Strategy',
  'Delivery & Project Management',
  'HR & Talent Acquisition',
  'Management',
  'Sales, Marketing & PR',
  'Service Management and Compliance',
  'Software Architecture',
  'Software Engineering',
  'Software Test Engineering',
  'Training & Coaching',
  'User Experience & Design'
]

specialties.each do |specialty|
  Vacancy::Specialty.where(name: specialty).first_or_create
end
