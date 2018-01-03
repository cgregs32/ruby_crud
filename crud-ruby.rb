require 'httparty'
require 'pry'
require 'json'



BASE_URL = "http://json-server.devpointlabs.com/api/v1"


def all_users
  users = HTTParty.get("#{BASE_URL}/users").parsed_response

  #user.keys
  #user.values
  users.each do |user|
    puts "Id #{user['id']}: #{user['first_name']} #{user['last_name']}"
    puts "#{user['phone_number']}"
  end

  start
end



def delete_user
  puts "Delete a User by ID"
  puts "what user would you like to delete?"

  id = gets.to_i

  user = HTTParty.delete("#{BASE_URL}/users/#{id}")

  puts 'User has been deleted'

  start
end

def single_user
  puts 'Enter user Id to view user'

  id = gets.to_i

  user = HTTParty.get("#{BASE_URL}/users/#{id}").parsed_response

  puts "Id #{user['id']}: #{user['first_name']} #{user['last_name']}"
  puts "#{user['phone_number']}"

  start
end


def add_user
  puts "You want to Add a user"
  puts "Enter First Name: "
  first = gets.strip

  puts "Enter Last Name: "
  last = gets.strip

  puts "Enter Phone"
  phone = gets.strip



  user = HTTParty.post("#{BASE_URL}/users",
  {
    body: { 'user[first_name]': first,
             'user[last_name]': last,
              'user[phone_number]': phone }
    }).parsed_response

  puts "Created:"
  puts "Id #{user['id']}: #{user['first_name']} #{user['last_name']}"
  puts "#{user['phone_number']}"

  start
end

def update_user
  puts "Enter ID of uset to update"
  id = gets.to_i

  puts "Enter First Name: "
  first = gets.strip

  puts "Enter Last Name: "
  last = gets.strip

  puts "Enter Phone"
  phone = gets.strip


  user = HTTParty.put("#{BASE_URL}/users/#{id}",
  {
    body: { 'user[first_name]': first,
             'user[last_name]': last,
              'user[phone_number]': phone }
    }).parsed_response

  binding.pry

  puts "Updated:"
  puts "Id #{user['id']}: #{user['first_name']} #{user['last_name']}"
  puts "#{user['phone_number']}"

end


def start
  puts "What would you like to do?"
  puts '1) All Users'
  puts '2) Single User'
  puts '3) Add User'
  puts '4) Delete User'
  puts '5) Update User'


  action = gets.to_i

  case action
    when 1
      all_users
    when 2
      single_user
    when 3
      add_user
    when 4
      delete_user
    when 5
      update_user
    else
      puts 'enter valid res'
      start
  end
end

start
