echo 'rails new to cache gems, and get secret...'
mkdir app
cd app
#~/.rbenv/shims/rails new app -d postgresql
rails new app -d postgresql
cd app
rake secret > ~/secret
