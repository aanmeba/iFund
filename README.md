# iFund - Crowdfunding Website

Marketplace app project in Coder Academy

## Links

- [Deployed app - iFund](https://ifund-app.herokuapp.com/)
- [GitHub repo](https://github.com/aanmeba/iFund)

# About iFund

iFund is open to everyone who wants to solicit funds for an idea and charity. This will broaden the target audience and promote more people to participate in projects. iFund is a crowdfunding website for incubating diverse ideas and it requires organisers to only provide detailed ideation and specific plans. Hence, through iFund, project leaders can realise their ideas and move forward.


# Features

- Default images set from AWS S3 bucket based on categories
- Payment with a custom price
- Progress bar for visualising the progress of a project
- Total amount and supporters using **payment complete session** of webhook by Stripe
- User authorisation by enabling the edit / delete action only for the organiser
- Sorting the projects based on due date or progression

# Target audience

The target audience is millennials which are the most likely age group to participate in the crowdfunding campaigns, according to Kickstarter and Indiegogo, the well-known crowdfunding platforms. This age group is more likely to have an expendable income and purchasing power, and know what they want.

# Tech stack

- Ruby on Rails
- html.erb for view
- Bootstrap and additional css/scss for styling
- Javascript for enabling click event for stripe
- Ultrahook for posting stripe session via webhook on local development environment
- Heroku for deployment
- Git / Github for version control
- VS Code for development

# High-level components

### MVC

- Project and Option controllers conduct CRUD (Create, Read, Update, Delete) actions.
- Payment controller proceeds payments and takes the success results to create an entry for Support model.

- Project and Option views require some methods to display the data which users input in particular formats for consistency. To avoid redundancy, the methods are located in Application Helper which can be accessed from both views.
- Project view needs to handle several works; setting default images and the status of the projects, displaying the progress bar. To do so, it uses Project Helper.

- Project and Option models process the data input by users and they need to validate the information in each model file.
- Supporter and Organiser models are inherited by User model to implement the single table inheritance.

### Partial components for across the website

- Two partial components which are used across the website, are the navigation bar and the footer.
- By adding a line of codes in application.html.erb in layouts folder in views, it is set a position of showing alerts including notices or errors. The method which is used in this case is written in the application helper file.
- Since both Project and Option take users' input, they share the validation notice as a partial.

- In Project show pages, the Option area is also partial. Since Option has a separate model and controller, the data shown on the page should be manipulated in Option controller.

### Components used in Project index and show views

- Picture partial contains a simple conditional statement to call default images.
- Badge partial calls methods in project helper file to set the status, while accessing an instance variable in project controller to set the category.
- Progress bar partial includes a control flow to display the bar depending on the result by calling a method to calculate how much funds has been raised so far. And it also has the additional partial file for calculating how many days are left.

# Third party services

### Stripe

Stripe is an online payment processing platform. It allows safe and efficient processing of funds and in this app, this only takes credit card for payment and returns details of the payment to the app server.

From the payment details taken from Stripe using webhook, this app will calculate the total amount that has been raised so far and the total supporters then update the progress bar based on the goal amount.

### AWS

This app utilises AWS S3 Bucket for storing images that users upload during creating project process. This bucket can be accessed only with IAM credentials. In addition, only the default folder in the S3 bucket provides public access to set the default images.

# How to install

```
$ git clone
$ bundle install
$ bundle update
$ yarn install --check-files

# if needed
$ nvm list
$ nvm use 14.xx.x or $ nvm install 14.xx.x

$ rails db:create
# or $ bundle exec rails db:create
$ rails db:migrate
$ rails db:seed

$ rails s
```

Due to the webhook method, you would not be able to complete the payment. If you want to pay, please use the deployed app.

