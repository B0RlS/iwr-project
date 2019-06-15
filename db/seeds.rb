# frozen_string_literal: true

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
