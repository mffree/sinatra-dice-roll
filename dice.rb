require "puma"
require "rackup"
require "sinatra"
require "sinatra/reloader"

# Getting better errors
require "better_errors"
require "binding_of_caller"
use(BetterErrors::Middleware)
BetterErrors.application_root = __dir__
BetterErrors::Middleware.allow_ip!('0.0.0.0/0.0.0.0')

# get("/") do # root route
#   "Hello world"
# end

get("/zebra") do
  "I'm so excited for dinner and dranks"
end

# 2 6-sided die
get("/dice/2/6") do # get the route
  first_die = rand(1..6) # write out the action
  second_die = rand(1..6)
  sum = first_die + second_die

  @outcome = "You rolled a #{first_die} and a #{second_die} for a total of #{sum}"

  # Replaced with a View Template
  # "<h1>2d6</h1> 
  # <p>#{outcome}<p>" # return the HTML

  # Original View Template call
  # erb(:two_six)
  # With Wrapper call added
  # erb(:two_six, { :layout => :wrapper })
  # Updated back to just erb(:two_six) because we renamed wrapper.erb to layout.erb so it's automatically recognized
  erb(:two_six)


end

# 2 10-sided die
get("/dice/2/10") do
  first_die = rand(1..10)
  second_die = rand(1..10)
  sum = first_die + second_die
  @outcome = "You rolled a #{first_die} and #{second_die}, totalling #{sum}."
  # "<h1>2d10</h1>
  # <p>#{outcome}</p>"
  erb(:two_ten)
end 

# 1 20-sided die
get("/dice/1/20") do
  # die = rand(1..20)
  @die = rand(1..20)
  @outcome = "You rolled a #{@die}."
  # "<h1>1d20</h1>
  # <p>#{outcome}</p>"
  erb(:one_twenty)
end

# 5 4-sided die
get("/dice/5/4") do
  first_die = rand(1..5)
  second_die = rand(1..5)
  third_die = rand(1..5)
  fourth_die = rand(1..5)
  fifth_die = rand(1..5)
  sum = first_die + second_die + third_die + fourth_die + fifth_die
  @outcome = "You rolled a #{first_die}, #{second_die}, #{third_die}, #{fourth_die}, and #{fifth_die} for a total of #{sum}."
  # "<h1>4d5</h1>
  # <p>#{outcome}</p>"
  erb(:five_four)
end

# Original root action before I created the View Template
# get("/") do
#   twod6_path = "/dice/2/6"
#   twod10_path = "/dice/2/10"
#   oned20_path = "/dice/1/20"
#   fived4_path = "/dice/5/4"
  
#   "<h1>Dice Roll</h1>
#   <p>
#     <ul>
#       <li><a href='#{twod6_path}'>Roll two 6-sided dice</li>
#       <li><a href='#{twod10_path}'>Roll two 10-sided dice</li>
#       <li><a href='#{oned20_path}'>Roll one 20-sided die</li>
#       <li><a href='#{fived4_path}'>Roll five 4-sided die</li>
#     </ul>
#   </p>
#   "
# end

# Root action with a View Template
# I first created a view folder
# Then I created the file home.erb
get("/") do
  erb(:home)
end

# Using Silent ERBs to loop
get("/dice/100/6") do
  @rolls = []
  100.times do
    die = rand(1..6)
    @rolls.push(die)
  end
  erb(:one_hundred_six)
end
