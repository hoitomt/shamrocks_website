deploy:
	git push origin master
	git push heroku master
	heroku run yarn install
	heroku run bundle exec rake db:migrate
