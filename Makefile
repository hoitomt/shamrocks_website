deploy:
	git push origin master
	git push heroku master
	heroku run bundle exec rake db:migrate
