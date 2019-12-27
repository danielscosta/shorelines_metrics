# ShorelinesMetrics

This is an API-only application. To Solve the problem proposed on https://shorelinesoftware.com/software-engineer-interfaces/


## To up the system

Create database 

`$ docker-compose run web mix ecto.create`

To run test and credo

`$ docker-compose run --rm test`

To run coveralls

`$ docker-compose run --rm test mix coveralls`

Run release of the phoenix server:

`$ docker-compose up release`

