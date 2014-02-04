OpenLETS
========

### Open Source Ruby on Rails Web Application for managing Local Currencies using [Mutual Credit](http://en.wikipedia.org/wiki/Mutual_credit)


## Demos

* [demo.openlets.org](http://demo.openlets.org)
* [demo.openlets.org/admin](http://demo.openlets.org/admin/login)

credentials for logging in to admin:
* email - demo@openlets.org
* pass  - openlets


## Feature List

* Authentication with facebook / linkedin / google
* Authorization  with CanCan
* Create Items for sale
* Purchase Items
* Make a wish
* Fulfill a wish
* Admin panel with market velocity graph, user management, item management
* Admin Settings to determine credit creation / gifts for differenct actions (signup, creating an item etc'...)
* Responsive design with Zurb Foundation 4


## Gems and Tools
* [Ruby on Rails](http://guides.rubyonrails.org)
* [Zurb Foundation 5](http://foundation.zurb.com)
* [Slim](http://slim-lang.com)
* [SCSS](http://sass-lang.com)
* [Simple Form](https://github.com/plataformatec/simple_form)
* [Devise](https://github.com/plataformatec/devise)
* [Active Admin](http://activeadmin.info)


## Installation Instructions For Windows Users

NOTE: If you try installing and encounter problems, please report them for example in Issues. We try to help you and enhance the documentation.

* [Install Git](http://www.git-scm.com)
* [Login to github](https://github.com/)
* [Fork the repo on github](https://help.github.com/articles/fork-a-repo)
* Open the Git Bash command line
* Clone the repository to your computer by typing `git clone git@github.com:[username]/openlets.git`
* Then type `cd openlets` to move into the newly cloned apps folder
* Login to [Heroku](http://heroku.com)
* Install the [Heroku Toolbelt](https://toolbelt.heroku.com)
* You will need to add a credit card to your heroku account in order to be able to use some of the [Heroku SAAS AddOns](https://addons.heroku.com) needed for this app. (which have free plans)
* Login to heroku in your git bash command line (you may need to close and open it after installing the toolbelt) in order to be able to run heroku commands from git bash.
* Create a new app in Heroku by typing `heroku create your_lets_community_name'
* Push the OpenLETS code to heroku by typing `git push heroku master`
* Migrate your database schema by typing `heroku run rake db:migrate`
* Create your database seed data by typing `heroku run rake db:seed`
* Open your newly created app by typing `heroku open`
* Login to the yourapp.herokuapp.com\admin panel with email - 'admin@example.com' - password - 'password'
* Configure your community_name, currency_name and gift amounts by going to Configurations > Settings
* Add the New Relic Heroku Addon (for app performance analytics) by typing `heroku addons:add newrelic`
* In order to configure the New Relic Addon
  * Go to your [Heroku Dashboard](https://dashboard.heroku.com/apps)
  * Click on your app name
  * Click on the New Relic Addon
  * Click "Get Started"
  * Click "Generate License Key"
  * Download the newrelic.yml file to your app/config folder (replacing the existing one)
  * After you do this you will need to commit the changes in git and push them to heroku.
  * Example of committing changes -  `git commit -am "added new relic license key"`
  * RePushing the changes to heroku - `git push heroku master`
  * After pushing your changes to heroku go to the new relic dashboard, click on your app, go to "Settings > Availability Monitoring" and add your application url to monitor.
* Add the Log Entries Heroku Addon (for saving and viewing production logs) by typing `heroku addons:add logentries` 
* Add the Mandrill Heroku Addon (Email SMTP - for sending emails) by typing `heroku addons:add mandrill`
* If you would like to configure a custom domain name - Go to "Settings > Domains" and add you custom domain names (You will also need to [configure your domain DNS](https://devcenter.heroku.com/articles/custom-domains) pointing at your heroku app)
* Set your default "From" email in the 'config/initializers/devise.rb file around line #9
* Set your default "From" email in the 'app/mailers/mailer.rb file around line #2
* Commit your changes and push to heroku

* Login to [AWS](https://aws.amazon.com/) - This app uses [Amazon S3](http://aws.amazon.com/s3/) for uploading and serving images. 
* You will need to add a credit card to your amazon aws account in order to be able to use the S3 service. (although you can use the S3 service for free quit a bit before it starts costing money).
* [Get your aws_key, aws_secret](http://www.cloudberrylab.com/blog/how-to-find-your-aws-access-key-id-and-secret-access-key-and-register-with-cloudberry-s3-explorer/) and put them in the settings.yml file. 
* Edit your AWS bucket name in the settings.yml file.
* Create a Facebook App key and secret at - https://developers.facebook.com/apps and put the credentials in the settings.yml file.
* [Create a Google APP Project](https://cloud.google.com/console/project), Enable Google + API, get yout API Key and Secret and put them in the settings.yml file. After creating the Google Client ID make sure that your "Authorized redirect URI" is "http://youapp.herokuapp.com/users/auth/google_oauth2/callback"
* [Get yout Login with Linkedin Credentials](https://developer.linkedin.com/documents/authentication) and put them in the settings.yml file.
* **IMPORTANT NOTICE** - if you plan to leave your repository public make sure to put all of your keys and secret in [ENVIRONMENT VARIABLES]
  * [How to add ENV Variables Tutorial](http://support.microsoft.com/kb/310519)
  * [How to add ENV Variables to your Heroku app](https://devcenter.heroku.com/articles/config-vars) - Example `heroku config:set OPENLETS_AWS_KEY=123456qwerty`


## Contributing to the development of the OpenLETS Web Application

* [Fork the repo](https://help.github.com/articles/fork-a-repo)
* [Create new branch](http://git-scm.com/book/en/Git-Branching-Basic-Branching-and-Merging) for your changes
* Create a [Pull Request](https://help.github.com/articles/using-pull-requests) to the OpenLETS repo
* The Maintainer will review your changes and merge them if all looks well.


## Contributing to translating OpenLETS 

 - Translate the OpenLETS [web application texts](http://demo.openlets.org) on the [Local translation platform](http://www.localeapp.com/projects/6030).
 - Translate the OpenLETS [website texts](http://www.openlets.org) on the [Local translation platform](http://www.localeapp.com/projects/6030).
- The maintainer will then pull translations from the Locale project and push to Github.


## Contributors

* [Mohit Jain](http://www.codebeerstartups.com/about)
* [social login rails template](https://github.com/mohitjain/social-login-in-rails)
* [Nir Asaf](http://www.linkedin.com/pub/nir-asaf/40/938/74b)
* [Stas Arshanski](http://webbo.co.il/)
* [Lior Vaknin](http://www.linkedin.com/in/liorvaknin)
* [Maxime Dahan](http://www.linkedin.com/pub/maxime-a-dahan/62/9bb/44a)
* [Elan Perach](http://il.linkedin.com/in/elanperach)


## License

The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
