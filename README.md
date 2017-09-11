# README

## Employee Timesheet Manager [ETM]

ETM is an application that initially could handle timesheet of employees in an organization. The employee details can only be entered in the system by hardcoding. No authentication / authorization has been added to the project. Any user can view  the list of all the employees and edit their profile. Any one can add a timesheet by chosing employee such that total time does not exceed 8 for a particular day. His/her timesheet can also be updated in the future. All the timesheets can be viewed by the employee along with the utilization of the employee in percantage. 

ETM is an improvement of a work done earlier by me which can be found at the link **https://github.com/AparnaVisw/EmployeeTimesheetManager**


## Requirements

Ruby [ruby 2.3.1p112]

Mysql [mysql  Ver 14.14]

Rails [5.1.3]


## SetUp
git clone https://github.com/AparnaVisw/ETM-Code-Improved-.git 

cd ETM-Code-Improved-   

bundle install      

## Setting up local development database 
rails  db:create      
rails db:migrate       

## Running the development server
rails s
 
## Running tests
rspec spec/controllers/timesheets_controller_spec.rb