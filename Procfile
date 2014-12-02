web: bundle exec rails server thin -p 3000 -e ${RACK_ENV:-development}
api: bundle exec rails server thin -p 3001 --pid=tmp/pids/api_server.pid
