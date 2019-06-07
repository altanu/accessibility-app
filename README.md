# Accessibl

Montreal, like most cities across Canada is an aging city with older buildings usually not accessible for people with reduced mobility. There is ongoing work aimed at creating accessibility frameworks and databases at all governmental levels at the moment, and new tools are required to collect, use and understand the data. Drawing inspiration from this emerging need, we built Accessibl as a tool to help individuals with disabilities plan their trips. Accessibl keeps track of which locations have a ramp, accessible bathrooms or reserved parking, so the user knows what to expect when they get to their destination. We have some initial data for the downtown Montreal area sourced from an Accessibility Survey that Concordia Uni has conducted. However, going forward the reviews for locations are user generated and we use the most recent data available to determine if a location is accessible.

### Main Page
![Main Page of Accessibl](https://raw.githubusercontent.com/altanu/accessibility-app/dev/docs/main.png)

### Search Results
![Accessibl Search Results](https://raw.githubusercontent.com/altanu/accessibility-app/dev/docs/searchResults.png)

### Accessibl on Mobile (Tested on Google Pixel XL)
![Accessibl on Mobile](https://raw.githubusercontent.com/altanu/accessibility-app/dev/docs/mobileView.png)

Accessibl was designed to use a high-contrast ratio, and uses built in bootstrap classes for better screen-reader compatibility. It is also reactive, and can be used just as easily on a mobile phone.

Going forward, we will be working on making improvements on the following:

* Implement caching, possibly a separate server to overcome gMaps latency issues
* Implement text-messaging services
* Improve on accessibility following W3C Accessibility Guidelines
* Fully integrate user authentication using JSON Web Tokens
* Implement e-mail verification for users' contacts

## Tech Stack

* Vue.js
* Ruby on Rails (API server)
* Google Maps JS API
* Bootstrap 4
* SASS
* PostgreSQL

## Requirements

* Ruby 2.3.5
* Bundler
* Yarn
* Node.js 11
* Mailgun account

## Testing the development build
1. Clone this repository
2. Run `bundle install` to install gems.
3. Run `rake db:create` followed by `rake db:migrate` to instantatiate the database.
4. Add your Mailgun API information in a `.env` file in the root directory. Refer to `.env-example`
5. Run `rails server` to start the rails api server, hosted at `localhost:3000`
6. Navigate to the `accessibuild-front/` directory and run `yarn`
7. After the modules have installed, run `yarn run serve` to start up the server (This may take a while!)
8. Go to `localhost:8080` to see the page!
